import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/datasources/remote/supabase_service.dart';

/// État de l'authentification anonyme.
enum AnonAuthState { unknown, authenticating, authenticated, failedOffline }

/// FeedbackPro fonctionne SANS authentification : les feedbacks sont insérés
/// directement (rôle `anon` / clé publique), autorisés par la policy RLS
/// `for insert to public`. La lecture/modération reste réservée aux admins.
///
/// On n'appelle plus `signInAnonymously()` : l'auth anonyme peut être désactivée
/// côté projet (elle renvoyait alors une erreur 422 sur /auth/v1/signup), et
/// surtout une tentative échouée laissait l'en-tête d'autorisation dans un état
/// bancal qui faisait ensuite échouer l'insertion (401). Envoi direct = fiable.
class AuthNotifier extends Notifier<AnonAuthState> {
  @override
  AnonAuthState build() => AnonAuthState.authenticated;

  /// No-op conservé pour compatibilité des appelants (splash, synchro).
  /// Aucune session n'est nécessaire pour insérer un feedback anonyme.
  Future<void> ensureAnonymousSession() async {
    state = AnonAuthState.authenticated;
  }

  String? get userId =>
      ref.read(supabaseClientProvider).auth.currentUser?.id;
}

final authProvider =
    NotifierProvider<AuthNotifier, AnonAuthState>(AuthNotifier.new);
