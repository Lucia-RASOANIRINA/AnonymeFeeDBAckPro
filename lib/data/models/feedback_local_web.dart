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

  /// Sérialisation pour la persistance localStorage (web).
  Map<String, dynamic> toJson() => {
        'localUuid': localUuid,
        'serverId': serverId,
        'establishmentId': establishmentId,
        'establishmentName': establishmentName,
        'sectorId': sectorId,
        'ratingNormalized': ratingNormalized,
        'ratingRaw': ratingRaw,
        'ratingType': ratingType.name,
        'comment': comment,
        'suggestion': suggestion,
        'isCritical': isCritical,
        'problemDetails': problemDetails,
        'problemTypes': problemTypes,
        'status': status.name,
        'priority': priority,
        'hasLocation': hasLocation,
        'latitude': latitude,
        'longitude': longitude,
        'locationLabel': locationLabel,
        'anonCode': anonCode,
        'createdAt': createdAt.toIso8601String(),
        'syncStatus': syncStatus.name,
        'lastSyncError': lastSyncError,
      };

  static FeedbackLocal fromJson(Map<String, dynamic> j) => FeedbackLocal()
    ..localUuid = j['localUuid'] as String
    ..serverId = j['serverId'] as String?
    ..establishmentId = j['establishmentId'] as String?
    ..establishmentName = j['establishmentName'] as String?
    ..sectorId = j['sectorId'] as String? ?? 'other'
    ..ratingNormalized = (j['ratingNormalized'] as num?)?.toInt() ?? 0
    ..ratingRaw = (j['ratingRaw'] as num?)?.toInt() ?? 0
    ..ratingType = RatingType.values.byName(j['ratingType'] as String? ?? 'stars')
    ..comment = j['comment'] as String?
    ..suggestion = j['suggestion'] as String?
    ..isCritical = j['isCritical'] as bool? ?? false
    ..problemDetails = j['problemDetails'] as String?
    ..problemTypes = (j['problemTypes'] as List?)?.cast<String>() ?? []
    ..status = FeedbackStatus.values.byName(j['status'] as String? ?? 'submitted')
    ..priority = j['priority'] as bool? ?? false
    ..hasLocation = j['hasLocation'] as bool? ?? false
    ..latitude = (j['latitude'] as num?)?.toDouble()
    ..longitude = (j['longitude'] as num?)?.toDouble()
    ..locationLabel = j['locationLabel'] as String?
    ..anonCode = j['anonCode'] as String? ?? ''
    ..createdAt =
        DateTime.tryParse(j['createdAt'] as String? ?? '') ?? DateTime.now()
    ..syncStatus =
        LocalSyncStatus.values.byName(j['syncStatus'] as String? ?? 'pending')
    ..lastSyncError = j['lastSyncError'] as String?;
}
