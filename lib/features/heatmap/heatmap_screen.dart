import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../core/constants/sectors.dart';
import '../../core/error/error_handler.dart';
import '../../data/datasources/remote/supabase_service.dart';

/// Points géolocalisés pour la carte de chaleur (établissements publics, et
/// feedbacks si l'utilisateur est admin — sinon RLS filtre).
final heatPointsProvider =
    FutureProvider<List<_HeatPoint>>((ref) async {
  final service = ref.read(supabaseServiceProvider);
  final points = <_HeatPoint>[];

  // Établissements (lecture publique).
  for (final e in await service.fetchEstablishments()) {
    final lat = (e['latitude'] as num?)?.toDouble();
    final lng = (e['longitude'] as num?)?.toDouble();
    if (lat == null || lng == null) continue;
    points.add(_HeatPoint(
      LatLng(lat, lng),
      sectorId: e['sector_id'] as String?,
      critical: false,
    ));
  }

  // Feedbacks géolocalisés (visibles seulement pour un admin).
  try {
    for (final f in await service.fetchFeedbacks(limit: 500)) {
      final lat = (f['latitude'] as num?)?.toDouble();
      final lng = (f['longitude'] as num?)?.toDouble();
      if (lat == null || lng == null) continue;
      points.add(_HeatPoint(
        LatLng(lat, lng),
        sectorId: f['sector_id'] as String?,
        critical: f['is_critical'] == true,
      ));
    }
  } catch (_) {
    // Session non-admin : pas de feedbacks, on garde les établissements.
  }

  return points;
});

class _HeatPoint {
  _HeatPoint(this.pos, {this.sectorId, this.critical = false});
  final LatLng pos;
  final String? sectorId;
  final bool critical;

  Color get color =>
      critical ? Colors.red : (Sectors.byId(sectorId ?? '')?.color ?? Colors.orange);
}

/// Carte de chaleur des problèmes / établissements géolocalisés.
class HeatmapScreen extends ConsumerWidget {
  const HeatmapScreen({super.key});

  // Centre par défaut : Antananarivo, Madagascar.
  static const _fallbackCenter = LatLng(-18.8792, 47.5079);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(heatPointsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carte de chaleur'),
        actions: [
          IconButton(
            onPressed: () => ref.invalidate(heatPointsProvider),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(ErrorHandler.humanize(e))),
        data: (points) {
          final center = points.isNotEmpty ? points.first.pos : _fallbackCenter;
          return FlutterMap(
            options: MapOptions(
              initialCenter: center,
              initialZoom: points.isEmpty ? 5 : 12,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.feedbackpro.feedbackpro',
              ),
              // Effet de chaleur : halos translucides superposés.
              CircleLayer(
                circles: [
                  for (final p in points)
                    CircleMarker(
                      point: p.pos,
                      radius: p.critical ? 26 : 18,
                      useRadiusInMeter: false,
                      color: p.color.withValues(alpha: 0.25),
                      borderColor: p.color.withValues(alpha: 0.5),
                      borderStrokeWidth: 1,
                    ),
                ],
              ),
              MarkerLayer(
                markers: [
                  for (final p in points)
                    Marker(
                      point: p.pos,
                      width: 16,
                      height: 16,
                      child: Icon(Icons.circle, size: 12, color: p.color),
                    ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
