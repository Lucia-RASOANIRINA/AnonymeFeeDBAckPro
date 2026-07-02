import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/config/app_config.dart';
import '../../core/constants/sectors.dart';
import '../../core/localization/app_strings.dart';
import '../../shared/providers/sync_provider.dart';
import 'providers/home_search_provider.dart';
import 'widgets/search_results.dart';
import 'widgets/sector_card.dart';
import 'widgets/sync_status_banner.dart';

/// Page d'accueil : recherche, catégories sectorielles, accès rapides
/// (scan QR, améliorations) et état de synchronisation offline-first.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppStrings.of(context);
    final pending = ref.watch(pendingCountProvider).value ?? 0;
    final isSearching = ref.watch(homeSearchQueryProvider).trim().isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        // Accès admin CACHÉ : appui long sur le titre -> demande un code PIN.
        title: GestureDetector(
          onLongPress: () => _promptAdminPin(context, t),
          child: Text(t.t('app_name')),
        ),
        actions: [
          IconButton(
            tooltip: t.t('settings'),
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      // Deux actions sur la même ligne : "+" (feedback express) à gauche,
      // scan QR à droite (côtés opposés).
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              heroTag: 'fab_express',
              tooltip: t.t('express_title'),
              onPressed: () =>
                  context.push('/feedback', extra: {'expressMode': true}),
              child: const Icon(Icons.add),
            ),
            FloatingActionButton.extended(
              heroTag: 'fab_qr',
              onPressed: () => context.push('/scan'),
              icon: const Icon(Icons.qr_code_scanner),
              label: Text(t.t('scan_qr')),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: SyncStatusBanner()),

            // Barre de recherche intelligente.
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: _HomeSearchField(hint: t.t('search_hint')),
              ),
            ),

            // En mode recherche : résultats affichés directement dans l'accueil.
            if (isSearching)
              const SliverToBoxAdapter(child: HomeSearchResults())
            else ...[
              // Accès rapides.
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: _QuickAction(
                          icon: Icons.history,
                          label: t.t('history'),
                          badge: pending > 0 ? pending : null,
                          onTap: () => context.push('/history'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _QuickAction(
                          icon: Icons.published_with_changes,
                          label: t.t('improvements'),
                          onTap: () => context.push('/improvements'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Titre catégories.
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                  child: Text(
                    t.t('categories'),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),

              // Grille des secteurs.
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 96),
                sliver: SliverGrid(
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.05,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final sector = Sectors.all[index];
                      return SectorCard(
                        sector: sector,
                        onTap: () => context.push(
                          '/feedback',
                          extra: {'sectorId': sector.id},
                        ),
                      );
                    },
                    childCount: Sectors.all.length,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Demande le code PIN admin puis ouvre le tableau de bord si correct.
  Future<void> _promptAdminPin(BuildContext context, AppStrings t) async {
    final controller = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(t.t('admin_dashboard')),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          obscureText: true,
          maxLength: 8,
          decoration: const InputDecoration(labelText: 'PIN'),
          onSubmitted: (_) =>
              Navigator.pop(ctx, controller.text == AppConfig.adminPin),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(t.t('cancel')),
          ),
          FilledButton(
            onPressed: () =>
                Navigator.pop(ctx, controller.text == AppConfig.adminPin),
            child: Text(t.t('continue_')),
          ),
        ],
      ),
    );
    if (ok == true && context.mounted) {
      context.push('/admin');
    }
  }
}

/// Champ de recherche de l'accueil : met à jour [homeSearchQueryProvider] au
/// fil de la frappe et propose un bouton d'effacement.
class _HomeSearchField extends ConsumerStatefulWidget {
  const _HomeSearchField({required this.hint});
  final String hint;

  @override
  ConsumerState<_HomeSearchField> createState() => _HomeSearchFieldState();
}

class _HomeSearchFieldState extends ConsumerState<_HomeSearchField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasText = _controller.text.isNotEmpty;
    return TextField(
      controller: _controller,
      textInputAction: TextInputAction.search,
      onChanged: (v) => ref.read(homeSearchQueryProvider.notifier).set(v),
      decoration: InputDecoration(
        hintText: widget.hint,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: hasText
            ? IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  _controller.clear();
                  ref.read(homeSearchQueryProvider.notifier).set('');
                  setState(() {});
                },
              )
            : null,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.onTap,
    this.badge,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final int? badge;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          child: Row(
            children: [
              Badge(
                isLabelVisible: badge != null,
                label: Text('$badge'),
                child: Icon(icon, color: scheme.primary),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(label, overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
