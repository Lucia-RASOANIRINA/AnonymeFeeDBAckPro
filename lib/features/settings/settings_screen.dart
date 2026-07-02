import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/localization/app_strings.dart';
import '../../shared/providers/settings_provider.dart';

/// Paramètres : langue (instantané), thème, accessibilité.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppStrings.of(context);
    final settings = ref.watch(settingsProvider);
    final notifier = ref.read(settingsProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text(t.t('settings'))),
      body: ListView(
        children: [
          // --- Langue (changement instantané) ---
          _SectionHeader(title: t.t('language')),
          RadioGroup<String>(
            groupValue: settings.locale.languageCode,
            onChanged: (v) => notifier.setLocale(Locale(v!)),
            child: const Column(
              children: [
                RadioListTile<String>(
                    title: Text('Malagasy'), value: 'mg'),
                RadioListTile<String>(
                    title: Text('Français'), value: 'fr'),
                RadioListTile<String>(
                    title: Text('English'), value: 'en'),
              ],
            ),
          ),
          const Divider(),

          // --- Thème ---
          _SectionHeader(title: t.t('theme')),
          RadioGroup<ThemeMode>(
            groupValue: settings.themeMode,
            onChanged: (v) => notifier.setThemeMode(v!),
            child: Column(
              children: [
                RadioListTile<ThemeMode>(
                    title: Text(t.t('theme_system')),
                    value: ThemeMode.system),
                RadioListTile<ThemeMode>(
                    title: Text(t.t('theme_light')), value: ThemeMode.light),
                RadioListTile<ThemeMode>(
                    title: Text(t.t('theme_dark')), value: ThemeMode.dark),
              ],
            ),
          ),
          const Divider(),

          // --- Accessibilité ---
          _SectionHeader(title: t.t('accessibility')),
          SwitchListTile(
            title: Text(t.t('high_contrast')),
            value: settings.highContrast,
            onChanged: notifier.setHighContrast,
          ),
          ListTile(
            title: Text(t.t('large_text')),
            subtitle: Slider(
              min: 0.8,
              max: 1.6,
              divisions: 8,
              value: settings.textScale,
              label: '${(settings.textScale * 100).round()}%',
              onChanged: notifier.setTextScale,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
