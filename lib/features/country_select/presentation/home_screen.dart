import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/flow/selected_spec_provider.dart';
import '../../../app/flow/user_data_controller.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/widgets/app_components.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../capture/presentation/capture_screen.dart';
import '../../history/presentation/history_screen.dart';
import '../data/spec_providers.dart';
import '../data/spec_user_prefs_providers.dart';
import '../domain/country_info.dart';
import '../domain/photo_spec.dart';
import '../domain/spec_l10n.dart';
import 'country_select_screen.dart';

/// Home tab (spec §33.2): one dominant primary action, search, recents,
/// popular categories, favourites and a useful "your photos" state.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static const String route = '/home';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final specsAsync = ref.watch(photoSpecsProvider);
    final recents = ref.watch(recentSpecListProvider);
    final favourites = ref.watch(favouriteSpecListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.photo_camera_outlined, color: theme.colorScheme.primary),
            const SizedBox(width: AppSpacing.sm),
            Text(l10n.appTitle),
          ],
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            Text(l10n.homeHeadline, style: theme.textTheme.headlineMedium),
            const SizedBox(height: AppSpacing.lg),
            // Single dominant primary action (spec §33.2).
            AppButton(
              label: l10n.homeCreatePhoto,
              icon: Icons.add_a_photo_outlined,
              expand: true,
              onPressed: () => context.push(CountrySelectScreen.route),
            ),
            const SizedBox(height: AppSpacing.xl),
            // Search opens the full country/document flow.
            InkWell(
              borderRadius: BorderRadius.circular(AppRadius.md),
              onTap: () => context.push(CountrySelectScreen.route),
              child: InputDecorator(
                decoration: InputDecoration(
                  hintText: l10n.homeSearchHint,
                  prefixIcon: const Icon(Icons.search_rounded),
                ),
                child: const SizedBox(height: 0),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            if (recents.isNotEmpty) ...[
              SectionHeader(title: l10n.homeRecentTitle),
              _SpecRow(specs: recents, l10n: l10n, ref: ref),
              const SizedBox(height: AppSpacing.xl),
            ],
            SectionHeader(title: l10n.homePopularTitle),
            Wrap(
              spacing: AppSpacing.md,
              runSpacing: AppSpacing.md,
              children: [
                _PopularChip(
                  icon: Icons.badge_outlined,
                  label: l10n.homePassport,
                  onTap: () => context.push(CountrySelectScreen.route),
                ),
                _PopularChip(
                  icon: Icons.flight_outlined,
                  label: l10n.homeVisa,
                  onTap: () => context.push(CountrySelectScreen.route),
                ),
                _PopularChip(
                  icon: Icons.credit_card_outlined,
                  label: l10n.homeIdCard,
                  onTap: () => context.push(CountrySelectScreen.route),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            if (favourites.isNotEmpty) ...[
              SectionHeader(title: l10n.homeFavoritesTitle),
              _SpecRow(specs: favourites, l10n: l10n, ref: ref),
              const SizedBox(height: AppSpacing.xl),
            ],
            SectionHeader(title: l10n.homeYourPhotosTitle),
            Card(
              child: ListTile(
                leading: Icon(
                  Icons.photo_library_outlined,
                  color: theme.colorScheme.primary,
                ),
                title: Text(l10n.navHistory),
                subtitle: Text(l10n.homeYourPhotosEmpty),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () => context.go(HistoryScreen.route),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Center(
              child: specsAsync.hasError
                  ? Text(
                      l10n.errorGenericBody,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

/// Horizontal row of specification chips used for recents and favourites.
class _SpecRow extends StatelessWidget {
  const _SpecRow({required this.specs, required this.l10n, required this.ref});

  final List<PhotoSpec> specs;
  final AppLocalizations l10n;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final (index, spec) in specs.indexed) ...[
            if (index > 0) const SizedBox(width: AppSpacing.md),
            _SpecChip(
              spec: spec,
              label: spec.displayName(l10n),
              onTap: () {
                ref.read(selectedSpecProvider.notifier).select(spec);
                ref.read(recentSpecsProvider.notifier).record(spec.id);
                context.push(CaptureScreen.route);
              },
            ),
          ],
        ],
      ),
    );
  }
}

class _SpecChip extends StatelessWidget {
  const _SpecChip({required this.spec, required this.label, required this.onTap});

  final PhotoSpec spec;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = '${spec.widthMm % 1 == 0 ? spec.widthMm.toInt() : spec.widthMm}'
        ' × '
        '${spec.heightMm % 1 == 0 ? spec.heightMm.toInt() : spec.heightMm}'
        ' mm';

    return Material(
      color: theme.colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        side: BorderSide(color: theme.colorScheme.outline),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(CountryInfo.flagOf(spec.countryCode), style: const TextStyle(fontSize: 22)),
              const SizedBox(width: AppSpacing.sm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(label, style: theme.textTheme.titleSmall),
                  Text(
                    size,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PopularChip extends StatelessWidget {
  const _PopularChip({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: theme.colorScheme.surfaceContainerLow,
      borderRadius: BorderRadius.circular(AppRadius.xl),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: theme.colorScheme.primary),
              const SizedBox(width: AppSpacing.sm),
              Text(label, style: theme.textTheme.titleSmall),
            ],
          ),
        ),
      ),
    );
  }
}
