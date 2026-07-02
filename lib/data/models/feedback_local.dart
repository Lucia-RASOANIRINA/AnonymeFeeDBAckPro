import 'package:isar_community/isar.dart';

part 'feedback_local.g.dart';

/// Type d'échelle de notation choisie pour un feedback.
enum RatingType {
  stars, // 1-5 étoiles
  scale, // 1-10
  smiley, // 1-5 smileys
}

/// Statut de synchronisation local.
enum LocalSyncStatus {
  pending, // créé hors ligne, à envoyer
  syncing,
  synced,
  error,
}

/// Statut de traitement d'un feedback (suivi V2 côté admin).
enum FeedbackStatus {
  submitted, // reçu
  inProgress, // en cours de traitement
  resolved, // résolu
}

/// Collection Isar : un feedback stocké localement (offline-first).
///
/// C'est la source de vérité locale. Un worker de synchronisation pousse les
/// éléments `pending` vers Supabase puis met à jour [serverId] et [syncStatus].
@collection
class FeedbackLocal {
  Id id = Isar.autoIncrement;

  /// UUID généré côté client pour l'idempotence de la synchro.
  @Index(unique: true, replace: true)
  late String localUuid;

  /// Id côté serveur (null tant que non synchronisé).
  String? serverId;

  /// Établissement / service ciblé (peut venir d'un scan QR).
  String? establishmentId;
  String? establishmentName;

  /// Secteur (health, education, ...).
  @Index()
  late String sectorId;

  /// Note normalisée 0-100 pour comparer toutes les échelles entre elles.
  late int ratingNormalized;

  /// Valeur brute saisie (ex : 4 étoiles, 8/10).
  late int ratingRaw;

  @Enumerated(EnumType.name)
  late RatingType ratingType;

  String? comment;
  String? suggestion;

  // ---- V2 : logique conditionnelle ----
  /// Problème jugé grave/critique par l'utilisateur (déclenche photo requise +
  /// alerte prioritaire côté admin).
  bool isCritical = false;

  /// Détails du problème (requis si note basse).
  String? problemDetails;

  /// Types de problèmes cochés (ex : accueil, hygiène, attente...).
  List<String> problemTypes = [];

  /// Chemins LOCAUX des photos compressées (avant upload).
  List<String> localPhotoPaths = [];

  /// URLs des photos une fois uploadées sur Supabase Storage.
  List<String> remotePhotoUrls = [];

  // ---- V2 : pièces jointes étendues ----
  /// Vidéo courte compressée (chemin local puis URL distante).
  String? localVideoPath;
  String? remoteVideoUrl;

  // ---- V2 : suivi de statut / priorité ----
  @Enumerated(EnumType.name)
  FeedbackStatus status = FeedbackStatus.submitted;

  bool priority = false;

  // Localisation optionnelle.
  bool hasLocation = false;
  double? latitude;
  double? longitude;
  String? locationLabel;

  /// Code anonyme permettant à l'utilisateur de suivre/répondre sans compte.
  late String anonCode;

  @Index()
  late DateTime createdAt;

  @Enumerated(EnumType.name)
  @Index()
  LocalSyncStatus syncStatus = LocalSyncStatus.pending;

  /// Message d'erreur de la dernière tentative de synchro (debug).
  String? lastSyncError;
}
