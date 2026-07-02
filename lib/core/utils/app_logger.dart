import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

/// Journalisation centralisée de l'application.
///
/// Remplace les `print` disséminés : en debug, tout est visible dans la
/// console ; en release, seules les erreurs sont journalisées (via
/// `dart:developer`), ce qui évite les fuites d'information.
class AppLogger {
  AppLogger._();

  static const _name = 'FeedbackPro';

  static void info(String message) {
    if (kDebugMode) developer.log(message, name: _name, level: 800);
  }

  static void warn(String message, [Object? error]) {
    developer.log(message, name: _name, level: 900, error: error);
  }

  static void error(String message, [Object? error, StackTrace? stack]) {
    developer.log(
      message,
      name: _name,
      level: 1000,
      error: error,
      stackTrace: stack,
    );
  }
}
