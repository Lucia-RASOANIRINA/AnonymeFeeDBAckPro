import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/datasources/remote/supabase_service.dart';

/// Statistiques agrégées pour le tableau de bord admin.
class DashboardStats {
  final int total;
  final double averageRating; // sur 100
  final int pendingModeration;
  final int resolved;

  /// Nombre de feedbacks par secteur (id -> count).
  final Map<String, int> bySector;

  /// Avis récents (lignes brutes Supabase).
  final List<Map<String, dynamic>> recent;

  const DashboardStats({
    required this.total,
    required this.averageRating,
    required this.pendingModeration,
    required this.resolved,
    required this.bySector,
    required this.recent,
  });

  static const empty = DashboardStats(
    total: 0,
    averageRating: 0,
    pendingModeration: 0,
    resolved: 0,
    bySector: {},
    recent: [],
  );
}

/// Récupère les statistiques. Côté admin uniquement (RLS via rôle admin).
final dashboardStatsProvider = FutureProvider<DashboardStats>((ref) async {
  // Garde le résultat en cache : revenir sur le tableau de bord est instantané
  // (le bouton Rafraîchir invalide explicitement si besoin).
  ref.keepAlive();
  final client = ref.read(supabaseClientProvider);
  try {
    // On ne récupère QUE les colonnes utiles (pas problem_details, search_tsv,
    // photo_urls, themes…) : payload réduit -> affichage plus rapide.
    final rows = await client
        .from('feedbacks')
        .select(
          'id, sector_id, rating_normalized, moderation_status, comment, created_at',
        )
        .order('created_at', ascending: false)
        .limit(500);
    final list = List<Map<String, dynamic>>.from(rows);

    if (list.isEmpty) return DashboardStats.empty;

    var sumRating = 0;
    var pending = 0;
    var resolved = 0;
    final bySector = <String, int>{};

    for (final r in list) {
      sumRating += (r['rating_normalized'] as num?)?.toInt() ?? 0;
      final mod = r['moderation_status'] as String?;
      if (mod == 'new' || mod == null) pending++;
      if (mod == 'resolved') resolved++;
      final sector = r['sector_id'] as String? ?? 'other';
      bySector[sector] = (bySector[sector] ?? 0) + 1;
    }

    return DashboardStats(
      total: list.length,
      averageRating: sumRating / list.length,
      pendingModeration: pending,
      resolved: resolved,
      bySector: bySector,
      recent: list.take(20).toList(),
    );
  } catch (_) {
    // Hors ligne ou non autorisé : on renvoie un état vide plutôt que crasher.
    return DashboardStats.empty;
  }
});
