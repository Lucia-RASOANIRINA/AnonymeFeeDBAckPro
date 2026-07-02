-- =============================================================================
-- FeedbackPro — Autoriser l'insertion anonyme SANS auth anonyme activée.
-- =============================================================================
-- Contexte : l'app se connecte normalement en session anonyme (rôle
-- « authenticated ») pour insérer un feedback. Si « Anonymous sign-ins » est
-- DÉSACTIVÉ dans le projet, l'app n'obtient pas de session -> l'insert est
-- refusé par la RLS -> la synchro échoue (icône bloquée).
--
-- Cette migration autorise AUSSI le rôle « anon » (= requête avec la seule clé
-- publique) à insérer un feedback ou un message utilisateur. L'anonymat reste
-- total (aucune identité n'est stockée). La lecture/modération reste réservée
-- aux admins.
--
-- À exécuter dans Supabase → SQL Editor (projet bwkqzmdodbewhbrvkzpv).
-- (Alternative équivalente : activer Authentication → Providers → Anonymous.)
-- =============================================================================

drop policy if exists "feedbacks_anon_insert" on public.feedbacks;
create policy "feedbacks_anon_insert" on public.feedbacks
  for insert to anon, authenticated
  with check (true);

drop policy if exists "messages_user_insert" on public.conversation_messages;
create policy "messages_user_insert" on public.conversation_messages
  for insert to anon, authenticated
  with check (sender = 'user');

-- Vérification : les feedbacks lisibles restent réservés aux admins.
-- select polname, roles from pg_policies where tablename = 'feedbacks';
