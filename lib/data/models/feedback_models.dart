// Barrel conditionnel des modèles de feedback.
//
// - Mobile / desktop (dart.library.io disponible) : version Isar
//   (data/models/feedback_local.dart).
// - Web (pas de dart.library.io) : version simple sans Isar
//   (feedback_local_web.dart), car Isar ne compile pas en JavaScript.
//
// Tout le code de l'app importe CE fichier plutôt que feedback_local.dart
// directement, afin d'être compilable sur les deux plateformes.
export 'feedback_local_web.dart' if (dart.library.io) 'feedback_local.dart';
