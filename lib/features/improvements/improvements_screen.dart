import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/localization/app_strings.dart';
import '../../data/datasources/remote/supabase_service.dart';

/// Données de secours avec des images en ligne
final List<Map<String, dynamic>> _fallbackImprovements = [
  {
    'id': 'fallback-1',
    'title': 'Rénovation de la cantine scolaire',
    'description': 'La cantine du Lycée Andohalo a été entièrement rénovée avec de nouveaux équipements et plus de places assises.',
    'before_photo_url': 'https://images.unsplash.com/photo-1580582932707-520aed937b7b?w=400&h=300&fit=crop',
    'after_photo_url': 'https://images.unsplash.com/photo-1580582932707-520aed937b7b?w=400&h=300&fit=crop&sat=-100&bright=20',
    'published_at': DateTime.now().subtract(const Duration(days: 5)).toIso8601String(),
    'establishment': {
      'name': 'Lycée Andohalo',
      'sector_id': 'education',
    },
  },
  {
    'id': 'fallback-2',
    'title': 'Nouveau système de suivi des bus',
    'description': 'Un écran d\'affichage en temps réel a été installé à la gare routière de Mahamasina.',
    'before_photo_url': 'https://images.unsplash.com/photo-1570125909232-eb263c188f7e?w=400&h=300&fit=crop',
    'after_photo_url': 'https://images.unsplash.com/photo-1570125909232-eb263c188f7e?w=400&h=300&fit=crop&sat=-100&bright=20',
    'published_at': DateTime.now().subtract(const Duration(days: 2)).toIso8601String(),
    'establishment': {
      'name': 'Gare routière de Mahamasina',
      'sector_id': 'transport',
    },
  },
  {
    'id': 'fallback-3',
    'title': 'Réduction du temps d\'attente',
    'description': 'Le CHU Joseph Ravoahangy a recruté 5 nouveaux infirmiers pour réduire le temps d\'attente.',
    'before_photo_url': 'https://images.unsplash.com/photo-1588776814546-1ffcf47267a5?w=400&h=300&fit=crop',
    'after_photo_url': 'https://images.unsplash.com/photo-1588776814546-1ffcf47267a5?w=400&h=300&fit=crop&sat=-100&bright=20',
    'published_at': DateTime.now().subtract(const Duration(days: 7)).toIso8601String(),
    'establishment': {
      'name': 'CHU Joseph Ravoahangy',
      'sector_id': 'health',
    },
  },
  {
    'id': 'fallback-4',
    'title': 'Modernisation du marché',
    'description': 'Le Marché d\'Andravoahangy a été modernisé avec de nouveaux étals et un système de prix affichés.',
    'before_photo_url': 'https://images.unsplash.com/photo-1556909114-44e7eef05324?w=400&h=300&fit=crop',
    'after_photo_url': 'https://images.unsplash.com/photo-1556909114-44e7eef05324?w=400&h=300&fit=crop&sat=-100&bright=20',
    'published_at': DateTime.now().subtract(const Duration(days: 3)).toIso8601String(),
    'establishment': {
      'name': 'Marché d\'Andravoahangy',
      'sector_id': 'commerce',
    },
  },
  {
    'id': 'fallback-5',
    'title': 'Nouveau système de gestion des déchets',
    'description': 'La Mairie d\'Antananarivo a mis en place un nouveau système de collecte des déchets.',
    'before_photo_url': 'https://images.unsplash.com/photo-1532996122725-e3c354a0b15b?w=400&h=300&fit=crop',
    'after_photo_url': 'https://images.unsplash.com/photo-1532996122725-e3c354a0b15b?w=400&h=300&fit=crop&sat=-100&bright=20',
    'published_at': DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
    'establishment': {
      'name': 'Mairie d\'Antananarivo',
      'sector_id': 'administration',
    },
  },
  {
    'id': 'fallback-6',
    'title': 'Amélioration de l\'accès à l\'eau potable',
    'description': 'Installation de 3 nouveaux points d\'eau potable dans le quartier d\'Andohalo.',
    'before_photo_url': 'https://images.unsplash.com/photo-1544829099-b9a0c074d091?w=400&h=300&fit=crop',
    'after_photo_url': 'https://images.unsplash.com/photo-1544829099-b9a0c074d091?w=400&h=300&fit=crop&sat=-100&bright=20',
    'published_at': DateTime.now().subtract(const Duration(days: 4)).toIso8601String(),
    'establishment': {
      'name': 'Service des Eaux',
      'sector_id': 'water',
    },
  },
  {
    'id': 'fallback-7',
    'title': 'Installation de l\'éclairage public',
    'description': 'Nouveaux lampadaires solaires installés dans les quartiers périphériques.',
    'before_photo_url': 'https://images.unsplash.com/photo-1558981806-ec527fa84c39?w=400&h=300&fit=crop',
    'after_photo_url': 'https://images.unsplash.com/photo-1558981806-ec527fa84c39?w=400&h=300&fit=crop&sat=-100&bright=20',
    'published_at': DateTime.now().subtract(const Duration(days: 6)).toIso8601String(),
    'establishment': {
      'name': 'Mairie d\'Antananarivo',
      'sector_id': 'administration',
    },
  },
  {
    'id': 'fallback-8',
    'title': 'Rénovation du terrain de sport',
    'description': 'Le terrain de sport du Lycée Andohalo a été entièrement rénové avec un nouveau gazon synthétique.',
    'before_photo_url': 'https://images.unsplash.com/photo-1574629810360-7efbbe195018?w=400&h=300&fit=crop',
    'after_photo_url': 'https://images.unsplash.com/photo-1574629810360-7efbbe195018?w=400&h=300&fit=crop&sat=-100&bright=20',
    'published_at': DateTime.now().subtract(const Duration(days: 8)).toIso8601String(),
    'establishment': {
      'name': 'Lycée Andohalo',
      'sector_id': 'education',
    },
  },
];

/// Provider des améliorations publiées avec fallback
final improvementsProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  try {
    final data = await ref.read(supabaseServiceProvider).fetchImprovements();
    if (data.isNotEmpty) {
      return data;
    }
    return _fallbackImprovements;
  } catch (_) {
    return _fallbackImprovements;
  }
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
                  Center(child: Text(t.t('improvements'))),
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