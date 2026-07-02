-- =============================================================================
-- FeedbackPro — Buckets de stockage + politiques
-- =============================================================================
-- Deux buckets :
--   * feedback-photos    : photos jointes aux feedbacks (upload anonyme).
--   * improvement-photos : photos avant/après publiées par les admins.
-- =============================================================================

insert into storage.buckets (id, name, public)
values
  ('feedback-photos', 'feedback-photos', true),
  ('improvement-photos', 'improvement-photos', true)
on conflict (id) do nothing;

-- Lecture publique des deux buckets (les photos publiées sont visibles de tous).
create policy "public_read_feedback_photos" on storage.objects
  for select using (bucket_id = 'feedback-photos');
create policy "public_read_improvement_photos" on storage.objects
  for select using (bucket_id = 'improvement-photos');

-- Upload anonyme autorisé sur feedback-photos (session anonyme = authenticated).
create policy "anon_upload_feedback_photos" on storage.objects
  for insert to authenticated
  with check (bucket_id = 'feedback-photos');

-- improvement-photos : écriture réservée aux admins.
create policy "admin_write_improvement_photos" on storage.objects
  for insert to authenticated
  with check (bucket_id = 'improvement-photos' and public.is_admin());
