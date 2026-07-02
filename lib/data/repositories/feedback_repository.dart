import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../../core/config/app_config.dart';
import '../../core/config/supabase_config.dart';
import '../datasources/local/isar_service.dart';
import '../datasources/remote/supabase_service.dart';
import '../models/feedback_local.dart';

/// Repository offline-first des feedbacks.
///
/// Règle d'or : on écrit TOUJOURS d'abord dans Isar (instantané, marche hors
/// ligne), puis on tente la synchro vers Supabase. L'UI lit depuis Isar.
class FeedbackRepository {
  FeedbackRepository(this._isar, this._supabase);

  final Isar _isar;
  final SupabaseService _supabase;
  static const _uuid = Uuid();

  /// Crée un feedback localement. Retourne l'objet sauvegardé (statut pending).
  Future<FeedbackLocal> createLocal({
    required String sectorId,
    String? establishmentId,
    String? establishmentName,
    required int ratingRaw,
    required RatingType ratingType,
    String? comment,
    String? suggestion,
    List<String> localPhotoPaths = const [],
    String? localVideoPath,
    bool isCritical = false,
    String? problemDetails,
    List<String> problemTypes = const [],
    bool hasLocation = false,
    double? latitude,
    double? longitude,
    String? locationLabel,
  }) async {
    final fb = FeedbackLocal()
      ..localUuid = _uuid.v4()
      ..sectorId = sectorId
      ..establishmentId = establishmentId
      ..establishmentName = establishmentName
      ..ratingRaw = ratingRaw
      ..ratingType = ratingType
      ..ratingNormalized = _normalizeRating(ratingRaw, ratingType)
      ..comment = comment
      ..suggestion = suggestion
      ..isCritical = isCritical
      ..problemDetails = problemDetails
      ..problemTypes = problemTypes
      ..localPhotoPaths = localPhotoPaths
      ..localVideoPath = localVideoPath
      // Un problème critique passe le feedback en priorité dès la création.
      ..priority = isCritical
      ..status = FeedbackStatus.submitted
      ..hasLocation = hasLocation
      ..latitude = latitude
      ..longitude = longitude
      ..locationLabel = locationLabel
      ..anonCode = _generateAnonCode()
      ..createdAt = DateTime.now()
      ..syncStatus = LocalSyncStatus.pending;

    await _isar.writeTxn(() async {
      await _isar.feedbackLocals.put(fb);
    });
    return fb;
  }

  /// Liste les feedbacks de l'appareil, plus récents d'abord (historique perso).
  Stream<List<FeedbackLocal>> watchHistory() {
    return _isar.feedbackLocals
        .where()
        .sortByCreatedAtDesc()
        .watch(fireImmediately: true);
  }

  Future<List<FeedbackLocal>> pendingItems() {
    return _isar.feedbackLocals
        .filter()
        .syncStatusEqualTo(LocalSyncStatus.pending)
        .findAll();
  }

  /// Pousse tous les feedbacks en attente vers Supabase.
  /// Sûr à appeler de façon répétée (idempotent via localUuid côté serveur).
  Future<void> syncPending() async {
    final pending = await pendingItems();
    for (final fb in pending) {
      try {
        await _markStatus(fb, LocalSyncStatus.syncing);

        // 1) Upload des photos compressées (si présentes).
        final urls = <String>[];
        for (final path in fb.localPhotoPaths) {
          final compressed = await _compress(path);
          if (compressed == null) continue;
          final remotePath =
              '${fb.localUuid}/${DateTime.now().millisecondsSinceEpoch}.jpg';
          final url = await _supabase.uploadPhoto(
            SupabaseConfig.feedbackPhotosBucket,
            remotePath,
            compressed,
          );
          urls.add(url);
        }

        // 2) Insertion de la ligne. Aucune donnée identifiante n'est envoyée.
        final inserted = await _supabase.insertFeedback({
          'client_uuid': fb.localUuid,
          'sector_id': fb.sectorId,
          'establishment_id': fb.establishmentId,
          'rating_normalized': fb.ratingNormalized,
          'rating_raw': fb.ratingRaw,
          'rating_type': fb.ratingType.name,
          'comment': fb.comment,
          'suggestion': fb.suggestion,
          'is_critical': fb.isCritical,
          'problem_details': fb.problemDetails,
          'problem_types': fb.problemTypes,
          'priority': fb.priority,
          'photo_urls': urls,
          'has_location': fb.hasLocation,
          'latitude': fb.latitude,
          'longitude': fb.longitude,
          'anon_code': fb.anonCode,
        });

        // 3) Mise à jour locale.
        await _isar.writeTxn(() async {
          fb
            ..serverId = inserted['id']?.toString()
            ..remotePhotoUrls = urls
            ..syncStatus = LocalSyncStatus.synced
            ..lastSyncError = null;
          await _isar.feedbackLocals.put(fb);
        });
      } catch (e) {
        await _markStatus(fb, LocalSyncStatus.error, error: e.toString());
      }
    }
  }

  Future<void> _markStatus(
    FeedbackLocal fb,
    LocalSyncStatus status, {
    String? error,
  }) async {
    await _isar.writeTxn(() async {
      fb
        ..syncStatus = status
        ..lastSyncError = error;
      await _isar.feedbackLocals.put(fb);
    });
  }

  /// Compresse une image pour limiter l'usage de bande passante.
  Future<Uint8List?> _compress(String path) async {
    if (!File(path).existsSync()) return null;
    final dir = await getTemporaryDirectory();
    final target = '${dir.path}/c_${DateTime.now().microsecondsSinceEpoch}.jpg';
    final result = await FlutterImageCompress.compressAndGetFile(
      path,
      target,
      quality: AppConfig.imageCompressQuality,
      minWidth: AppConfig.imageMaxDimension,
      minHeight: AppConfig.imageMaxDimension,
    );
    if (result == null) return null;
    return result.readAsBytes();
  }

  /// Normalise toutes les échelles sur 0-100 pour les statistiques.
  static int _normalizeRating(int raw, RatingType type) {
    switch (type) {
      case RatingType.stars:
      case RatingType.smiley:
        return (raw.clamp(1, 5) / 5 * 100).round();
      case RatingType.scale:
        return (raw.clamp(1, 10) / 10 * 100).round();
    }
  }

  /// Code anonyme court et lisible pour le suivi sans compte (ex : FB-7H3K9).
  static String _generateAnonCode() {
    final raw = _uuid.v4().replaceAll('-', '').toUpperCase();
    return 'FB-${raw.substring(0, 5)}';
  }
}

final feedbackRepositoryProvider = Provider<FeedbackRepository>((ref) {
  return FeedbackRepository(
    ref.read(isarProvider),
    ref.read(supabaseServiceProvider),
  );
});

/// Stream de l'historique local pour l'UI.
final feedbackHistoryProvider =
    StreamProvider<List<FeedbackLocal>>((ref) {
  return ref.read(feedbackRepositoryProvider).watchHistory();
});
