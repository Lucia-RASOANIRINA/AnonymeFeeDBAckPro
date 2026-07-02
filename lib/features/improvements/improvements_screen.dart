import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/localization/app_strings.dart';
import '../../data/datasources/remote/supabase_service.dart';

/// Provider des améliorations publiées (données réelles Supabase uniquement).
final improvementsProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) async {
  // Cache : réafficher la page est instantané (RefreshIndicator invalide).
  ref.keepAlive();
  return ref.read(supabaseServiceProvider).fetchImprovements();
});

/// Page publique présentant les actions prises (avant / après).
class ImprovementsScreen extends ConsumerWidget {
  const ImprovementsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppStrings.of(context);
    final data = ref.watch(improvementsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(t.t('improvements'))),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(improvementsProvider),
        child: data.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => ListView(children: [Center(child: Text('$e'))]),
          data: (items) {
            if (items.isEmpty) {
              return ListView(
                children: [
                  const SizedBox(height: 120),
                  const Icon(Icons.published_with_changes,
                      size: 64, color: Colors.grey),
                  const SizedBox(height: 12),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        t.t('no_improvements'),
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: items.length,
              itemBuilder: (_, i) => _ImprovementCard(row: items[i]),
            );
          },
        ),
      ),
    );
  }
}

class _ImprovementCard extends StatelessWidget {
  const _ImprovementCard({required this.row});
  final Map<String, dynamic> row;

  @override
  Widget build(BuildContext context) {
    final title = row['title'] as String? ?? '';
    final description = row['description'] as String? ?? '';
    final before = row['before_photo_url'] as String?;
    final after = row['after_photo_url'] as String?;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 6),
            Text(description),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _Photo(label: 'Avant', url: before)),
                const SizedBox(width: 8),
                Expanded(child: _Photo(label: 'Après', url: after)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Photo extends StatelessWidget {
  const _Photo({required this.label, required this.url});
  final String label;
  final String? url;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: AspectRatio(
            aspectRatio: 4 / 3,
            child: url == null || url!.isEmpty
                ? Container(
                    color: Colors.black12,
                    child: const Center(
                      child: Icon(Icons.image_not_supported, color: Colors.grey),
                    ),
                  )
                : CachedNetworkImage(
                    imageUrl: url!,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(
                      color: Colors.black12,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (_, __, ___) => Container(
                      color: Colors.black12,
                      child: const Center(
                        child: Icon(Icons.broken_image_outlined, color: Colors.grey),
                      ),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}