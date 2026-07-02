import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../data/datasources/remote/supabase_service.dart';

/// État de l'authentification anonyme.
enum AnonAuthState { unknown, authenticating, authenticated, failedOffline }

/// Gère l'authentification ANONYME uniquement (aucun email/téléphone/nom).
///
/// Au premier lancement on appelle `signInAnonymously()`. La session est ensuite
/// persistée par supabase_flutter. Si l'appareil est hors ligne au tout premier
/// lancement, on reste en mode local : les feedbacks sont stockés dans Isar et
/// l'authentification sera retentée à la prochaine connexion.
class AuthNotifier extends Notifier<AnonAuthState> {
  @override
  AnonAuthState build() {
    final client = ref.read(supabaseClientProvider);
    return client.auth.currentSession != null
        ? AnonAuthState.authenticated
        : AnonAuthState.unknown;
  }

  SupabaseClient get _client => ref.read(supabaseClientProvider);

  /// Assure qu'une session anonyme existe. Idempotent.
  Future<void> ensureAnonymousSession() async {
    if (_client.auth.currentSession != null) {
      state = AnonAuthState.authenticated;
      return;
    }
    state = AnonAuthState.authenticating;
    try {
      // Timeout strict : on ne laisse JAMAIS un appel réseau bloquer le
      // démarrage. En cas d'échec/lenteur, on bascule en mode local.
      await _client.auth
          .signInAnonymously()
          .timeout(const Duration(seconds: 8));
      state = AnonAuthState.authenticated;
    } catch (_) {
      // Hors ligne, lenteur, ou auth anonyme non activée côté Supabase :
      // on continue en mode local offline-first.
      state = AnonAuthState.failedOffline;
    }
  }

  String? get userId => _client.auth.currentUser?.id;
}

final authProvider =
    NotifierProvider<AuthNotifier, AnonAuthState>(AuthNotifier.new);
