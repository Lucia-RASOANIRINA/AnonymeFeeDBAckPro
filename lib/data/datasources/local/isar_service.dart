import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../../core/config/app_config.dart';
import '../../models/establishment_local.dart';
import '../../models/feedback_local.dart';

/// Ouvre et expose l'instance Isar (base locale offline-first).
class IsarService {
  IsarService(this.isar);

  final Isar isar;

  static Future<Isar> open() async {
    final dir = await getApplicationDocumentsDirectory();
    return Isar.open(
      [FeedbackLocalSchema, EstablishmentLocalSchema],
      directory: dir.path,
      name: AppConfig.isarInstanceName,
      inspector: false, // désactivé en prod pour économiser les ressources
    );
  }
}

/// Provider de l'instance Isar (override dans main() après ouverture asynchrone).
final isarProvider = Provider<Isar>(
  (ref) => throw UnimplementedError('Override dans main()'),
);
