-- =============================================================================
-- Désigner luciarasoanirina8@gmail.com comme administrateur (super_admin).
-- =============================================================================
-- PRÉREQUIS : le compte doit d'abord EXISTER dans Supabase Auth.
--   1. Supabase → Authentication → Users → « Add user »
--      Email    : luciarasoanirina8@gmail.com
--      Password : (choisis un mot de passe) — coche « Auto Confirm User ».
--   2. Exécute ce script dans Supabase → SQL Editor.
--
-- Il fonctionne aussi bien pour la 1ʳᵉ désignation que pour re-promouvoir le
-- compte (idempotent).
-- =============================================================================

insert into public.admins (user_id, role, display_name)
select u.id, 'super_admin', 'Lucia Rasoanirina'
from auth.users u
where u.email = 'luciarasoanirina8@gmail.com'
on conflict (user_id) do update
  set role = 'super_admin',
      display_name = excluded.display_name;

-- Vérification : doit renvoyer une ligne.
select a.user_id, u.email, a.role
from public.admins a
join auth.users u on u.id = a.user_id
where u.email = 'luciarasoanirina8@gmail.com';
