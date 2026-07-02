-- =============================================================================
-- FeedbackPro — Schéma initial + Row Level Security (RLS)
-- =============================================================================
-- Principe d'ANONYMAT MAXIMAL :
--   * La table `feedbacks` ne contient AUCUN identifiant utilisateur
--     (pas de user_id, email, téléphone, nom...). Le seul lien de suivi est un
--     `anon_code` aléatoire connu uniquement de l'auteur (stocké localement).
--   * Les utilisateurs anonymes peuvent INSÉRER un feedback mais ne peuvent PAS
--     relire ceux des autres. La lecture/modération est réservée aux admins.
--   * Les conversations 2-way passent par `anon_code` (jamais par l'identité).
-- =============================================================================

-- Extensions utiles.
create extension if not exists "pgcrypto";

-- -----------------------------------------------------------------------------
-- 1) ADMINS : table qui désigne les comptes administrateurs.
--    On ajoute manuellement l'uuid d'un compte (ex. via le dashboard Supabase).
-- -----------------------------------------------------------------------------
create table if not exists public.admins (
  user_id uuid primary key references auth.users (id) on delete cascade,
  created_at timestamptz not null default now()
);

-- Fonction helper : l'appelant est-il admin ?
create or replace function public.is_admin()
returns boolean
language sql
security definer
set search_path = public
as $$
  select exists (select 1 from public.admins a where a.user_id = auth.uid());
$$;

-- -----------------------------------------------------------------------------
-- 2) ESTABLISHMENTS : établissements / services (lecture publique).
-- -----------------------------------------------------------------------------
create table if not exists public.establishments (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  sector_id text not null,
  address text,
  latitude double precision,
  longitude double precision,
  qr_code text unique,                 -- slug encodé dans le QR
  created_at timestamptz not null default now()
);
create index if not exists idx_establishments_sector on public.establishments (sector_id);
create index if not exists idx_establishments_qr on public.establishments (qr_code);

-- -----------------------------------------------------------------------------
-- 3) TEMPLATES : questionnaires dynamiques par secteur.
--    `questions` est un JSON décrivant les champs (type, label_mg/fr/en, etc.).
-- -----------------------------------------------------------------------------
create table if not exists public.templates (
  id uuid primary key default gen_random_uuid(),
  sector_id text not null,
  title text not null,
  questions jsonb not null default '[]'::jsonb,
  is_active boolean not null default true,
  created_at timestamptz not null default now()
);

-- -----------------------------------------------------------------------------
-- 4) FEEDBACKS : cœur du système. AUCUN identifiant utilisateur.
-- -----------------------------------------------------------------------------
create table if not exists public.feedbacks (
  id uuid primary key default gen_random_uuid(),
  client_uuid text unique,             -- idempotence de la synchro offline
  establishment_id uuid references public.establishments (id) on delete set null,
  sector_id text not null,
  rating_normalized int not null check (rating_normalized between 0 and 100),
  rating_raw int,
  rating_type text not null default 'stars',
  comment text,
  suggestion text,
  answers jsonb default '{}'::jsonb,   -- réponses au template dynamique
  photo_urls text[] default '{}',
  has_location boolean not null default false,
  latitude double precision,
  longitude double precision,
  anon_code text not null,             -- suivi anonyme (sans identité)
  -- Champs de modération / amélioration.
  moderation_status text not null default 'new'
    check (moderation_status in ('new','validated','hidden','resolved')),
  -- Analyse IA simple (remplie par une Edge Function).
  sentiment text check (sentiment in ('positive','neutral','negative')),
  themes text[] default '{}',
  created_at timestamptz not null default now()
);
create index if not exists idx_feedbacks_sector on public.feedbacks (sector_id);
create index if not exists idx_feedbacks_status on public.feedbacks (moderation_status);
create index if not exists idx_feedbacks_created on public.feedbacks (created_at desc);
create index if not exists idx_feedbacks_anon on public.feedbacks (anon_code);

