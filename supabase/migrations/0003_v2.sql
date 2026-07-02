-- =============================================================================
-- AnonyFeedback Pro v2.0.0 — Migration V2
-- Statuts, priorité, alertes intelligentes, rôles multi-admin, audit,
-- full-text search, triggers de contraintes/alertes en temps réel,
-- vues publiques anonymisées.
-- À exécuter APRÈS 0001_init.sql et 0002_storage.sql.
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 1) RÔLES MULTI-ADMIN (Super Admin / Admin Domaine / Modérateur)
-- -----------------------------------------------------------------------------
do $$ begin
  create type admin_role as enum ('super_admin', 'domain_admin', 'moderator');
exception when duplicate_object then null; end $$;

alter table public.admins
  add column if not exists role admin_role not null default 'moderator',
  add column if not exists sector_scope text,        -- domaine géré (si domain_admin)
  add column if not exists display_name text;

create or replace function public.admin_role()
returns admin_role language sql security definer set search_path = public as $$
  select role from public.admins where user_id = auth.uid();
$$;

create or replace function public.is_super_admin()
returns boolean language sql security definer set search_path = public as $$
  select exists (select 1 from public.admins
                 where user_id = auth.uid() and role = 'super_admin');
$$;

-- -----------------------------------------------------------------------------
-- 2) NOUVELLES COLONNES sur feedbacks : statut, priorité, criticité, détails
-- -----------------------------------------------------------------------------
do $$ begin
  create type feedback_status as enum ('submitted', 'in_progress', 'resolved');
exception when duplicate_object then null; end $$;

alter table public.feedbacks
  add column if not exists status feedback_status not null default 'submitted',
  add column if not exists priority boolean not null default false,
  add column if not exists is_critical boolean not null default false,
  add column if not exists problem_details text,
  add column if not exists problem_types text[] default '{}',
  add column if not exists video_url text,
  add column if not exists updated_at timestamptz not null default now();

create index if not exists idx_feedbacks_status_v2 on public.feedbacks (status);
create index if not exists idx_feedbacks_priority on public.feedbacks (priority);

-- -----------------------------------------------------------------------------
-- 3) FULL-TEXT SEARCH (recherche plein texte sur commentaire + détails)
-- -----------------------------------------------------------------------------
alter table public.feedbacks
  add column if not exists search_tsv tsvector;

create or replace function public.feedbacks_tsv_update()
returns trigger language plpgsql as $$
begin
  new.search_tsv :=
    setweight(to_tsvector('simple', coalesce(new.comment, '')), 'A') ||
    setweight(to_tsvector('simple', coalesce(new.problem_details, '')), 'B') ||
    setweight(to_tsvector('simple', coalesce(new.suggestion, '')), 'C');
  new.updated_at := now();
  return new;
end $$;

drop trigger if exists trg_feedbacks_tsv on public.feedbacks;
create trigger trg_feedbacks_tsv
  before insert or update on public.feedbacks
  for each row execute function public.feedbacks_tsv_update();

create index if not exists idx_feedbacks_search on public.feedbacks using gin (search_tsv);

-- -----------------------------------------------------------------------------
-- 4) ALERTES INTELLIGENTES (feedback critique -> alerte immédiate admin)
-- -----------------------------------------------------------------------------
create table if not exists public.alerts (
  id uuid primary key default gen_random_uuid(),
  feedback_id uuid not null references public.feedbacks (id) on delete cascade,
  sector_id text,
  level text not null check (level in ('info','warning','critical')),
  message text not null,
  is_read boolean not null default false,
  created_at timestamptz not null default now()
);
create index if not exists idx_alerts_unread on public.alerts (is_read, created_at desc);

