import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/config/app_config.dart';
import '../../core/constants/sectors.dart';
import '../../core/localization/app_strings.dart';
import '../../core/network/connectivity_service.dart';
import '../../data/repositories/feedback_repository.dart';
import '../../shared/providers/sync_provider.dart';
import 'logic/feedback_rules.dart';
import 'providers/feedback_form_provider.dart';
import 'widgets/location_section.dart';
import 'widgets/rating_selector.dart';

/// Formulaire de feedback V2.1 : nom/adresse d'établissement, validation
/// temps réel (nom obligatoire), type de problème toujours affiché, bouton
/// Envoyer toujours actif. Fonctionne 100% hors ligne.
class FeedbackFormScreen extends ConsumerStatefulWidget {
  const FeedbackFormScreen({
    super.key,
    this.sectorId,
    this.establishmentId,
    this.establishmentName,
    this.expressMode = false,
  });

  final String? sectorId;
  final String? establishmentId;
  final String? establishmentName;
  final bool expressMode;

  @override
  ConsumerState<FeedbackFormScreen> createState() => _FeedbackFormScreenState();
}

class _FeedbackFormScreenState extends ConsumerState<FeedbackFormScreen> {
  final _picker = ImagePicker();
  bool _showErrors = false;
  late final TextEditingController _nameController;
  late final TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _nameController =
        TextEditingController(text: widget.establishmentName ?? '');
    _addressController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(feedbackFormProvider.notifier).init(
            sectorId: widget.sectorId,
            establishmentId: widget.establishmentId,
            establishmentName: widget.establishmentName,
            expressMode: widget.expressMode,
          );
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _pickPhoto() async {
    final form = ref.read(feedbackFormProvider);
    if (form.photoPaths.length >= AppConfig.maxPhotosPerFeedback) return;
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(children: [
          ListTile(
            leading: const Icon(Icons.photo_camera_outlined),
            title: const Text('Camera'),
            onTap: () => Navigator.pop(context, ImageSource.camera),
          ),
          ListTile(
            leading: const Icon(Icons.photo_library_outlined),
            title: const Text('Galerie'),
            onTap: () => Navigator.pop(context, ImageSource.gallery),
          ),
        ]),
      ),
    );
    if (source == null) return;
    final picked = await _picker.pickImage(source: source, imageQuality: 80);
    if (picked != null) {
      ref.read(feedbackFormProvider.notifier).addPhoto(picked.path);
    }
  }

  Future<void> _pickVideo() async {
    final picked = await _picker.pickVideo(
      source: ImageSource.gallery,
      maxDuration: const Duration(seconds: 30),
    );
    if (picked != null) {
      ref.read(feedbackFormProvider.notifier).setVideo(picked.path);
    }
  }

  Future<void> _submit() async {
    final t = AppStrings.of(context);
    final notifier = ref.read(feedbackFormProvider.notifier);
    final form = ref.read(feedbackFormProvider);

    // Le bouton est toujours actif : on valide ici. Seul le nom est requis.
    if (!form.isValid) {
      setState(() => _showErrors = true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t.t('form_invalid_hint'))),
      );
      return;
    }

    notifier.setSubmitting(true);
    try {
      await ref.read(feedbackRepositoryProvider).createLocal(
            // Express sans choix -> catégorie "Autre" (et non plus "Commerce").
            sectorId: form.sectorId ?? 'other',
            establishmentId: form.establishmentId,
            establishmentName: form.establishmentName,
            ratingRaw: form.rating,
            ratingType: form.ratingType,
            comment: form.comment.isEmpty ? null : form.comment,
            suggestion: form.suggestion.isEmpty ? null : form.suggestion,
            isCritical: form.isCritical,
            problemDetails:
                form.problemDetails.isEmpty ? null : form.problemDetails,
            problemTypes: form.problemTypes,
            localPhotoPaths: form.photoPaths,
            localVideoPath: form.videoPath,
            hasLocation: form.hasLocation,
            latitude: form.latitude,
            longitude: form.longitude,
            locationLabel: form.address.isEmpty ? null : form.address,
          );

      final online = ref.read(connectivityProvider).value ?? false;
      if (online) {
        // ignore: unawaited_futures
        ref.read(syncControllerProvider.notifier).sync();
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              online ? t.t('feedback_sent') : t.t('feedback_saved_offline')),
        ),
      );
      context.go('/home');
    } finally {
      if (mounted) notifier.setSubmitting(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppStrings.of(context);
    final form = ref.watch(feedbackFormProvider);
    final v = form.validation;
    final sector = form.sectorId != null ? Sectors.byId(form.sectorId!) : null;
    final scheme = Theme.of(context).colorScheme;

    String? err(String field) => _showErrors && v.errorFor(field) != null
        ? t.t(v.errorFor(field)!)
        : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(form.expressMode
            ? t.t('express_title')
            : (sector != null ? t.t(sector.labelKey) : t.t('give_feedback'))),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
        children: [
          // Bandeau anonymat.
          Card(
            color: scheme.secondaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(children: [
                const Icon(Icons.lock_outline, size: 20),
                const SizedBox(width: 10),
                Expanded(child: Text(t.t('feedback_anonymous_note'))),
              ]),
            ),
          ),
          const SizedBox(height: 16),

          // Sélecteur de catégorie (uniquement si non défini, ex. mode express).
          if (form.sectorId == null) ...[
            DropdownButtonFormField<String>(
              initialValue: null,
              decoration: InputDecoration(
                labelText: t.t('select_category'),
                prefixIcon: const Icon(Icons.category_outlined),
              ),
              items: [
                ...Sectors.all.map((s) => DropdownMenuItem(
                      value: s.id,
                      child: Text(t.t(s.labelKey)),
                    )),
                DropdownMenuItem(
                  value: 'other',
                  child: Text(t.t('sector_other')),
                ),
              ],
              onChanged: (val) {
                if (val != null) {
                  ref.read(feedbackFormProvider.notifier).setSector(val);
                }
              },
            ),
            const SizedBox(height: 12),
          ],

          // Nom de l'établissement (OBLIGATOIRE).
          TextField(
            controller: _nameController,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              labelText: '${t.t('establishment_name')} *',
              prefixIcon: const Icon(Icons.store_outlined),
              errorText: err('establishment'),
            ),
            onChanged:
                ref.read(feedbackFormProvider.notifier).setEstablishmentName,
          ),
          const SizedBox(height: 12),

          // Adresse de l'établissement (optionnelle).
          TextField(
            controller: _addressController,
            decoration: InputDecoration(
              labelText: '${t.t('establishment_address')} ${t.t('optional')}',
              prefixIcon: const Icon(Icons.place_outlined),
            ),
            onChanged: ref.read(feedbackFormProvider.notifier).setAddress,
          ),
          const SizedBox(height: 20),

          // Notation adaptative (facultative).
          Text('${t.t('your_rating')} ${t.t('optional')}',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          RatingSelector(
            type: form.ratingType,
            value: form.rating,
            onTypeChanged: ref.read(feedbackFormProvider.notifier).setRatingType,
            onChanged: ref.read(feedbackFormProvider.notifier).setRating,
          ),

          // Problème grave.
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            secondary: Icon(Icons.warning_amber_rounded,
                color: form.isCritical ? scheme.error : null),
            title: Text(t.t('critical_problem')),
            value: form.isCritical,
            onChanged: ref.read(feedbackFormProvider.notifier).setCritical,
          ),
          const SizedBox(height: 8),

          // Commentaire + compteur.
          TextField(
            minLines: 3,
            maxLines: 6,
            maxLength: FeedbackRules.commentMaxLength,
            decoration: InputDecoration(
              labelText: t.t('comment'),
              hintText: t.t('comment_hint'),
              alignLabelWithHint: true,
              errorText: err('comment'),
            ),
            onChanged: ref.read(feedbackFormProvider.notifier).setComment,
          ),

          // Type de problème : TOUJOURS affiché, en style NEUTRE (pas rouge).
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHighest.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: scheme.outlineVariant),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Icon(Icons.label_outline, size: 18, color: scheme.primary),
                  const SizedBox(width: 6),
                  Text('${t.t('problem_types')} ${t.t('optional')}',
                      style: Theme.of(context).textTheme.titleSmall),
                ]),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: FeedbackRules.problemTypeKeys.map((key) {
                    final selected = form.problemTypes.contains(key);
                    return FilterChip(
                      label: Text(t.t(key)),
                      selected: selected,
                      onSelected: (_) => ref
                          .read(feedbackFormProvider.notifier)
                          .toggleProblemType(key),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 8),
                TextField(
                  minLines: 2,
                  maxLines: 5,
                  maxLength: FeedbackRules.problemDetailsMaxLength,
                  decoration: InputDecoration(
                    labelText: '${t.t('problem_details')} ${t.t('optional')}',
                    alignLabelWithHint: true,
                    errorText: err('problemDetails'),
                  ),
                  onChanged:
                      ref.read(feedbackFormProvider.notifier).setProblemDetails,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Suggestion.
          TextField(
            minLines: 2,
            maxLines: 4,
            decoration: InputDecoration(
              labelText: '${t.t('suggestion')} ${t.t('optional')}',
              alignLabelWithHint: true,
            ),
            onChanged: ref.read(feedbackFormProvider.notifier).setSuggestion,
          ),
          const SizedBox(height: 20),

          // Photos (optionnelles).
          Text('${t.t('add_photos')} ${t.t('optional')}',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          _PhotoRow(
            paths: form.photoPaths,
            onAdd: _pickPhoto,
            onRemove: ref.read(feedbackFormProvider.notifier).removePhoto,
          ),
          const SizedBox(height: 8),

          // Vidéo courte (optionnelle).
          OutlinedButton.icon(
            onPressed: _pickVideo,
            icon: Icon(form.videoPath == null
                ? Icons.videocam_outlined
                : Icons.check_circle_outline),
            label: Text('${t.t('add_video')} ${t.t('optional')}'),
          ),
          const SizedBox(height: 20),

          // Localisation GPS + carte.
          const LocationSection(),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton.icon(
            // Bouton TOUJOURS actif (sauf pendant l'envoi).
            onPressed: form.submitting ? null : _submit,
            icon: form.submitting
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2))
                : const Icon(Icons.send),
            label: Text(t.t('send')),
          ),
        ),
      ),
    );
  }
}

class _PhotoRow extends StatelessWidget {
  const _PhotoRow({
    required this.paths,
    required this.onAdd,
    required this.onRemove,
  });

  final List<String> paths;
  final VoidCallback onAdd;
  final void Function(String) onRemove;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 92,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          if (paths.length < AppConfig.maxPhotosPerFeedback)
            GestureDetector(
              onTap: onAdd,
              child: Container(
                width: 92,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
                child: const Icon(Icons.add_a_photo_outlined),
              ),
            ),
          ...paths.map(
            (p) => Stack(children: [
              Container(
                width: 92,
                height: 92,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  image: DecorationImage(
                    image: FileImage(File(p)),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 2,
                right: 12,
                child: GestureDetector(
                  onTap: () => onRemove(p),
                  child: const CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.black54,
                    child: Icon(Icons.close, size: 14, color: Colors.white),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
