/// Paramètres globaux de l'application, ajustés pour les appareils Android
/// d'entrée de gamme et les connexions à faible bande passante.
class AppConfig {
  AppConfig._();

  static const String appName = 'FeedbackPro';

  /// Qualité de compression des photos (0-100). Bas = plus léger pour l'upload.
  static const int imageCompressQuality = 55;

  /// Largeur/hauteur max des photos après compression (px).
  static const int imageMaxDimension = 1080;

  /// Intervalle minimal entre deux tentatives de synchronisation (secondes).
  static const int syncMinIntervalSeconds = 15;

  /// Nombre maximum de photos par feedback.
  static const int maxPhotosPerFeedback = 3;

  /// Nom de la box Isar (base locale offline-first).
  static const String isarInstanceName = 'feedbackpro_local';

  /// Code PIN d'accès rapide au tableau de bord admin depuis le mobile
  /// (accès caché). En production, à remplacer par une vraie auth/biométrie.
  static const String adminPin = '1707';
}
