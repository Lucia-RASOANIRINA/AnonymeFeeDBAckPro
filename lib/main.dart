import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app.dart';
import 'core/config/supabase_config.dart';
import 'data/datasources/local/isar_service.dart';
import 'shared/providers/settings_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1) Initialisation Supabase (auth anonyme, realtime, storage).
  await Supabase.initialize(
    url: SupabaseConfig.url,
    anonKey: SupabaseConfig.anonKey,
    // Persiste la session anonyme entre les lancements.
    authOptions: const FlutterAuthClientOptions(
      autoRefreshToken: true,
    ),
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
}