-- Trigger : crée une alerte automatiquement à l'insertion d'un feedback
-- critique OU à très basse note (contrainte/logique métier côté serveur).
create or replace function public.feedbacks_auto_alert()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  if new.is_critical or new.rating_normalized < 30 then
    insert into public.alerts (feedback_id, sector_id, level, message)
    values (
      new.id,
      new.sector_id,
      case when new.is_critical then 'critical' else 'warning' end,
      case when new.is_critical
           then 'Problème grave signalé (secteur ' || new.sector_id || ')'
           else 'Note très basse reçue (' || new.rating_normalized || '/100)'
      end
    );
    -- Tout feedback critique devient prioritaire.
    if new.is_critical then
      new.priority := true;
    end if;
  end if;
  return new;
end $$;

drop trigger if exists trg_feedbacks_auto_alert on public.feedbacks;
create trigger trg_feedbacks_auto_alert
  before insert on public.feedbacks
  for each row execute function public.feedbacks_auto_alert();

-- -----------------------------------------------------------------------------
-- 5) CONTRAINTE MÉTIER en temps réel : problème critique => photo obligatoire
--    (même règle que la validation mobile, appliquée aussi côté serveur).
-- -----------------------------------------------------------------------------
create or replace function public.feedbacks_validate()
returns trigger language plpgsql as $$
begin
  if new.is_critical and (new.photo_urls is null or array_length(new.photo_urls, 1) is null) then
    raise exception 'Un problème critique nécessite au moins une photo.';
  end if;
  if new.rating_normalized < 50
     and coalesce(length(trim(new.problem_details)), 0) < 10 then
    raise exception 'Une note basse nécessite des détails sur le problème.';
  end if;
  return new;
end $$;

drop trigger if exists trg_feedbacks_validate on public.feedbacks;
create trigger trg_feedbacks_validate
  before insert on public.feedbacks
  for each row execute function public.feedbacks_validate();

-- -----------------------------------------------------------------------------
-- 6) AUDIT : historique de toutes les actions admin (modération, statut...)
-- -----------------------------------------------------------------------------
create table if not exists public.audit_log (
  id bigint generated always as identity primary key,
  actor uuid references auth.users (id),
  action text not null,
  entity text not null,
  entity_id uuid,
  details jsonb default '{}'::jsonb,
  created_at timestamptz not null default now()
);
create index if not exists idx_audit_created on public.audit_log (created_at desc);

-- Enregistre automatiquement les changements de statut/priorité d'un feedback.
create or replace function public.feedbacks_audit()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  if (old.status is distinct from new.status)
     or (old.priority is distinct from new.priority) then
    insert into public.audit_log (actor, action, entity, entity_id, details)
    values (auth.uid(), 'feedback_update', 'feedback', new.id,
            jsonb_build_object('status', new.status, 'priority', new.priority));
  end if;
  return new;
end $$;

drop trigger if exists trg_feedbacks_audit on public.feedbacks;
create trigger trg_feedbacks_audit
  after update on public.feedbacks
  for each row execute function public.feedbacks_audit();

-- -----------------------------------------------------------------------------
-- 7) VUE PUBLIQUE ANONYMISÉE (transparence : stats par établissement)
-- -----------------------------------------------------------------------------
create or replace view public.public_stats as
select
  f.establishment_id,
  f.sector_id,
  count(*)                              as total,
  round(avg(f.rating_normalized), 1)    as avg_rating,
  count(*) filter (where f.rating_normalized >= 60) as positives,
  count(*) filter (where f.rating_normalized < 40)  as negatives,
  count(*) filter (where f.status = 'resolved')     as resolved
from public.feedbacks f
where f.moderation_status <> 'hidden'
group by f.establishment_id, f.sector_id;

-- -----------------------------------------------------------------------------
-- 8) RLS pour les nouvelles tables
-- -----------------------------------------------------------------------------
alter table public.alerts    enable row level security;
alter table public.audit_log enable row level security;

create policy "alerts_admin_all" on public.alerts
  for all using (public.is_admin()) with check (public.is_admin());

create policy "audit_admin_read" on public.audit_log
  for select using (public.is_admin());

-- Lecture publique de la vue de transparence (anonymisée, sans contenu).
grant select on public.public_stats to anon, authenticated;
