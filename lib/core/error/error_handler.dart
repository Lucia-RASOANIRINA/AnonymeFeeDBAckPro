import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../theme/app_colors.dart';
import '../utils/app_logger.dart';

/// Installe la capture globale des exceptions (framework + zone) et un widget
/// d'erreur sobre à la place de l'écran rouge par défaut.
class ErrorHandler {
  ErrorHandler._();

  static void install() {
    // Erreurs remontées par le framework Flutter (build, layout, gestes…).
    FlutterError.onError = (FlutterErrorDetails details) {
      if (kDebugMode) FlutterError.presentError(details);
      AppLogger.error('FlutterError', details.exception, details.stack);
    };

    // Erreurs asynchrones non capturées au niveau du moteur.
    PlatformDispatcher.instance.onError = (error, stack) {
      AppLogger.error('Exception non capturée', error, stack);
      return true;
    };

    // Remplace l'écran rouge par un encart lisible (aussi en release).
    ErrorWidget.builder = (FlutterErrorDetails details) =>
        _InlineError(message: humanize(details.exception));
  }

  /// Traduit une exception technique en message clair pour l'utilisateur.
  static String humanize(Object error) {
    if (error is AuthException) {
      return 'Problème d’authentification : ${error.message}';
    }
    if (error is PostgrestException) {
      // Clé API invalide / projet injoignable, RLS, etc.
      if (error.code == 'PGRST301' || error.message.contains('JWT')) {
        return 'Accès refusé par la base de données (clé ou droits invalides).';
      }
      return 'Erreur de la base de données : ${error.message}';
    }
    if (error is StorageException) {
      return 'Erreur de stockage des fichiers : ${error.message}';
    }
    if (error is SocketException || error is TimeoutException) {
      return 'Pas de connexion au serveur. Vérifiez votre réseau.';
    }
    return 'Une erreur inattendue est survenue. Réessayez.';
  }
}

class _InlineError extends StatelessWidget {
  const _InlineError({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, color: AppColors.primary, size: 48),
              const SizedBox(height: 12),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
