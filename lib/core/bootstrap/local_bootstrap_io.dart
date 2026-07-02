import '../../data/datasources/local/isar_service.dart';

/// Mobile/desktop : ouvre Isar et fournit l'override de [isarProvider].
/// Type de retour volontairement `List<Object>` (les Override sont des Object)
/// pour ne pas dépendre du nom de type `Override`, non exporté publiquement.
Future<List<Object>> localOverrides() async {
  final isar = await IsarService.open();
  return [isarProvider.overrideWithValue(isar)];
}
