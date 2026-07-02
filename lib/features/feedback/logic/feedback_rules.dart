import '../../../data/models/feedback_models.dart';

/// Moteur de **validation temps réel** et de **logique conditionnelle** du
/// formulaire de feedback (exigence centrale de la V2).
///
/// Tout est PUR (aucune dépendance UI) → facilement testable et réutilisable
/// côté mobile comme côté serveur (mêmes règles que les triggers Supabase).
class FeedbackRules {
  FeedbackRules._();

  // Seuils.
  static const int lowRatingThreshold = 50; // /100 : en dessous = note basse
  static const int commentMaxLength = 600;
  static const int problemDetailsMinLength = 10;
  static const int problemDetailsMaxLength = 600;

  /// Types de problèmes proposés quand la note est basse (clés de traduction).
  static const List<String> problemTypeKeys = [
    'ptype_welcome', // accueil
    'ptype_waiting', // attente
    'ptype_hygiene', // hygiène
    'ptype_price', // prix
    'ptype_competence', // compétence
    'ptype_other', // autre
  ];

  /// Normalise une note brute sur 0-100 (même formule que le repository).
  static int normalize(int raw, RatingType type) {
    switch (type) {
      case RatingType.stars:
      case RatingType.smiley:
        return ((raw.clamp(1, 5)) / 5 * 100).round();
      case RatingType.scale:
        return ((raw.clamp(1, 10)) / 10 * 100).round();
    }
  }

  /// Évalue l'état du formulaire et renvoie les erreurs + les sections à
  /// afficher. Appelé à CHAQUE modification (temps réel).
  ///
  /// V2.1 : le SEUL champ obligatoire est le nom de l'établissement.
  /// La note est facultative et le bouton Envoyer reste actif. Le type de
  /// problème est toujours affiché (en neutre), jamais bloquant.
  static FeedbackValidation evaluate({
    required String? sectorId,
    required String establishmentName,
    required int rating,
    required RatingType ratingType,
    required String comment,
    required bool isCritical,
    required String problemDetails,
    required List<String> problemTypes,
    required int photoCount,
  }) {
    final errors = <String, String>{};

    // 1) Nom de l'établissement obligatoire.
    if (establishmentName.trim().isEmpty) {
      errors['establishment'] = 'err_establishment_required';
    }

    final hasRating = rating > 0;
    final normalized = hasRating ? normalize(rating, ratingType) : 0;
    final isLow = hasRating && normalized < lowRatingThreshold;

    // 2) Contrôles de longueur (temps réel, non bloquants pour la note).
    if (comment.length > commentMaxLength) {
      errors['comment'] = 'err_comment_max';
    }
    if (problemDetails.length > problemDetailsMaxLength) {
      errors['problemDetails'] = 'err_problem_details_max';
    }

    return FeedbackValidation(
      errors: errors,
      normalizedRating: normalized,
      // Le type de problème est désormais TOUJOURS visible (style neutre).
      showProblemSection: true,
      requirePhoto: false,
      isLowRating: isLow,
    );
  }
}

/// Résultat de validation + drapeaux conditionnels pour l'UI.
class FeedbackValidation {
  final Map<String, String> errors;
  final int normalizedRating;
  final bool showProblemSection;
  final bool requirePhoto;
  final bool isLowRating;

  const FeedbackValidation({
    required this.errors,
    required this.normalizedRating,
    required this.showProblemSection,
    required this.requirePhoto,
    required this.isLowRating,
  });

  bool get isValid => errors.isEmpty;
  String? errorFor(String field) => errors[field];
}
