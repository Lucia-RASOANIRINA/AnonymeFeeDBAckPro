import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/feedback_models.dart';
// Implémentation choisie à la compilation : Isar sur mobile, en mémoire sur web.
import 'feedback_repository_web.dart'
    if (dart.library.io) 'feedback_repository_io.dart' as impl;

/// Contrat du repository de feedbacks (offline-first sur mobile, online-only
/// sur web). L'UI ne dépend que de cette interface.
abstract class FeedbackRepository {
  Future<FeedbackLocal> createLocal({
    required String sectorId,
    String? establishmentId,
    String? establishmentName,
    required int ratingRaw,
    required RatingType ratingType,
    String? comment,
    String? suggestion,
    List<String> localPhotoPaths,
    String? localVideoPath,
    bool isCritical,
    String? problemDetails,
    List<String> problemTypes,
    bool hasLocation,
    double? latitude,
    double? longitude,
    String? locationLabel,
  });

  /// Historique des feedbacks de l'appareil, plus récents d'abord.
  Stream<List<FeedbackLocal>> watchHistory();

  /// Éléments non synchronisés (pending / error / syncing).
  Future<List<FeedbackLocal>> pendingItems();

  /// Pousse les feedbacks non synchronisés vers Supabase.
  Future<void> syncPending();

  /// Re-synchronise TOUT l'historique (après changement de projet Supabase).
  Future<void> forceResyncAll();
}

/// Fournit l'implémentation adaptée à la plateforme.
final feedbackRepositoryProvider = Provider<FeedbackRepository>(
  (ref) => impl.createFeedbackRepository(ref),
);

/// Stream de l'historique local pour l'UI.
final feedbackHistoryProvider = StreamProvider<List<FeedbackLocal>>((ref) {
  return ref.read(feedbackRepositoryProvider).watchHistory();
});
