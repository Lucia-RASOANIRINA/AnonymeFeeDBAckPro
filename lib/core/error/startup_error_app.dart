import 'dart:io';

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Application minimale affichée si l'initialisation (Supabase, Isar, prefs)
/// échoue. Évite l'écran noir et propose de relancer l'application.
class StartupErrorApp extends StatelessWidget {
  const StartupErrorApp({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.lightBackground,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.cloud_off, size: 64, color: AppColors.primary),
                const SizedBox(height: 16),
                const Text(
                  'Démarrage impossible',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: () => exit(0),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Fermer'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
