import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/utils/app_logger.dart';

/// Accès centralisé au client Supabase.
final supabaseClientProvider = Provider<SupabaseClient>(
  (ref) => Supabase.instance.client,
);

/// Wrapper fin autour des appels Supabase pertinents pour FeedbackPro.
class SupabaseService {
  SupabaseService(this._client);
  final SupabaseClient _client;

  /// Insère un feedback (client standard). L'insertion anonyme est autorisée par
  /// la policy RLS `for insert to public`. La RLS interdit toujours la relecture
  /// des feedbacks d'autrui (réservée aux admins).
  Future<Map<String, dynamic>> insertFeedback(Map<String, dynamic> payload) async {
    final res = await _client.from('feedbacks').insert(payload).select().single();
    return res;
  }

  /// Récupère les améliorations publiées (table publique en lecture seule).
  ///
  /// IMPORTANT : on ne sélectionne QUE les colonnes réellement affichées.
  /// Auparavant la requête embarquait `feedback:feedback_id(...)`, or la table
  /// `feedbacks` est en lecture réservée aux admins (RLS). Pour une session
  /// anonyme (mobile), cet embed pouvait faire échouer toute la requête, d'où le
  /// symptôme « aucune amélioration » alors que les données existent.
  Future<List<Map<String, dynamic>>> fetchImprovements() async {
    final res = await _client
        .from('improvements')
        .select(
          'id, title, description, before_photo_url, after_photo_url, published_at, establishment_id',
        )
        .order('published_at', ascending: false)
        .limit(50);
    return List<Map<String, dynamic>>.from(res);
  }

  /// Récupère les améliorations par établissement.
  Future<List<Map<String, dynamic>>> fetchImprovementsByEstablishment(String establishmentId) async {
    try {
      final res = await _client
          .from('improvements')
          .select('''
            id,
            title,
            description,
            before_photo_url,
            after_photo_url,
            published_at
          ''')
          .eq('establishment_id', establishmentId)
          .order('published_at', ascending: false);
      
      return List<Map<String, dynamic>>.from(res);
    } catch (e) {
      AppLogger.warn('fetchImprovementsByEstablishment', e);
      return [];
    }
  }

  /// Récupère toutes les améliorations (pour l'admin).
  Future<List<Map<String, dynamic>>> fetchAllImprovements() async {
    try {
      final res = await _client
          .from('improvements')
          .select('*')
          .order('published_at', ascending: false);
      
      return List<Map<String, dynamic>>.from(res);
    } catch (e) {
      AppLogger.warn('fetchAllImprovements', e);
      return [];
    }
  }

  /// Insère une amélioration.
  Future<Map<String, dynamic>> insertImprovement(Map<String, dynamic> payload) async {
    final res = await _client.from('improvements').insert(payload).select().single();
    return res;
  }

  /// Met à jour une amélioration.
  Future<Map<String, dynamic>> updateImprovement(String id, Map<String, dynamic> payload) async {
    final res = await _client
        .from('improvements')
        .update(payload)
        .eq('id', id)
        .select()
        .single();
    return res;
  }

  /// Supprime une amélioration.
  Future<void> deleteImprovement(String id) async {
    await _client.from('improvements').delete().eq('id', id);
  }

  /// Cherche un établissement par son code QR public.
  Future<Map<String, dynamic>?> findEstablishmentByQr(String qrCode) async {
    final res = await _client
        .from('establishments')
        .select()
        .eq('qr_code', qrCode)
        .maybeSingle();
    return res;
  }

  /// Récupère tous les établissements.
  Future<List<Map<String, dynamic>>> fetchEstablishments() async {
    try {
      final res = await _client
          .from('establishments')
          .select('*')
          .order('name', ascending: true);
      
      return List<Map<String, dynamic>>.from(res);
    } catch (e) {
      AppLogger.warn('fetchEstablishments', e);
      return [];
    }
  }

  /// Recherche intelligente d'établissements par nom / adresse / secteur.
  /// Insensible à la casse (ilike). Retourne [] si la requête est vide.
  Future<List<Map<String, dynamic>>> searchEstablishments(String query) async {
    final q = query.trim();
    if (q.isEmpty) return [];
    try {
      final pattern = '%$q%';
      final res = await _client
          .from('establishments')
          .select('id, name, sector_id, address')
          .or('name.ilike.$pattern,address.ilike.$pattern,sector_id.ilike.$pattern')
          .order('name', ascending: true)
          .limit(20);
      return List<Map<String, dynamic>>.from(res);
    } catch (e) {
      AppLogger.warn('searchEstablishments', e);
      return [];
    }
  }

