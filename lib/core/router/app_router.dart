import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/admin/admin_dashboard_screen.dart';
import '../../features/conversation/conversation_screen.dart';
import '../../features/feedback/feedback_form_screen.dart';
import '../../features/history/history_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/improvements/improvements_screen.dart';
import '../../features/qr_scanner/qr_scanner_screen.dart';
import '../../features/settings/settings_screen.dart';
import '../../features/splash/splash_screen.dart';

/// Configuration centralisée des routes (go_router).
final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (_, _) => const SplashScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (_, _) => const HomeScreen(),
      ),
      GoRoute(
        path: '/feedback',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return FeedbackFormScreen(
            sectorId: extra?['sectorId'] as String?,
            establishmentId: extra?['establishmentId'] as String?,
            establishmentName: extra?['establishmentName'] as String?,
            expressMode: extra?['expressMode'] as bool? ?? false,
          );
        },
      ),
      GoRoute(
        path: '/scan',
        builder: (_, _) => const QrScannerScreen(),
      ),
      GoRoute(
        path: '/history',
        builder: (_, _) => const HistoryScreen(),
      ),
      GoRoute(
        path: '/improvements',
        builder: (_, _) => const ImprovementsScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (_, _) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/admin',
        builder: (_, _) => const AdminDashboardScreen(),
      ),
      GoRoute(
        path: '/conversation',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return ConversationScreen(
            feedbackId: extra?['feedbackId'] as String? ?? '',
            anonCode: extra?['anonCode'] as String? ?? '',
            asAdmin: extra?['asAdmin'] as bool? ?? false,
          );
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Route introuvable: ${state.uri}')),
    ),
  );
});
