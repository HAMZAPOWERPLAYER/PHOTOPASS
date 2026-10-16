import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/flow/selected_spec_provider.dart';
import '../../../app/flow/user_data_controller.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../capture/presentation/capture_screen.dart';
import '../data/spec_providers.dart';
import '../domain/country_info.dart';
import '../domain/photo_spec.dart';
import '../domain/spec_l10n.dart';

/// One country's document list with per-spec summary cards: size,
/// background, verified badge and the official source link.
class SpecDetailsScreen extends ConsumerWidget {
  const SpecDetailsScreen({super.key, required this.countryCode});

  /// Route template with a `code` path parameter.
  static const String route = '/spec-details/:code';

  /// Builds the concrete location for [countryCode].
  static String routeFor(String countryCode) => '/spec-details/$countryCode';

  final String countryCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final specsAsync = ref.watch(photoSpecsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(CountryInfo.nameOf(countryCode))),
      body: specsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) =>
            Center(child: Text(l10n.errorGenericBody)),
        data: (result) => result.when(
          success: (specs) {
            final countrySpecs = specs
                .where((spec) => spec.countryCode == countryCode)
                .toList(growable: false);

            if (countrySpecs.isEmpty) {
              return Center(child: Text(l10n.countryNoResults));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: countrySpecs.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _SpecCard(spec: countrySpecs[index]),
              ),
            );
          },
          failure: (_) => Center(child: Text(l10n.errorGenericBody)),
        ),
      ),
    );
  }
}

class _SpecCard extends ConsumerWidget {
  const _SpecCard({required this.spec});

  final PhotoSpec spec;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final color = Color(int.parse('FF${spec.backgroundHex.substring(1)}', radix: 16));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    spec.displayName(l10n),
                    style: theme.textTheme.titleLarge,
                  ),
                ),
                _VerifiedBadge(verified: spec.verified),
                const SizedBox(width: AppSpacing.xs),
                _FavoriteButton(spec: spec),
              ],
            ),
            const SizedBox(height: 16),
            _DataRow(
              icon: Icons.straighten_rounded,
              label: l10n.specSizeLabel,
              value:
                  '${spec.widthMm.toStringAsFixed(0)} × '
                  '${spec.heightMm.toStringAsFixed(0)} mm · '
                  '${spec.widthPx} × ${spec.heightPx} px @ ${spec.dpi} DPI',
            ),
            _DataRow(
              icon: Icons.format_color_fill_rounded,
              label: l10n.specBackgroundLabel,
              value: spec.backgroundHex,
              swatch: color,
            ),
            _DataRow(
              icon: Icons.face_rounded,
              label: l10n.specHeadHeightLabel,
              value: spec.headHeightMinPct == null
                  ? l10n.specNotSpecified
                  : '${spec.headHeightMinPct!.toStringAsFixed(0)}–'
                        '${spec.headHeightMaxPct!.toStringAsFixed(0)}%',
            ),
            _DataRow(
              icon: Icons.visibility_outlined,
              label: spec.glassesAllowed
                  ? l10n.specGlassesAllowed
                  : l10n.specGlassesNotAllowed,
              value: '',
            ),
            if (spec.notes != null) ...[
              const SizedBox(height: 8),
              Text(
                spec.notes!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.public_rounded, size: 18, color: scheme.primary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    l10n.specLastVerified(spec.lastVerified),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => _openSource(context),
                  child: Text(l10n.specOfficialSource),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {
                  ref.read(selectedSpecProvider.notifier).select(spec);
                  context.push(CaptureScreen.route);
                },
                icon: const Icon(Icons.photo_camera_outlined),
                label: Text(l10n.specUsePhoto),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Opens the official source page in the system browser.
  Future<void> _openSource(BuildContext context) async {
    final uri = Uri.parse(spec.sourceUrl);
    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!launched && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).errorGenericBody)),
      );
    }
  }
}

/// Star toggle that persists the specification to the user's favourites
/// (spec §33.3). State and label never rely on colour alone.
class _FavoriteButton extends ConsumerWidget {
  const _FavoriteButton({required this.spec});

  final PhotoSpec spec;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isFavorite = ref.watch(
      favouritesProvider.select((favourites) => favourites.contains(spec.id)),
    );
    return IconButton(
      onPressed: () => ref.read(favouritesProvider.notifier).toggle(spec.id),
      tooltip: isFavorite ? l10n.specFavoriteRemove : l10n.specFavoriteAdd,
      icon: Icon(
        isFavorite ? Icons.star_rounded : Icons.star_border_rounded,
        color: isFavorite
            ? theme.colorScheme.primary
            : theme.colorScheme.onSurfaceVariant,
      ),
    );
  }
}

class _VerifiedBadge extends StatelessWidget {
  const _VerifiedBadge({required this.verified});

  final bool verified;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final color = verified ? scheme.tertiary : scheme.error;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            verified ? Icons.verified_rounded : Icons.help_outline_rounded,
            size: 16,
            color: color,
          ),
          const SizedBox(width: 4),
          Text(
            verified ? l10n.specVerifiedBadge : l10n.specUnverifiedBadge,
            style: theme.textTheme.labelSmall?.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}

class _DataRow extends StatelessWidget {
  const _DataRow({
    required this.icon,
    required this.label,
    required this.value,
    this.swatch,
  });

  final IconData icon;
  final String label;
  final String value;

  /// Optional colour swatch shown before [value] (background colour row).
  final Color? swatch;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: theme.colorScheme.onSurfaceVariant),
          const SizedBox(width: 8),
          Text(label, style: theme.textTheme.bodyMedium),
          const Spacer(),
          if (swatch != null) ...[
            Container(
              width: 14,
              height: 14,
              margin: const EdgeInsetsDirectional.only(end: 6),
              decoration: BoxDecoration(
                color: swatch,
                border: Border.all(color: theme.colorScheme.outline),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
          if (value.isNotEmpty)
            Flexible(
              child: Text(
                value,
                textAlign: TextAlign.end,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
