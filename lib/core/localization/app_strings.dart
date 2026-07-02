import 'package:flutter/widgets.dart';

/// Localisation légère basée sur des Map, pour un changement de langue
/// INSTANTANÉ (piloté par un provider Riverpod) sans rebuild d'app coûteux
/// ni génération de code. Idéal pour le malgache qui n'est pas toujours bien
/// couvert par les outils ARB.
///
/// Langues : mg (Malagasy, prioritaire), fr (Français), en (English).
class AppStrings {
  final Locale locale;
  const AppStrings(this.locale);

  static const List<Locale> supportedLocales = [
    Locale('mg'),
    Locale('fr'),
    Locale('en'),
  ];

  static const Map<String, Map<String, String>> _values = {
    // ---- Général ----
    'app_name': {
      'mg': 'AnonyFeedback Pro',
      'fr': 'AnonyFeedback Pro',
      'en': 'AnonyFeedback Pro'
    },
    'tagline': {
      'mg': "Hevitra tsy fantatra anarana ho an'ny tsenavin'asam-bahoaka",
      'fr': 'Retours anonymes pour de meilleurs services publics',
      'en': 'Anonymous feedback for better public services',
    },
    'continue_': {'mg': 'Hanohy', 'fr': 'Continuer', 'en': 'Continue'},
    'cancel': {'mg': 'Aoka', 'fr': 'Annuler', 'en': 'Cancel'},
    'send': {'mg': 'Alefa', 'fr': 'Envoyer', 'en': 'Send'},
    'save': {'mg': 'Tehirizo', 'fr': 'Enregistrer', 'en': 'Save'},
    'retry': {'mg': 'Andramo indray', 'fr': 'Réessayer', 'en': 'Retry'},
    'loading': {'mg': 'Eo am-pakàna...', 'fr': 'Chargement...', 'en': 'Loading...'},
    'optional': {'mg': '(tsy voatery)', 'fr': '(optionnel)', 'en': '(optional)'},

    // ---- Navigation ----
    'home': {'mg': 'Fandraisana', 'fr': 'Accueil', 'en': 'Home'},
    'history': {'mg': 'Tantara', 'fr': 'Historique', 'en': 'History'},
    'improvements': {'mg': 'Fanatsarana', 'fr': 'Améliorations', 'en': 'Improvements'},
    'no_improvements': {
      'mg': 'Mbola tsy misy fanatsarana navoaka. Miverena atý aoriana.',
      'fr': 'Aucune amélioration publiée pour le moment. Revenez bientôt.',
      'en': 'No improvements published yet. Check back soon.',
    },
    'settings': {'mg': 'Kirakira', 'fr': 'Paramètres', 'en': 'Settings'},

    // ---- Accueil ----
    'search_hint': {
      'mg': 'Hitady toerana na sampan-draharaha...',
      'fr': 'Rechercher un établissement ou service...',
      'en': 'Search an establishment or service...',
    },
    'categories': {'mg': 'Sokajy', 'fr': 'Catégories', 'en': 'Categories'},
    'scan_qr': {'mg': 'Tsindrio ny QR', 'fr': 'Scanner un QR', 'en': 'Scan QR'},
    'give_feedback': {'mg': 'Mandefa hevitra', 'fr': 'Donner un avis', 'en': 'Give feedback'},

    // ---- Secteurs ----
    'sector_health': {'mg': 'Fahasalamana', 'fr': 'Santé', 'en': 'Health'},
    'sector_education': {'mg': 'Fanabeazana', 'fr': 'Éducation', 'en': 'Education'},
    'sector_commerce': {
      'mg': 'Varotra & Serivisy',
      'fr': 'Commerce & Services',
      'en': 'Commerce & Services',
    },
    'sector_public_admin': {
      'mg': 'Fitondram-panjakana',
      'fr': 'Administration Publique',
      'en': 'Public Administration',
    },
    'sector_hospitality': {
      'mg': 'Sakafo & Fandraisam-bahiny',
      'fr': 'Restauration & Hôtellerie',
      'en': 'Restauration & Hospitality',
    },
    'sector_transport': {'mg': 'Fitaterana', 'fr': 'Transports', 'en': 'Transport'},

    // ---- Formulaire de feedback ----
    'your_rating': {'mg': 'Ny naotinao', 'fr': 'Votre note', 'en': 'Your rating'},
    'comment': {'mg': 'Hevitra', 'fr': 'Commentaire', 'en': 'Comment'},
    'comment_hint': {
      'mg': 'Lazao aminay ny zavatra niainanao...',
      'fr': 'Dites-nous ce que vous avez vécu...',
      'en': 'Tell us about your experience...',
    },
    'suggestion': {
      'mg': 'Soso-kevitra fanatsarana',
      'fr': "Suggestion d'amélioration",
      'en': 'Improvement suggestion',
    },
    'add_photos': {'mg': 'Hampiditra sary', 'fr': 'Ajouter des photos', 'en': 'Add photos'},
    'add_location': {
      'mg': 'Hampiditra ny toerana (GPS)',
      'fr': 'Ajouter la localisation (GPS)',
      'en': 'Add location (GPS)',
    },
    'location_added': {'mg': 'Toerana voarakitra', 'fr': 'Localisation ajoutée', 'en': 'Location added'},
    'location_help': {
      'mg': "Ilaina rehefa misy olana eo amin'ny toerana iray (lavaka eny an-dalana, sns).",
      'fr': "Utile pour signaler un problème à un endroit précis (trou sur la route, etc.).",
      'en': 'Useful to report an issue at a specific place (pothole, etc.).',
    },
    'feedback_anonymous_note': {
      'mg': "Tsy misy angona mamantatra anao voatahiry. Tena tsy fantatra anarana ny hevitrao.",
      'fr': 'Aucune donnée vous identifiant n\'est stockée. Votre avis est 100% anonyme.',
      'en': 'No identifying data is stored. Your feedback is 100% anonymous.',
    },
    'feedback_saved_offline': {
      'mg': "Voatahiry an-tsokosoko. Halefa rehefa misy fifandraisana.",
      'fr': 'Enregistré hors ligne. Sera envoyé dès la connexion.',
      'en': 'Saved offline. Will be sent once online.',
    },
    'feedback_sent': {'mg': 'Voalefa ny hevitrao. Misaotra!', 'fr': 'Avis envoyé. Merci !', 'en': 'Feedback sent. Thank you!'},
    'rating_required': {
      'mg': 'Mametraha naoty azafady',
      'fr': 'Veuillez donner une note',
      'en': 'Please give a rating',
    },

    // ---- V2.1 : établissement + sélection de catégorie ----
    'establishment_name': {
      'mg': "Anaran'ny toerana",
      'fr': "Nom de l'établissement",
      'en': 'Establishment name',
    },
    'establishment_address': {
      'mg': 'Adiresy',
      'fr': 'Adresse',
      'en': 'Address',
    },
    'err_establishment_required': {
      'mg': "Mila anaran'ny toerana",
      'fr': "Le nom de l'établissement est obligatoire",
      'en': 'Establishment name is required',
    },
    'select_category': {
      'mg': 'Misafidiana sokajy',
      'fr': 'Choisir une catégorie',
      'en': 'Select a category',
    },
    'sector_other': {'mg': 'Hafa', 'fr': 'Autre', 'en': 'Other'},

    // ---- V2 : validation temps réel + logique conditionnelle ----
    'err_rating_required': {
      'mg': 'Mila naoty (voatery)',
      'fr': 'La note est obligatoire',
      'en': 'Rating is required',
    },
    'err_problem_details_min': {
      'mg': 'Hazavao bebe kokoa ny olana (10 litera farafahakeliny)',
      'fr': 'Décrivez le problème (10 caractères min.)',
      'en': 'Describe the problem (10 chars min.)',
    },
    'err_problem_details_max': {
      'mg': 'Lava loatra ny lahatsoratra',
      'fr': 'Texte trop long',
      'en': 'Text too long',
    },
    'err_problem_type_required': {
      'mg': "Misafidiana karazana olana iray farafahakeliny",
      'fr': 'Choisissez au moins un type de problème',
      'en': 'Select at least one problem type',
    },
    'err_comment_max': {
      'mg': 'Lava loatra ny hevitra',
      'fr': 'Commentaire trop long',
      'en': 'Comment too long',
    },
    'err_photo_required_critical': {
      'mg': "Mila sary iray fara-fahakeliny ho an'ny olana lehibe",
      'fr': 'Une photo est requise pour un problème grave',
      'en': 'A photo is required for a serious problem',
    },
    'err_comment_required_sector': {
      'mg': "Mila hevitra ho an'ity sehatra ity",
      'fr': 'Un commentaire est requis pour ce secteur',
      'en': 'A comment is required for this sector',
    },
    'critical_problem': {
      'mg': 'Olana lehibe / maika',
      'fr': 'Problème grave / urgent',
      'en': 'Serious / urgent problem',
    },
    'problem_details': {
      'mg': "Antsipiriany ny olana",
      'fr': 'Détails du problème',
      'en': 'Problem details',
    },
    'problem_types': {
      'mg': 'Karazana olana',
      'fr': 'Type de problème',
      'en': 'Problem type',
    },
    'add_video': {
      'mg': 'Hampiditra horonan-tsary fohy',
      'fr': 'Ajouter une vidéo courte',
      'en': 'Add a short video',
    },
    'express_title': {
      'mg': 'Feedback haingana',
      'fr': 'Feedback express',
      'en': 'Express feedback',
    },
    'express_subtitle': {
      'mg': 'Fanontaniana 3 haingana',
      'fr': '3 questions rapides',
      'en': '3 quick questions',
    },
    'ptype_welcome': {'mg': 'Fandraisana', 'fr': 'Accueil', 'en': 'Welcome'},
    'ptype_waiting': {'mg': 'Fiandrasana', 'fr': 'Attente', 'en': 'Waiting'},
    'ptype_hygiene': {'mg': 'Fahadiovana', 'fr': 'Hygiène', 'en': 'Hygiene'},
    'ptype_price': {'mg': 'Vidiny', 'fr': 'Prix', 'en': 'Price'},
    'ptype_competence': {'mg': 'Fahaiza-manao', 'fr': 'Compétence', 'en': 'Competence'},
    'ptype_other': {'mg': 'Hafa', 'fr': 'Autre', 'en': 'Other'},
    'status_submitted': {'mg': 'Voaray', 'fr': 'Reçu', 'en': 'Submitted'},
    'status_in_progress': {'mg': 'Eo am-pandinihana', 'fr': 'En cours', 'en': 'In progress'},
    'status_resolved': {'mg': 'Voavaha', 'fr': 'Résolu', 'en': 'Resolved'},
    'form_invalid_hint': {
      'mg': 'Fenoy tsara ny saha voatery mialoha ny handefa',
      'fr': 'Complétez les champs requis avant d\'envoyer',
      'en': 'Complete required fields before sending',
    },
    'express_mode': {'mg': 'Hatsarao haingana', 'fr': 'Mode express', 'en': 'Express mode'},

    // ---- QR Scanner ----
    'scan_title': {'mg': 'Tsindrio ny QR code', 'fr': 'Scanner le QR code', 'en': 'Scan QR code'},
    'scan_hint': {
      'mg': "Apetraho ao anatin'ny faritra ny QR code",
      'fr': 'Placez le QR code dans le cadre',
      'en': 'Place the QR code inside the frame',
    },
    'scan_permission_denied': {
      'mg': "Mila alalana hampiasa ny fakan-tsary",
      'fr': "L'accès à la caméra est requis",
      'en': 'Camera access is required',
    },

    // ---- Paramètres ----
    'language': {'mg': 'Fiteny', 'fr': 'Langue', 'en': 'Language'},
    'theme': {'mg': 'Endrika', 'fr': 'Thème', 'en': 'Theme'},
    'theme_system': {'mg': 'Araka ny rafitra', 'fr': 'Système', 'en': 'System'},
    'theme_light': {'mg': 'Mazava', 'fr': 'Clair', 'en': 'Light'},
    'theme_dark': {'mg': 'Maizina', 'fr': 'Sombre', 'en': 'Dark'},
    'accessibility': {'mg': 'Fahafahana mampiasa', 'fr': 'Accessibilité', 'en': 'Accessibility'},
    'high_contrast': {'mg': 'Fifanoherana avo', 'fr': 'Contraste élevé', 'en': 'High contrast'},
    'large_text': {'mg': 'Soratra lehibe', 'fr': 'Grand texte', 'en': 'Large text'},

    // ---- Admin ----
    'admin_dashboard': {'mg': 'Tabilao admin', 'fr': 'Tableau de bord', 'en': 'Dashboard'},
    'total_feedbacks': {'mg': 'Hevitra rehetra', 'fr': 'Total des avis', 'en': 'Total feedbacks'},
    'average_rating': {'mg': 'Naoty antonony', 'fr': 'Note moyenne', 'en': 'Average rating'},
    'pending_moderation': {'mg': 'Miandry fanamarinana', 'fr': 'En attente de modération', 'en': 'Pending moderation'},
    'resolved': {'mg': 'Voavaha', 'fr': 'Traités', 'en': 'Resolved'},
    'recent_feedbacks': {'mg': 'Hevitra farany', 'fr': 'Avis récents', 'en': 'Recent feedbacks'},
    'export_csv': {'mg': 'Hanondrana CSV', 'fr': 'Exporter CSV', 'en': 'Export CSV'},

    // ---- Statut connexion ----
    'offline': {'mg': 'Tsy mifandray', 'fr': 'Hors ligne', 'en': 'Offline'},
    'syncing': {'mg': 'Mampifanaraka...', 'fr': 'Synchronisation...', 'en': 'Syncing...'},
    'pending_sync': {'mg': 'miandry', 'fr': 'en attente', 'en': 'pending'},
  };

  String t(String key) {
    final entry = _values[key];
    if (entry == null) return key;
    return entry[locale.languageCode] ?? entry['fr'] ?? key;
  }

  /// Récupère l'instance depuis le contexte (fallback si non fournie).
  static AppStrings of(BuildContext context) {
    return Localizations.of<AppStrings>(context, AppStrings) ??
        const AppStrings(Locale('fr'));
  }
}

/// Délégué pour intégrer [AppStrings] dans le système `Localizations` de Flutter.
class AppStringsDelegate extends LocalizationsDelegate<AppStrings> {
  const AppStringsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['mg', 'fr', 'en'].contains(locale.languageCode);

  @override
  Future<AppStrings> load(Locale locale) async => AppStrings(locale);

  @override
  bool shouldReload(AppStringsDelegate old) => false;
}