  /// Récupère un établissement par son ID.
  Future<Map<String, dynamic>?> fetchEstablishmentById(String id) async {
    try {
      final res = await _client
          .from('establishments')
          .select()
          .eq('id', id)
          .maybeSingle();
      return res;
    } catch (e) {
      AppLogger.warn('fetchEstablishmentById', e);
      return null;
    }
  }

  /// Upload une photo compressée et renvoie l'URL publique.
  Future<String> uploadPhoto(String bucket, String path, Uint8List bytes) async {
    await _client.storage.from(bucket).uploadBinary(
          path,
          bytes,
          fileOptions: const FileOptions(upsert: true),
        );
    return _client.storage.from(bucket).getPublicUrl(path);
  }

  /// Supprime une photo du bucket.
  Future<void> deletePhoto(String bucket, String path) async {
    await _client.storage.from(bucket).remove([path]);
  }

  /// Récupère les feedbacks (pour l'admin).
  Future<List<Map<String, dynamic>>> fetchFeedbacks({int limit = 100}) async {
    try {
      final res = await _client
          .from('feedbacks')
          .select('''
            *,
            establishment:establishment_id (
              id,
              name,
              sector_id
            )
          ''')
          .order('created_at', ascending: false)
          .limit(limit);
      
      return List<Map<String, dynamic>>.from(res);
    } catch (e) {
      AppLogger.warn('fetchFeedbacks', e);
      return [];
    }
  }

  /// Met à jour un feedback côté admin (modération : statut, priorité,
  /// visibilité, statut de suivi). RLS : réservé aux admins.
  Future<void> updateFeedbackFields(String id, Map<String, dynamic> fields) async {
    await _client.from('feedbacks').update(fields).eq('id', id);
  }

  /// Conversation 2-way : récupère les messages d'un feedback via son
  /// `anon_code` (RPC sécurisée `get_conversation`, connue du seul auteur).
  Future<List<Map<String, dynamic>>> fetchConversation(String anonCode) async {
    final res = await _client.rpc(
      'get_conversation',
      params: {'p_anon_code': anonCode},
    );
    return List<Map<String, dynamic>>.from(res as List);
  }

  /// Envoie un message côté utilisateur (sender = 'user').
  Future<void> sendUserMessage({
    required String feedbackId,
    required String anonCode,
    required String body,
  }) async {
    await _client.from('conversation_messages').insert({
      'feedback_id': feedbackId,
      'anon_code': anonCode,
      'sender': 'user',
      'body': body,
    });
  }

  /// Envoie un message côté admin (sender = 'admin', RLS admin requise).
  Future<void> sendAdminMessage({
    required String feedbackId,
    required String anonCode,
    required String body,
  }) async {
    await _client.from('conversation_messages').insert({
      'feedback_id': feedbackId,
      'anon_code': anonCode,
      'sender': 'admin',
      'body': body,
    });
  }

  /// Récupère les feedbacks par secteur.
  Future<List<Map<String, dynamic>>> fetchFeedbacksBySector(String sectorId) async {
    try {
      final res = await _client
          .from('feedbacks')
          .select('*')
          .eq('sector_id', sectorId)
          .order('created_at', ascending: false);
      
      return List<Map<String, dynamic>>.from(res);
    } catch (e) {
      AppLogger.warn('fetchFeedbacksBySector', e);
      return [];
    }
  }

  /// Compte les feedbacks par secteur.
  Future<Map<String, int>> countFeedbacksBySector() async {
    try {
      final res = await _client
          .from('feedbacks')
          .select('sector_id');
      
      final Map<String, int> counts = {};
      for (final item in res) {
        final sector = item['sector_id'] as String;
        counts[sector] = (counts[sector] ?? 0) + 1;
      }
      return counts;
    } catch (e) {
      AppLogger.warn('countFeedbacksBySector', e);
      return {};
    }
  }

  /// Verifie la connectivite avec Supabase.
  Future<bool> isConnected() async {
    try {
      await _client.from('feedbacks').select().limit(1);
      return true;
    } catch (e) {
      return false;
    }
  }
}

final supabaseServiceProvider = Provider<SupabaseService>(
  (ref) => SupabaseService(ref.read(supabaseClientProvider)),
);