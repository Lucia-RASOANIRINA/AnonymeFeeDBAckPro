import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/feedback_models.dart';
import '../logic/feedback_rules.dart';

/// État local du formulaire de feedback (avant sauvegarde) — V2.
@immutable
class FeedbackFormState {
  final String? sectorId;
  final String? establishmentId;
  final String? establishmentName;
  final String address;
  final RatingType ratingType;
  final int rating; // valeur brute (selon le type)
  final String comment;
  final String suggestion;
  final List<String> photoPaths;
  final String? videoPath;
  // V2 — logique conditionnelle
  final bool isCritical;
  final String problemDetails;
  final List<String> problemTypes;
  // Localisation
  final bool hasLocation;
  final double? latitude;
  final double? longitude;
  // Express mode (3 questions rapides)
  final bool expressMode;
  final bool submitting;

  const FeedbackFormState({
    this.sectorId,
    this.establishmentId,
    this.establishmentName,
    this.address = '',
    this.ratingType = RatingType.stars,
    this.rating = 0,
    this.comment = '',
    this.suggestion = '',
    this.photoPaths = const [],
    this.videoPath,
    this.isCritical = false,
    this.problemDetails = '',
    this.problemTypes = const [],
    this.hasLocation = false,
    this.latitude,
    this.longitude,
    this.expressMode = false,
    this.submitting = false,
  });

  /// Validation temps réel (recalculée à chaque rebuild qui lit l'état).
  FeedbackValidation get validation => FeedbackRules.evaluate(
        sectorId: sectorId,
        establishmentName: establishmentName ?? '',
        rating: rating,
        ratingType: ratingType,
        comment: comment,
        isCritical: isCritical,
        problemDetails: problemDetails,
        problemTypes: problemTypes,
        photoCount: photoPaths.length,
      );

  bool get isValid => validation.isValid;

  FeedbackFormState copyWith({
    String? sectorId,
    String? establishmentId,
    String? establishmentName,
    String? address,
    RatingType? ratingType,
    int? rating,
    String? comment,
    String? suggestion,
    List<String>? photoPaths,
    String? videoPath,
    bool? isCritical,
    String? problemDetails,
    List<String>? problemTypes,
    bool? hasLocation,
    double? latitude,
    double? longitude,
    bool? expressMode,
    bool? submitting,
  }) {
    return FeedbackFormState(
      sectorId: sectorId ?? this.sectorId,
      establishmentId: establishmentId ?? this.establishmentId,
      establishmentName: establishmentName ?? this.establishmentName,
      address: address ?? this.address,
      ratingType: ratingType ?? this.ratingType,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      suggestion: suggestion ?? this.suggestion,
      photoPaths: photoPaths ?? this.photoPaths,
      videoPath: videoPath ?? this.videoPath,
      isCritical: isCritical ?? this.isCritical,
      problemDetails: problemDetails ?? this.problemDetails,
      problemTypes: problemTypes ?? this.problemTypes,
      hasLocation: hasLocation ?? this.hasLocation,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      expressMode: expressMode ?? this.expressMode,
      submitting: submitting ?? this.submitting,
    );
  }
}

/// Notifier du formulaire. Réinitialisé à chaque ouverture via [init].
class FeedbackFormNotifier extends Notifier<FeedbackFormState> {
  @override
  FeedbackFormState build() => const FeedbackFormState();

  /// Réinitialise le formulaire avec le contexte (secteur/établissement).
  void init({
    String? sectorId,
    String? establishmentId,
    String? establishmentName,
    bool expressMode = false,
  }) {
    state = FeedbackFormState(
      sectorId: sectorId,
      establishmentId: establishmentId,
      establishmentName: establishmentName,
      expressMode: expressMode,
    );
  }

  void setRatingType(RatingType type) =>
      state = state.copyWith(ratingType: type, rating: 0);
  void setRating(int value) => state = state.copyWith(rating: value);
  void setComment(String v) => state = state.copyWith(comment: v);
  void setSuggestion(String v) => state = state.copyWith(suggestion: v);
  void setSector(String id) => state = state.copyWith(sectorId: id);
  void setEstablishmentName(String v) =>
      state = state.copyWith(establishmentName: v);
  void setAddress(String v) => state = state.copyWith(address: v);

  void setCritical(bool v) => state = state.copyWith(isCritical: v);
  void setProblemDetails(String v) => state = state.copyWith(problemDetails: v);

  void toggleProblemType(String key) {
    final list = [...state.problemTypes];
    list.contains(key) ? list.remove(key) : list.add(key);
    state = state.copyWith(problemTypes: list);
  }

  void addPhoto(String path) =>
      state = state.copyWith(photoPaths: [...state.photoPaths, path]);
  void removePhoto(String path) => state = state.copyWith(
      photoPaths: state.photoPaths.where((p) => p != path).toList());
  void setVideo(String? path) => state = state.copyWith(videoPath: path);

  void setLocation(double lat, double lng) =>
      state = state.copyWith(hasLocation: true, latitude: lat, longitude: lng);

  void clearLocation() {
    state = state.copyWith(hasLocation: false, latitude: null, longitude: null);
  }

  void setSubmitting(bool v) => state = state.copyWith(submitting: v);
}

final feedbackFormProvider =
    NotifierProvider<FeedbackFormNotifier, FeedbackFormState>(
        FeedbackFormNotifier.new);
