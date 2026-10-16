import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/locale_controller.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../app/theme/theme_controller.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/app_components.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../editor/data/edit_session.dart';
import '../../history/data/history_providers.dart';

/// Settings tab: appearance, language, privacy controls and about.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  static const String route = '/settings';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final themeMode = ref.watch(themeControllerProvider);
    final selectedLocale = ref.watch(localeControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.navSettings)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          SectionHeader(title: l10n.settingsAppearance),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SegmentedButton<ThemeMode>(
              showSelectedIcon: false,
              segments: [
                ButtonSegment(
                  value: ThemeMode.light,
                  icon: const Icon(Icons.light_mode_outlined),
                  label: Text(l10n.settingsThemeLight),
                ),
                ButtonSegment(
                  value: ThemeMode.system,
                  icon: const Icon(Icons.brightness_auto_outlined),
                  label: Text(l10n.settingsThemeSystem),
                ),
                ButtonSegment(
                  value: ThemeMode.dark,
                  icon: const Icon(Icons.dark_mode_outlined),
                  label: Text(l10n.settingsThemeDark),
                ),
              ],
              selected: {themeMode},
              onSelectionChanged: (selection) =>
                  ref.read(themeControllerProvider.notifier).setMode(
                    selection.first,
                  ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          SectionHeader(title: l10n.settingsGeneral),
          Card(
            child: ListTile(
              leading: const Icon(Icons.translate_rounded),
              title: Text(l10n.settingsLanguage),
              subtitle: Text(
                selectedLocale == null
                    ? l10n.settingsThemeSystem
                    : LocaleController.languageNames[selectedLocale
                            .toLanguageTag()] ??
                          selectedLocale.toLanguageTag(),
              ),
              onTap: () => _showLanguagePicker(context, ref),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          SectionHeader(title: l10n.settingsPrivacy),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.delete_forever_outlined),
                  title: Text(l10n.settingsClearHistory),
                  subtitle: Text(l10n.settingsClearHistoryHint),
                  onTap: () => _confirmClearData(context, ref),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          SectionHeader(title: l10n.settingsAbout),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.privacy_tip_outlined),
                  title: Text(l10n.settingsPrivacyPolicy),
                  onTap: () => _showPrivacyPolicy(context),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.info_outline_rounded),
                  title: Text(l10n.settingsVersion(AppConstants.appVersion)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.disclaimer,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  void _showLanguagePicker(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(bottom: 12),
          children: [
            ListTile(
              title: Text(l10n.settingsThemeSystem),
              onTap: () {
                ref.read(localeControllerProvider.notifier).setLocale(null);
                Navigator.of(sheetContext).pop();
              },
            ),
            for (final entry in LocaleController.languageNames.entries)
              ListTile(
                title: Text(entry.value),
                onTap: () {
                  ref
                      .read(localeControllerProvider.notifier)
                      .setLocale(Locale(entry.key));
                  Navigator.of(sheetContext).pop();
                },
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmClearData(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.settingsClearHistory),
        content: Text(l10n.settingsClearHistoryConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.commonCancel),
          ),
          AppButton(
            label: l10n.settingsClearHistoryAction,
            variant: AppButtonVariant.destructive,
            onPressed: () => Navigator.of(dialogContext).pop(true),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;
    await ref.read(historyProvider.notifier).clearAll();
    await clearTempPhotos();
    ref.read(editSessionProvider.notifier).reset();
  }

  void _showPrivacyPolicy(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.settingsPrivacyPolicy),
        content: SingleChildScrollView(child: Text(l10n.privacyPolicyBody)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(l10n.commonClose),
          ),
        ],
      ),
    );
  }
}
