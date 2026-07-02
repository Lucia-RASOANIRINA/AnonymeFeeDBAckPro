import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app.dart';
import 'core/config/supabase_config.dart';
import 'core/error/error_handler.dart';
import 'core/error/startup_error_app.dart';
import 'core/utils/app_logger.dart';
import 'data/datasources/local/isar_service.dart';
import 'shared/providers/settings_provider.dart';

Future<void> main() async {
  // Toutes les exceptions (init, framework, async) sont capturées ici.
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    ErrorHandler.install();

    try {
      // 1) Initialisation Supabase (auth anonyme, realtime, storage).
      await Supabase.initialize(
        url: SupabaseConfig.url,
        anonKey: SupabaseConfig.anonKey,
        authOptions: const FlutterAuthClientOptions(autoRefreshToken: true),
      );

      // 2) Base locale offline-first.
      final isar = await IsarService.open();

      // 3) Préférences (langue, thème).
      final prefs = await SharedPreferences.getInstance();

      runApp(
        ProviderScope(
          overrides: [
            isarProvider.overrideWithValue(isar),
            sharedPreferencesProvider.overrideWithValue(prefs),
          ],
          child: const FeedbackProApp(),
        ),
      );
    } catch (e, stack) {
      // Un échec d'initialisation ne doit pas laisser un écran noir : on
      // affiche un message clair et un bouton « Réessayer ».
      AppLogger.error('Échec de l’initialisation', e, stack);
      runApp(StartupErrorApp(message: ErrorHandler.humanize(e)));
    }
  }, (error, stack) {
    AppLogger.error('Exception non capturée (zone)', error, stack);
  });
}
