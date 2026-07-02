import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/sectors.dart';
import '../../../core/localization/app_strings.dart';
import '../providers/home_search_provider.dart';

/// Résultats de la recherche intelligente affichés directement dans l'accueil.
///
/// Combine deux sources :
///  - les **secteurs** dont le libellé correspond (filtrage local instantané) ;
///  - les **établissements** correspondants récupérés depuis Supabase.
class HomeSearchResults extends ConsumerWidget {
  const HomeSearchResults({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppStrings.of(context);
    final query = ref.watch(homeSearchQueryProvider).trim().toLowerCase();
    final results = ref.watch(establishmentSearchProvider);

    // Secteurs correspondants (recherche locale sur le libellé traduit).
    final matchingSectors = Sectors.all
        .where((s) => t.t(s.labelKey).toLowerCase().contains(query))
        .toList();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (matchingSectors.isNotEmpty) ...[
            Text(t.t('categories'),
                style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final s in matchingSectors)
                  ActionChip(
                    avatar: Icon(s.icon, size: 18, color: s.color),
                    label: Text(t.t(s.labelKey)),
                    onPressed: () => context.push(
                      '/feedback',
                      extra: {'sectorId': s.id},
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
          ],
          Text(t.t('establishments'),
              style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          results.when(
            loading: () => const Padding(
              padding: EdgeInsets.all(24),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (e, _) => Padding(
              padding: const EdgeInsets.all(16),
              child: Text('$e', style: const TextStyle(color: Colors.red)),
            ),
            data: (items) {
              if (items.isEmpty && matchingSectors.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Center(
                    child: Column(
                      children: [
                        const Icon(Icons.search_off,
                            size: 48, color: Colors.grey),
                        const SizedBox(height: 8),
                        Text(t.t('no_results'),
                            style: const TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                );
              }
              if (items.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(t.t('no_results'),
                      style: const TextStyle(color: Colors.grey)),
                );
              }
              return Column(
                children: [
                  for (final e in items)
                    Card(
                      child: ListTile(
                        leading: const Icon(Icons.place_outlined),
                        title: Text(e['name']?.toString() ?? ''),
                        subtitle: Text(
                          [e['sector_id'], e['address']]
                              .where((x) => x != null && '$x'.isNotEmpty)
                              .join(' · '),
                        ),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => context.push('/feedback', extra: {
                          'establishmentId': e['id']?.toString(),
                          'establishmentName': e['name']?.toString(),
                          'sectorId': e['sector_id']?.toString(),
                        }),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
