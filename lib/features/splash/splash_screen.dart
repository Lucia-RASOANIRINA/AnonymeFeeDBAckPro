import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/localization/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../auth/providers/auth_provider.dart';

/// Écran de démarrage : lance l'authentification ANONYME automatique puis
/// redirige vers l'accueil. Ne bloque jamais l'utilisateur même hors ligne
/// (mode offline-first : on entre dans l'app et on synchronisera plus tard).
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    // Tente la session anonyme, mais ne bloque JAMAIS le démarrage : double
    // garde-fou (timeout interne + timeout ici) pour éviter tout spinner infini.
    try {
      await ref
          .read(authProvider.notifier)
          .ensureAnonymousSession()
          .timeout(const Duration(seconds: 9));
    } catch (_) {
      // On démarre quand même en mode local (offline-first).
    }
    // Petit délai pour laisser le splash s'afficher proprement.
    await Future.delayed(const Duration(milliseconds: 400));
    if (mounted) context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    final t = AppStrings.of(context);
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
              ),
              child: const Icon(
                Icons.forum_rounded,
                size: 52,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              t.t('app_name'),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                t.t('tagline'),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white.withValues(alpha: 0.85)),
              ),
            ),
            const SizedBox(height: 40),
            const SizedBox(
              width: 26,
              height: 26,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
