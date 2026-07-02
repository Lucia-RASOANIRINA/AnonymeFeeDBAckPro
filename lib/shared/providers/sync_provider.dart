import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/connectivity_service.dart';
import '../../data/repositories/feedback_repository.dart';
import '../../features/auth/providers/auth_provider.dart';

/// État global de synchro affiché dans l'UI.
enum SyncState { idle, syncing, done, offline }

/// Orchestre la synchronisation offline-first.
///
/// - écoute la connectivité ; dès qu'on repasse en ligne, lance [sync]
/// - s'assure qu'une session anonyme existe avant de pousser vers Supabase
class SyncController extends Notifier<SyncState> {
  @override
  SyncState build() {
    // Réagit aux changements de connectivité.
    ref.listen(connectivityProvider, (prev, next) {
      final online = next.asData?.value ?? false;
      if (online) {
        sync();
      } else {
        state = SyncState.offline;
      }
    });
    return SyncState.idle;
  }

  Future<void> sync() async {
    if (state == SyncState.syncing) return;
    state = SyncState.syncing;
    try {
      await ref.read(authProvider.notifier).ensureAnonymousSession();
      await ref.read(feedbackRepositoryProvider).syncPending();
      state = SyncState.done;
    } catch (_) {
      state = SyncState.offline;
    }
  }
}

final syncControllerProvider =
    NotifierProvider<SyncController, SyncState>(SyncController.new);

/// Nombre de feedbacks en attente de synchro (badge UI).
final pendingCountProvider = FutureProvider<int>((ref) async {
  // Se rafraîchit quand l'historique change.
  ref.watch(feedbackHistoryProvider);
  final items = await ref.read(feedbackRepositoryProvider).pendingItems();
  return items.length;
});
