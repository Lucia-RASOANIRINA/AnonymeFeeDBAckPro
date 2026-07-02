import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/datasources/remote/supabase_service.dart';

/// Texte de recherche saisi dans l'accueil (source de vérité de la recherche).
class HomeSearchQuery extends Notifier<String> {
  @override
  String build() => '';

  void set(String value) => state = value;
}

final homeSearchQueryProvider =
    NotifierProvider<HomeSearchQuery, String>(HomeSearchQuery.new);

/// Résultats de recherche d'établissements (données réelles Supabase).
///
/// `autoDispose` + `watch` de la requête : la recherche se relance à chaque
/// frappe. Retourne une liste vide tant que la requête est vide, pour ne pas
/// interroger Supabase inutilement.
final establishmentSearchProvider =
    FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final query = ref.watch(homeSearchQueryProvider).trim();
  if (query.isEmpty) return [];
  // Petit debounce pour éviter une requête par caractère.
  await Future<void>.delayed(const Duration(milliseconds: 300));
  return ref.read(supabaseServiceProvider).searchEstablishments(query);
});
