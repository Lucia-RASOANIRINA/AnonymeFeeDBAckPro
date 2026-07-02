-- =============================================================================
-- FeedbackPro — Remplacer les photos factices des améliorations par de vraies
-- images (toujours disponibles), sans dépendre du bucket storage.
-- =============================================================================
-- Les anciennes URLs (before-1.jpg, after-1.jpg…) n'existent pas dans le
-- storage → images cassées. On pointe vers un service d'images public fiable
-- (picsum.photos), avec une image stable par amélioration :
--   * « Avant »  en noir et blanc (illustre le problème)
--   * « Après » en couleur       (illustre l'amélioration)
--
-- À exécuter dans Supabase → SQL Editor (projet bwkqzmdodbewhbrvkzpv).
-- =============================================================================

update public.improvements
set
  before_photo_url = 'https://picsum.photos/seed/before-' || id::text || '/800/600?grayscale',
  after_photo_url  = 'https://picsum.photos/seed/after-'  || id::text || '/800/600';

-- Vérification : toutes les URLs doivent désormais commencer par picsum.photos.
-- select id, title, before_photo_url, after_photo_url from public.improvements limit 5;
