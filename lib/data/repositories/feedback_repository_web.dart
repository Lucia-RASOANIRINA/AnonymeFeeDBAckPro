import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../datasources/remote/supabase_service.dart';
import '../models/feedback_models.dart';
import 'feedback_repository.dart';

/// Implémentation WEB (online-only) du repository.
///
/// Le web n'a pas Isar : l'historique est gardé en mémoire pour la session, et
/// chaque feedback est poussé directement vers Supabase. La logique de statut
/// de synchro est conservée pour une UI identique au mobile.
class WebFeedbackRepository implements FeedbackRepository {
  WebFeedbackRepository(this._supabase);

  final SupabaseService _supabase;
  static const _uuid = Uuid();

  final List<FeedbackLocal> _items = [];
  final _controller = StreamController<List<FeedbackLocal>>.broadcast();

  void _emit() {
    final sorted = [..._items]
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    _controller.add(sorted);
  }

  @override
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
      ..priority = isCritical
      ..status = FeedbackStatus.submitted
      ..hasLocation = hasLocation
      ..latitude = latitude
      ..longitude = longitude
      ..locationLabel = locationLabel
      ..anonCode = _generateAnonCode()
      ..createdAt = DateTime.now()
      ..syncStatus = LocalSyncStatus.pending;

    _items.add(fb);
    _emit();
    // Sur le web on tente la synchro immédiatement (online-only).
    unawaited(syncPending());
    return fb;
  }

  @override
  Stream<List<FeedbackLocal>> watchHistory() async* {
    yield [..._items]..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    yield* _controller.stream;
  }

  @override
  Future<List<FeedbackLocal>> pendingItems() async {
    return _items
        .where((f) => f.syncStatus != LocalSyncStatus.synced)
        .toList();
  }

  @override
  Future<void> syncPending() async {
    for (final fb in await pendingItems()) {
      try {
        fb.syncStatus = LocalSyncStatus.syncing;
        _emit();
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
          'photo_urls': <String>[],
          'has_location': fb.hasLocation,
          'latitude': fb.latitude,
          'longitude': fb.longitude,
          'anon_code': fb.anonCode,
        });
        fb
          ..serverId = inserted['id']?.toString()
          ..syncStatus = LocalSyncStatus.synced
          ..lastSyncError = null;
        _emit();
      } on PostgrestException catch (e) {
        if (e.code == '23505') {
          fb.syncStatus = LocalSyncStatus.synced;
        } else {
          fb
            ..syncStatus = LocalSyncStatus.error
            ..lastSyncError = e.message;
        }
        _emit();
      } catch (e) {
        fb
          ..syncStatus = LocalSyncStatus.error
          ..lastSyncError = e.toString();
        _emit();
      }
    }
  }

  @override
  Future<void> forceResyncAll() async {
    for (final fb in _items) {
      fb
        ..serverId = null
        ..syncStatus = LocalSyncStatus.pending
        ..lastSyncError = null;
    }
    _emit();
    await syncPending();
  }

  static int _normalizeRating(int raw, RatingType type) {
    switch (type) {
      case RatingType.stars:
      case RatingType.smiley:
        return (raw.clamp(1, 5) / 5 * 100).round();
      case RatingType.scale:
        return (raw.clamp(1, 10) / 10 * 100).round();
    }
  }

  static String _generateAnonCode() {
    final raw = _uuid.v4().replaceAll('-', '').toUpperCase();
    return 'FB-${raw.substring(0, 5)}';
  }
}

/// Fabrique appelée par le provider (voir feedback_repository.dart).
FeedbackRepository createFeedbackRepository(Ref ref) =>
    WebFeedbackRepository(ref.read(supabaseServiceProvider));
