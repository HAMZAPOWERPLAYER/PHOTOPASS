import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_spacing.dart';
import '../../../core/widgets/app_components.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../data/spec_providers.dart';
import '../data/spec_user_prefs_providers.dart';
import '../domain/country_info.dart';
import '../domain/photo_spec.dart';
import '../domain/spec_l10n.dart';
import '../domain/spec_search.dart';
import 'spec_details_screen.dart';

/// Searchable country list; tapping a country opens its documents and
/// spec summary cards.
class CountrySelectScreen extends ConsumerStatefulWidget {
  const CountrySelectScreen({super.key});

  static const String route = '/country-select';

  @override
  ConsumerState<CountrySelectScreen> createState() =>
      _CountrySelectScreenState();
}

class _CountrySelectScreenState extends ConsumerState<CountrySelectScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final specsAsync = ref.watch(photoSpecsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.countrySelectTitle)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
            child: TextField(
              onChanged: (value) => setState(() => _query = value),
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: l10n.countrySearchHint,
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: _query.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.clear_rounded),
                        tooltip: l10n.commonClose,
                        onPressed: () => setState(() => _query = ''),
                      ),
              ),
            ),
          ),
          // Favourites pinned above the list while browsing (§33.3).
          if (_query.isEmpty) const _FavouritesSection(),
          Expanded(
            child: specsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    l10n.errorGenericBody,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              data: (result) => result.when(
                success: (specs) => _CountryList(specs: specs, query: _query),
                failure: (_) => Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      l10n.errorGenericBody,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Favourite documents as shortcut chips above the country list
/// (spec §33.3); hidden entirely when the user has none.
class _FavouritesSection extends ConsumerWidget {
  const _FavouritesSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final specs = ref.watch(favouriteSpecListProvider);
    if (specs.isEmpty) return const SizedBox.shrink();

    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.lg,
        AppSpacing.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: l10n.homeFavoritesTitle),
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (final (index, spec) in specs.indexed) ...[
                  if (index > 0) const SizedBox(width: AppSpacing.sm),
                  ActionChip(
                    avatar: Text(
                      CountryInfo.flagOf(spec.countryCode),
                      style: const TextStyle(fontSize: 16),
                    ),
                    label: Text(
                      spec.displayName(l10n),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onPressed: () => context.push(
                      SpecDetailsScreen.routeFor(spec.countryCode),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CountryList extends StatelessWidget {
  const _CountryList({required this.specs, required this.query});

  final List<PhotoSpec> specs;
  final String query;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final filtered = searchSpecs(specs, query);
    final grouped = groupByCountry(filtered);

    if (grouped.isEmpty) {
      return Center(
        child: Text(
          l10n.countryNoResults,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }

    final codes = grouped.keys.toList(growable: false);

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: codes.length,
      separatorBuilder: (context, index) =>
          const Divider(height: 1, indent: 76),
      itemBuilder: (context, index) {
        final code = codes[index];
        final countrySpecs = grouped[code]!;

        return ListTile(
          leading: Text(
            CountryInfo.flagOf(code),
            style: const TextStyle(fontSize: 28),
            semanticsLabel: CountryInfo.nameOf(code),
          ),
          title: Text(CountryInfo.nameOf(code)),
          subtitle: Text(
            l10n.countryDocumentsCount(countrySpecs.length),
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          trailing: const Icon(Icons.chevron_right_rounded),
          onTap: () => context.push(SpecDetailsScreen.routeFor(code)),
        );
      },
    );
  }
}
