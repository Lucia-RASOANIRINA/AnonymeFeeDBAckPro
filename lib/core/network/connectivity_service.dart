import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Expose l'état réseau sous forme de stream booléen (en ligne / hors ligne).
/// Utilisé par la couche de synchronisation offline-first.
final connectivityProvider = StreamProvider<bool>((ref) {
  final connectivity = Connectivity();
  return connectivity.onConnectivityChanged.map(_isOnline);
});

/// État instantané (utile au démarrage avant le premier événement du stream).
final isOnlineProvider = FutureProvider<bool>((ref) async {
  final result = await Connectivity().checkConnectivity();
  return _isOnline(result);
});

bool _isOnline(List<ConnectivityResult> results) {
  return results.any((r) =>
      r == ConnectivityResult.mobile ||
      r == ConnectivityResult.wifi ||
      r == ConnectivityResult.ethernet ||
      r == ConnectivityResult.vpn);
}
