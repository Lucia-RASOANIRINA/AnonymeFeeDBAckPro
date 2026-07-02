-- =============================================================================
-- FeedbackPro — Autoriser l'insertion anonyme (compatible clés nouvelle
-- génération sb_publishable_...).
-- =============================================================================
-- L'app dépose un feedback sans compte. Selon la façon dont la clé publique est
-- transmise (header apikey vs Authorization Bearer), le rôle Postgres résolu
-- peut ne pas être exactement `anon`. Pour être robuste dans TOUS les cas, la
-- policy d'INSERT est ouverte à `public` (tous rôles). L'anonymat reste total :
-- aucune identité n'est stockée, et la LECTURE/MODÉRATION reste réservée aux
-- admins (policies inchangées).
--
-- À exécuter dans Supabase → SQL Editor (projet bwkqzmdodbewhbrvkzpv).
-- =============================================================================

drop policy if exists "feedbacks_anon_insert" on public.feedbacks;
create policy "feedbacks_anon_insert" on public.feedbacks
  for insert to public
  with check (true);

drop policy if exists "messages_user_insert" on public.conversation_messages;
create policy "messages_user_insert" on public.conversation_messages
  for insert to public
  with check (sender = 'user');

-- Vérification (doit lister feedbacks_anon_insert en INSERT) :
-- select policyname, cmd, roles from pg_policies where tablename = 'feedbacks';
