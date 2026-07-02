import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/constants/sectors.dart';
import '../../core/localization/app_strings.dart';
import '../../data/models/feedback_local.dart';
import '../../data/repositories/feedback_repository.dart';
import '../../shared/providers/sync_provider.dart';

/// Historique personnel des feedbacks (lu depuis Isar, donc dispo hors ligne).
class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  Future<void> _resyncAll(BuildContext context, WidgetRef ref) async {
    final messenger = ScaffoldMessenger.of(context);
    messenger.showSnackBar(
      const SnackBar(content: Text('Resynchronisation en cours…')),
    );
    try {
      await ref.read(syncControllerProvider.notifier).resyncAll();
      if (!context.mounted) return;
      messenger.showSnackBar(
        const SnackBar(content: Text('Historique resynchronisé avec Supabase.')),
      );
    } catch (e) {
      if (!context.mounted) return;
      messenger.showSnackBar(
        SnackBar(content: Text('Échec de la resynchronisation : $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppStrings.of(context);
    final history = ref.watch(feedbackHistoryProvider);
    final syncing = ref.watch(syncControllerProvider) == SyncState.syncing;

    return Scaffold(
      appBar: AppBar(
        title: Text(t.t('history')),
        actions: [
          IconButton(
            tooltip: 'Tout resynchroniser',
            onPressed: syncing ? null : () => _resyncAll(context, ref),
            icon: syncing
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.cloud_sync_outlined),
          ),
        ],
      ),
      body: history.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (items) {
          if (items.isEmpty) {
            return Center(child: Text(t.t('history')));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: items.length,
            itemBuilder: (_, i) => _HistoryTile(item: items[i]),
          );
        },
      ),
    );
  }
}

class _HistoryTile extends StatelessWidget {
  const _HistoryTile({required this.item});
  final FeedbackLocal item;

  @override
  Widget build(BuildContext context) {
    final t = AppStrings.of(context);
    final sector = Sectors.byId(item.sectorId);
    final df = DateFormat.yMMMd().add_Hm();

    final (icon, color) = switch (item.syncStatus) {
      LocalSyncStatus.synced => (Icons.cloud_done, Colors.green),
      LocalSyncStatus.syncing => (Icons.sync, Colors.blue),
      LocalSyncStatus.error => (Icons.error_outline, Colors.red),
      LocalSyncStatus.pending => (Icons.cloud_upload_outlined, Colors.orange),
    };

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              (sector?.color ?? Colors.grey).withValues(alpha: 0.15),
          child: Icon(sector?.icon ?? Icons.help_outline, color: sector?.color),
        ),
        title: Text(
          item.establishmentName ??
              (sector != null ? t.t(sector.labelKey) : '—'),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${(item.ratingNormalized / 20).toStringAsFixed(1)}/5 · '
                'code ${item.anonCode}'),
            Text(df.format(item.createdAt),
                style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 4),
            Row(children: [
              _StatusChip(status: item.status),
              if (item.priority) ...[
                const SizedBox(width: 6),
                const Icon(Icons.priority_high, size: 16, color: Colors.red),
              ],
            ]),
          ],
        ),
        trailing: Tooltip(
          message: item.syncStatus.name,
          child: Icon(icon, color: color, size: 20),
        ),
        isThreeLine: true,
      ),
    );
  }
}

/// Pastille de statut de suivi (Reçu / En cours / Résolu).
class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});
  final FeedbackStatus status;

  @override
  Widget build(BuildContext context) {
    final t = AppStrings.of(context);
    final (label, color) = switch (status) {
      FeedbackStatus.submitted => (t.t('status_submitted'), Colors.blueGrey),
      FeedbackStatus.inProgress => (t.t('status_in_progress'), Colors.orange),
      FeedbackStatus.resolved => (t.t('status_resolved'), Colors.green),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label,
          style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600)),
    );
  }
}
