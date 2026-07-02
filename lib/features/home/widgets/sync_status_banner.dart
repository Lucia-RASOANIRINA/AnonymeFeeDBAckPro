import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/localization/app_strings.dart';
import '../../../core/network/connectivity_service.dart';
import '../../../shared/providers/sync_provider.dart';

/// Bandeau discret indiquant l'état hors-ligne / synchronisation.
class SyncStatusBanner extends ConsumerWidget {
  const SyncStatusBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppStrings.of(context);
    final online = ref.watch(connectivityProvider).value ?? true;
    final syncState = ref.watch(syncControllerProvider);
    final pending = ref.watch(pendingCountProvider).value ?? 0;

    if (online && syncState != SyncState.syncing && pending == 0) {
      return const SizedBox.shrink();
    }

    final scheme = Theme.of(context).colorScheme;
    late final IconData icon;
    late final String label;
    late final Color bg;

    if (!online) {
      icon = Icons.cloud_off;
      label = '${t.t('offline')} · $pending ${t.t('pending_sync')}';
      bg = scheme.errorContainer;
    } else if (syncState == SyncState.syncing) {
      icon = Icons.sync;
      label = t.t('syncing');
      bg = scheme.secondaryContainer;
    } else {
      icon = Icons.cloud_upload_outlined;
      label = '$pending ${t.t('pending_sync')}';
      bg = scheme.secondaryContainer;
    }

    return Container(
      width: double.infinity,
      color: bg,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }
}