-- -----------------------------------------------------------------------------
-- 5) CONVERSATION_MESSAGES : échanges 2-way anonymes (via anon_code).
-- -----------------------------------------------------------------------------
create table if not exists public.conversation_messages (
  id uuid primary key default gen_random_uuid(),
  feedback_id uuid not null references public.feedbacks (id) on delete cascade,
  anon_code text not null,
  sender text not null check (sender in ('user','admin')),
  body text not null,
  created_at timestamptz not null default now()
);
create index if not exists idx_msg_feedback on public.conversation_messages (feedback_id);
create index if not exists idx_msg_anon on public.conversation_messages (anon_code);

-- -----------------------------------------------------------------------------
-- 6) IMPROVEMENTS : actions publiées (page publique avant/après).
-- -----------------------------------------------------------------------------
create table if not exists public.improvements (
  id uuid primary key default gen_random_uuid(),
  establishment_id uuid references public.establishments (id) on delete set null,
  feedback_id uuid references public.feedbacks (id) on delete set null,
  title text not null,
  description text,
  before_photo_url text,
  after_photo_url text,
  published_at timestamptz not null default now()
);
create index if not exists idx_improvements_published on public.improvements (published_at desc);

-- =============================================================================
-- ROW LEVEL SECURITY
-- =============================================================================
alter table public.admins                enable row level security;
alter table public.establishments        enable row level security;
alter table public.templates             enable row level security;
alter table public.feedbacks             enable row level security;
alter table public.conversation_messages enable row level security;
alter table public.improvements          enable row level security;

-- ---- ADMINS : seuls les admins voient la table admins ----
create policy "admins_select_admin_only" on public.admins
  for select using (public.is_admin());

-- ---- ESTABLISHMENTS : lecture publique, écriture admin ----
create policy "establishments_public_read" on public.establishments
  for select using (true);
create policy "establishments_admin_write" on public.establishments
  for all using (public.is_admin()) with check (public.is_admin());

-- ---- TEMPLATES : lecture publique (actifs), écriture admin ----
create policy "templates_public_read" on public.templates
  for select using (is_active or public.is_admin());
create policy "templates_admin_write" on public.templates
  for all using (public.is_admin()) with check (public.is_admin());

-- ---- FEEDBACKS ----
-- INSERT autorisé à tout utilisateur AUTHENTIFIÉ (= session anonyme Supabase).
-- Aucune colonne identité n'existe, donc l'insertion reste anonyme.
create policy "feedbacks_anon_insert" on public.feedbacks
  for insert to authenticated
  with check (true);
-- SELECT / UPDATE / DELETE réservés aux admins (modération).
create policy "feedbacks_admin_select" on public.feedbacks
  for select using (public.is_admin());
create policy "feedbacks_admin_update" on public.feedbacks
  for update using (public.is_admin()) with check (public.is_admin());
create policy "feedbacks_admin_delete" on public.feedbacks
  for delete using (public.is_admin());

-- ---- CONVERSATION_MESSAGES ----
-- L'utilisateur écrit ses réponses (sender='user') ; l'admin écrit (sender='admin').
create policy "messages_user_insert" on public.conversation_messages
  for insert to authenticated
  with check (sender = 'user');
create policy "messages_admin_insert" on public.conversation_messages
  for insert to authenticated
  with check (sender = 'admin' and public.is_admin());
-- Lecture : admins voient tout. Les utilisateurs récupèrent leurs messages via
-- une RPC sécurisée prenant l'anon_code en paramètre (voir get_conversation()).
create policy "messages_admin_select" on public.conversation_messages
  for select using (public.is_admin());

-- ---- IMPROVEMENTS : lecture publique, écriture admin ----
create policy "improvements_public_read" on public.improvements
  for select using (true);
create policy "improvements_admin_write" on public.improvements
  for all using (public.is_admin()) with check (public.is_admin());

-- =============================================================================
-- RPC : récupération anonyme d'une conversation via anon_code.
-- security definer => contourne le RLS de SELECT mais filtre strictement par
-- l'anon_code fourni (connu uniquement de l'auteur).
-- =============================================================================
create or replace function public.get_conversation(p_anon_code text)
returns setof public.conversation_messages
language sql
security definer
set search_path = public
as $$
  select * from public.conversation_messages
  where anon_code = p_anon_code
  order by created_at asc;
$$;
