/// Constantes partagées (clés de stockage, routes nommées, etc.).
class AppConstants {
  AppConstants._();

  // Clés de préférences locales (SharedPreferences).
  static const String prefLocaleCode = 'pref_locale_code';
  static const String prefThemeMode = 'pref_theme_mode';
  static const String prefHighContrast = 'pref_high_contrast';
  static const String prefTextScale = 'pref_text_scale';

  // Statuts de synchronisation d'un feedback local.
  static const String syncPending = 'pending';
  static const String syncSynced = 'synced';
  static const String syncError = 'error';

  // Statuts de modération côté serveur.
  static const String modNew = 'new';
  static const String modValidated = 'validated';
  static const String modHidden = 'hidden';
  static const String modResolved = 'resolved';
}
