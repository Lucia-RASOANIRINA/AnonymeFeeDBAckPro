import 'package:geolocator/geolocator.dart';

/// Résultat de récupération de position.
class LocationResult {
  final double latitude;
  final double longitude;
  const LocationResult(this.latitude, this.longitude);
}

/// Helper de géolocalisation : gère les permissions et l'activation du service.
class LocationHelper {
  LocationHelper._();

  /// Demande la position courante. Lève une [LocationException] explicite.
  static Future<LocationResult> getCurrentPosition() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw const LocationException('service_disabled');
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw const LocationException('permission_denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      throw const LocationException('permission_denied_forever');
    }

    final pos = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        // Timeout pour ne pas bloquer sur les appareils lents / signal faible.
        timeLimit: Duration(seconds: 15),
      ),
    );
    return LocationResult(pos.latitude, pos.longitude);
  }
}

class LocationException implements Exception {
  final String code;
  const LocationException(this.code);
  @override
  String toString() => 'LocationException($code)';
}
