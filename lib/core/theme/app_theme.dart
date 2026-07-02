import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Thèmes clair et sombre, avec option contraste élevé (accessibilité).
class AppTheme {
  AppTheme._();

  static ThemeData light({bool highContrast = false}) {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
    ).copyWith(
      secondary: AppColors.secondary,
      error: AppColors.error,
    );
    return _base(scheme, AppColors.lightBackground, highContrast);
  }

  static ThemeData dark({bool highContrast = false}) {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
    ).copyWith(
      secondary: AppColors.secondary,
      error: AppColors.error,
    );
    return _base(scheme, AppColors.darkBackground, highContrast);
  }

  static ThemeData _base(
    ColorScheme scheme,
    Color background,
    bool highContrast,
  ) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: background,
      visualDensity: VisualDensity.standard,
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
      ),
      cardTheme: CardThemeData(
        elevation: highContrast ? 0 : 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: highContrast
              ? BorderSide(color: scheme.outline, width: 1.5)
              : BorderSide.none,
        ),
        clipBehavior: Clip.antiAlias,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(64, 52), // cible tactile généreuse
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: highContrast ? scheme.outline : Colors.transparent,
          ),
        ),
      ),
      chipTheme: const ChipThemeData(
        shape: StadiumBorder(),
      ),
    );
  }
}
