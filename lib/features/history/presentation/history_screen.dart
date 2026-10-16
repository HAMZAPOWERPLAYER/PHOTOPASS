import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import '../../../app/flow/selected_spec_provider.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/widgets/app_components.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../country_select/domain/photo_spec.dart';
import '../../country_select/domain/spec_l10n.dart';
import '../../editor/data/edit_session.dart';
import '../../editor/presentation/editor_screen.dart';
import '../data/history_providers.dart';
import '../domain/history_repository.dart';

/// History tab: locally saved photos with reopen/share/delete. Missing
/// source files degrade to a clear placeholder — the record is kept
/// (spec §33.9).
class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  static const String route = '/history';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(historyProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.navHistory)),
      body: state.loading
          ? const Center(child: CircularProgressIndicator())
          : state.entries.isEmpty
          ? AppEmptyState(
              icon: Icons.photo_library_outlined,
              title: l10n.historyEmptyTitle,
              body: l10n.historyEmptyBody,
              actionLabel: l10n.homeCreatePhoto,
              onAction: () => context.go('/home'),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(AppSpacing.md),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 160,
                mainAxisSpacing: AppSpacing.md,
                crossAxisSpacing: AppSpacing.md,
                childAspectRatio: .74,
              ),
              itemCount: state.entries.length,
              itemBuilder: (context, index) {
                final entry = state.entries[index];
                final spec = ref.watch(historySpecProvider(entry.specId));
                return _HistoryCard(
                  filePath: entry.filePath,
                  title: spec == null ? entry.specId : spec.displayName(l10n),
                  dateLabel: _dateLabel(entry.createdAt),
                  onOpen: spec == null
                      ? null
                      : () => _openEntry(context, ref, entry, spec),
                  onShare: () => SharePlus.instance.share(
                    ShareParams(files: [XFile(entry.filePath)]),
                  ),
                  onDelete: () => ref
                      .read(historyProvider.notifier)
                      .remove(entry.id),
                );
              },
            ),
    );
  }

  /// `yyyy-MM-dd` from the ISO timestamp — locale-neutral numerals only.
  static String _dateLabel(String iso) => iso.length >= 10
      ? iso.substring(0, 10)
      : iso;

  /// Reopens a saved photo in the editor as a fresh source (spec §33.9).
  Future<void> _openEntry(
    BuildContext context,
    WidgetRef ref,
    HistoryEntry entry,
    PhotoSpec spec,
  ) async {
    ref.read(selectedSpecProvider.notifier).select(spec);
    await ref
        .read(editSessionProvider.notifier)
        .loadFromCapture(entry.filePath, spec);
    if (context.mounted) await context.push(EditorScreen.route);
  }
}

class _HistoryCard extends StatelessWidget {
  const _HistoryCard({
    required this.filePath,
    required this.title,
    required this.dateLabel,
    required this.onShare,
    required this.onDelete,
    this.onOpen,
  });

  final String filePath;
  final String title;
  final String dateLabel;
  final VoidCallback? onOpen;
  final VoidCallback onShare;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image.file(
              File(filePath),
              fit: BoxFit.cover,
              // Missing/unreadable file: keep the record, explain clearly.
              errorBuilder: (_, _, _) => ColoredBox(
                color: theme.colorScheme.surfaceContainerHighest,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.broken_image_outlined,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        l10n.historyMissingPhoto,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 2),
            child: Text(
              dateLabel,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (onOpen != null)
                IconButton(
                  onPressed: onOpen,
                  icon: const Icon(Icons.edit_outlined, size: 20),
                  tooltip: l10n.historyReopen,
                ),
              IconButton(
                onPressed: onShare,
                icon: const Icon(Icons.ios_share_outlined, size: 20),
                tooltip: l10n.exportShare,
              ),
              IconButton(
                onPressed: onDelete,
                icon: const Icon(Icons.delete_outline_rounded, size: 20),
                tooltip: l10n.historyDelete,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
