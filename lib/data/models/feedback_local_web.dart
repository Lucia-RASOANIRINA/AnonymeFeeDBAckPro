// Version WEB des modèles locaux : classes simples SANS Isar.
//
// Isar est une base MOBILE uniquement et son code généré ne compile pas en
// JavaScript. Sur le web, l'application fonctionne en mode « online-only » :
// pas de persistance locale Isar, les feedbacks partent directement vers
// Supabase. L'API publique est IDENTIQUE à la version mobile
// (data/models/feedback_local.dart) pour que l'UI soit la même.

/// Type d'échelle de notation choisie pour un feedback.
enum RatingType { stars, scale, smiley }

/// Statut de synchronisation local.
enum LocalSyncStatus { pending, syncing, synced, error }

/// Statut de traitement d'un feedback (suivi côté admin).
enum FeedbackStatus { submitted, inProgress, resolved }

/// Feedback « local » (version web, en mémoire uniquement).
class FeedbackLocal {
  int id = 0;
  late String localUuid;
  String? serverId;
  String? establishmentId;
  String? establishmentName;
  late String sectorId;
  late int ratingNormalized;
  late int ratingRaw;
  late RatingType ratingType;
  String? comment;
  String? suggestion;
  bool isCritical = false;
  String? problemDetails;
  List<String> problemTypes = [];
  List<String> localPhotoPaths = [];
  List<String> remotePhotoUrls = [];
  String? localVideoPath;
  String? remoteVideoUrl;
  FeedbackStatus status = FeedbackStatus.submitted;
  bool priority = false;
  bool hasLocation = false;
  double? latitude;
  double? longitude;
  String? locationLabel;
  late String anonCode;
  late DateTime createdAt;
  LocalSyncStatus syncStatus = LocalSyncStatus.pending;
  String? lastSyncError;
}
