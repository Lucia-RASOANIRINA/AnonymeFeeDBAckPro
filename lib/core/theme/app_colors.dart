import 'package:flutter/material.dart';

/// Palette de couleurs de FeedbackPro.
class AppColors {
  AppColors._();

  // Couleur principale : un vert proche du drapeau malgache / nature.
  static const Color primary = Color(0xFF1B7A43);
  static const Color primaryDark = Color(0xFF0E5C30);
  static const Color secondary = Color(0xFFE53935); // rouge accent
  static const Color accent = Color(0xFFF9A825); // jaune/ocre

  static const Color success = Color(0xFF2E7D32);
  static const Color warning = Color(0xFFF9A825);
  static const Color error = Color(0xFFC62828);

  // Surfaces - mode clair
  static const Color lightBackground = Color(0xFFF7F9F7);
  static const Color lightSurface = Color(0xFFFFFFFF);

  // Surfaces - mode sombre
  static const Color darkBackground = Color(0xFF121512);
  static const Color darkSurface = Color(0xFF1C211C);
}
