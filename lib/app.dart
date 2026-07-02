import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/localization/app_strings.dart';
import 'core/localization/fallback_localizations.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'shared/providers/settings_provider.dart';
import 'shared/providers/sync_provider.dart';

/// Racine de l'application. Réagit instantanément au changement de langue,
/// de thème et des options d'accessibilité via le [settingsProvider].
class FeedbackProApp extends ConsumerWidget {
  const FeedbackProApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final router = ref.watch(appRouterProvider);

    // Active le contrôleur de synchro dès le lancement.
    ref.watch(syncControllerProvider);

    return MaterialApp.router(
      title: 'FeedbackPro',
      debugShowCheckedModeBanner: false,
      routerConfig: router,

      // --- Thème (clair / sombre / contraste élevé) ---
      theme: AppTheme.light(highContrast: settings.highContrast),
      darkTheme: AppTheme.dark(highContrast: settings.highContrast),
      themeMode: settings.themeMode,

      // --- Localisation instantanée ---
      locale: settings.locale,
      supportedLocales: AppStrings.supportedLocales,
      localizationsDelegates: const [
        AppStringsDelegate(),
        // Repli mg -> fr pour les libellés système (doit passer AVANT les
        // délégués globaux pour intercepter le malgache).
        FallbackMaterialLocalizationsDelegate(),
        FallbackCupertinoLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // Repli : si la locale n'est pas supportée par les délégués Material
      // (ex. mg), on retombe sur le français.
      localeResolutionCallback: (locale, supported) {
        if (locale != null &&
            AppStrings.supportedLocales
                .any((l) => l.languageCode == locale.languageCode)) {
          return locale;
        }
        return const Locale('fr');
      },

      // --- Accessibilité : mise à l'échelle du texte ---
      builder: (context, child) {
        final mq = MediaQuery.of(context);
        return MediaQuery(
          data: mq.copyWith(
            textScaler: TextScaler.linear(settings.textScale),
          ),
          child: child!,
        );
      },
    );
  }
}
