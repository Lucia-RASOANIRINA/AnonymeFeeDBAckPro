import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/localization/app_strings.dart';
import '../../../core/utils/location_helper.dart';
import '../providers/feedback_form_provider.dart';

/// Section localisation optionnelle : interrupteur d'activation + carte
/// interactive (OpenStreetMap via flutter_map — libre, léger, sans clé API).
class LocationSection extends ConsumerStatefulWidget {
  const LocationSection({super.key});

  @override
  ConsumerState<LocationSection> createState() => _LocationSectionState();
}

class _LocationSectionState extends ConsumerState<LocationSection> {
  bool _loading = false;
  final _mapController = MapController();

  Future<void> _enable() async {
    setState(() => _loading = true);
    try {
      final pos = await LocationHelper.getCurrentPosition();
      ref
          .read(feedbackFormProvider.notifier)
          .setLocation(pos.latitude, pos.longitude);
      _mapController.move(LatLng(pos.latitude, pos.longitude), 16);
    } on LocationException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_messageFor(e.code))),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  String _messageFor(String code) {
    final t = AppStrings.of(context);
    return t.t('scan_permission_denied'); // message générique de permission
  }

  @override
  Widget build(BuildContext context) {
    final t = AppStrings.of(context);
    final form = ref.watch(feedbackFormProvider);

    return Card(
      child: Column(
        children: [
          SwitchListTile(
            secondary: const Icon(Icons.location_on_outlined),
            title: Text(t.t('add_location')),
            subtitle: Text(form.hasLocation
                ? t.t('location_added')
                : t.t('location_help')),
            value: form.hasLocation,
            onChanged: (v) {
              if (v) {
                _enable();
              } else {
                ref.read(feedbackFormProvider.notifier).clearLocation();
              }
            },
          ),
          if (_loading) const LinearProgressIndicator(),
          // Carte interactive : l'utilisateur peut affiner le point en glissant.
          if (form.hasLocation && form.latitude != null)
            SizedBox(
              height: 200,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(16),
                ),
                child: FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: LatLng(form.latitude!, form.longitude!),
                    initialZoom: 16,
                    onTap: (_, point) {
                      ref
                          .read(feedbackFormProvider.notifier)
                          .setLocation(point.latitude, point.longitude);
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.feedbackpro.app',
                      // Faible bande passante : un seul niveau de tuiles.
                      maxZoom: 18,
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: LatLng(form.latitude!, form.longitude!),
                          width: 40,
                          height: 40,
                          child: const Icon(Icons.location_pin,
                              color: Colors.red, size: 40),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
