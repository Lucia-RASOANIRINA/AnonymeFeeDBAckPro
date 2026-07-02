import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/app_constants.dart';

/// État global des préférences utilisateur (langue, thème, accessibilité).
@immutable
class AppSettings {
  final Locale locale;
  final ThemeMode themeMode;
  final bool highContrast;
  final double textScale;

  const AppSettings({
    this.locale = const Locale('mg'), // malgache prioritaire par défaut
    this.themeMode = ThemeMode.system,
    this.highContrast = false,
    this.textScale = 1.0,
  });

  AppSettings copyWith({
    Locale? locale,
    ThemeMode? themeMode,
    bool? highContrast,
    double? textScale,
  }) {
    return AppSettings(
      locale: locale ?? this.locale,
      themeMode: themeMode ?? this.themeMode,
      highContrast: highContrast ?? this.highContrast,
      textScale: textScale ?? this.textScale,
    );
  }
}

/// Provider de l'instance SharedPreferences (initialisée dans main()).
final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError('Override dans main()'),
);

/// Notifier persistant des préférences. Le changement de langue est instantané :
/// modifier l'état déclenche le rebuild de MaterialApp via le provider.
class SettingsNotifier extends Notifier<AppSettings> {
  @override
  AppSettings build() {
    final prefs = ref.read(sharedPreferencesProvider);
    return AppSettings(
      locale: Locale(prefs.getString(AppConstants.prefLocaleCode) ?? 'mg'),
      themeMode: _themeFromString(prefs.getString(AppConstants.prefThemeMode)),
      highContrast: prefs.getBool(AppConstants.prefHighContrast) ?? false,
      textScale: prefs.getDouble(AppConstants.prefTextScale) ?? 1.0,
    );
  }

  SharedPreferences get _prefs => ref.read(sharedPreferencesProvider);

  void setLocale(Locale locale) {
    _prefs.setString(AppConstants.prefLocaleCode, locale.languageCode);
    state = state.copyWith(locale: locale);
  }

  void setThemeMode(ThemeMode mode) {
    _prefs.setString(AppConstants.prefThemeMode, mode.name);
    state = state.copyWith(themeMode: mode);
  }

  void setHighContrast(bool value) {
    _prefs.setBool(AppConstants.prefHighContrast, value);
    state = state.copyWith(highContrast: value);
  }

  void setTextScale(double value) {
    _prefs.setDouble(AppConstants.prefTextScale, value);
    state = state.copyWith(textScale: value);
  }

  static ThemeMode _themeFromString(String? value) {
    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}

final settingsProvider =
    NotifierProvider<SettingsNotifier, AppSettings>(SettingsNotifier.new);
