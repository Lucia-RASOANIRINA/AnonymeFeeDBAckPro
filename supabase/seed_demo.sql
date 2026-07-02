-- =============================================================================
-- Données de démonstration RÉALISTES et cohérentes (OPTIONNEL).
-- =============================================================================
-- À exécuter dans Supabase → SQL Editor si ta base est vide et que tu veux des
-- données fonctionnelles pour tester le dashboard et l'app.
--
-- ⚠️ Ce script n'EFFACE rien : il ajoute des établissements, feedbacks et
-- améliorations cohérents. Les secteurs correspondent à l'app mobile
-- (health, education, commerce, public_admin, hospitality, transport).
--
-- Les feedbacks respectent les contraintes serveur (0003_v2.sql) :
--   - une note < 50 fournit toujours des détails (problem_details) ;
--   - aucun feedback critique sans photo n'est inséré.
-- Les alertes sont créées AUTOMATIQUEMENT par les triggers pour les notes < 30.
-- =============================================================================

-- 1) Établissements -----------------------------------------------------------
insert into public.establishments (name, sector_id, address, qr_code) values
  ('CHU Joseph Ravoahangy', 'health',       'Ampefiloha, Antananarivo', 'chu-jra'),
  ('Lycée Andohalo',        'education',     'Andohalo, Antananarivo',   'lycee-andohalo'),
  ('Marché d''Andravoahangy','commerce',     'Andravoahangy, Antananarivo','marche-andravoahangy'),
  ('Mairie d''Antananarivo','public_admin',  'Analakely, Antananarivo',  'mairie-tana'),
  ('Gare routière Mahamasina','transport',   'Mahamasina, Antananarivo', 'gare-mahamasina'),
  ('Restaurant La Varangue','hospitality',   'Isoraka, Antananarivo',    'resto-varangue')
on conflict (qr_code) do nothing;

-- 2) Feedbacks (cohérents avec les établissements) ----------------------------
insert into public.feedbacks
  (establishment_id, sector_id, rating_normalized, rating_raw, rating_type,
   comment, problem_details, anon_code, moderation_status)
select e.id, e.sector_id, v.rating, v.raw, 'stars',
       v.comment, v.details, v.code, v.status
from (values
  ('chu-jra',            'health',       80, 4, 'Accueil correct, personnel attentif.',        null,                                          'FB-A1B2C', 'validated'),
  ('chu-jra',            'health',       20, 1, 'Attente interminable aux urgences.',           'Plus de 4 heures d''attente sans information.','FB-D3E4F', 'new'),
  ('lycee-andohalo',     'education',    90, 5, 'Excellents enseignants et locaux propres.',    null,                                          'FB-G5H6I', 'validated'),
  ('lycee-andohalo',     'education',    45, 2, 'Classes surchargées.',                          'Plus de 60 élèves par classe, manque de tables.','FB-J7K8L','new'),
  ('marche-andravoahangy','commerce',    70, 4, 'Bon marché, produits frais.',                  null,                                          'FB-M9N0O', 'validated'),
  ('mairie-tana',        'public_admin', 30, 2, 'Délais administratifs très longs.',            'Trois passages nécessaires pour un acte de naissance.','FB-P1Q2R','new'),
  ('gare-mahamasina',    'transport',    60, 3, 'Gare propre mais bus peu ponctuels.',          null,                                          'FB-S3T4U', 'validated'),
  ('resto-varangue',     'hospitality',  85, 4, 'Cuisine savoureuse, service rapide.',          null,                                          'FB-V5W6X', 'validated'),
  ('gare-mahamasina',    'transport',    25, 1, 'Véhicules en mauvais état.',                    'Pneus lisses et portes qui ne ferment pas.',  'FB-Y7Z8A', 'new'),
  ('marche-andravoahangy','commerce',    55, 3, 'Prix parfois élevés.',                          null,                                          'FB-B9C0D', 'validated')
) as v(qr, sector_id, rating, raw, comment, details, code, status)
join public.establishments e on e.qr_code = v.qr
where not exists (select 1 from public.feedbacks f where f.anon_code = v.code);

-- 3) Améliorations (avant / après) --------------------------------------------
insert into public.improvements (establishment_id, title, description)
select e.id, v.title, v.description
from (values
  ('lycee-andohalo', 'Rénovation de la cantine scolaire',
     'Nouveaux équipements et davantage de places assises à la cantine.'),
  ('chu-jra', 'Réduction du temps d''attente',
     'Recrutement de 5 infirmiers pour réduire l''attente aux urgences.'),
  ('gare-mahamasina', 'Affichage temps réel des bus',
     'Installation d''un écran d''information à la gare routière.'),
  ('mairie-tana', 'Guichet unique pour l''état civil',
     'Un seul passage désormais nécessaire pour un acte administratif.')
) as v(qr, title, description)
join public.establishments e on e.qr_code = v.qr
where not exists (
  select 1 from public.improvements i where i.title = v.title
);
