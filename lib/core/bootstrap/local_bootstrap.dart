// Barrel conditionnel de l'amorçage de la base locale.
// - Mobile/desktop : ouvre Isar et fournit l'override isarProvider.
// - Web : aucune base locale (online-only), overrides vides.
export 'local_bootstrap_web.dart' if (dart.library.io) 'local_bootstrap_io.dart';
