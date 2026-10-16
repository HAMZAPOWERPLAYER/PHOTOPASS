import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gal/gal.dart';
import 'package:share_plus/share_plus.dart';

import '../../../app/flow/selected_spec_provider.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../country_select/domain/photo_spec.dart';
import '../../editor/data/edit_session.dart';
import '../../history/data/file_history_repository.dart';
import '../../history/data/history_providers.dart';
import '../data/export_service.dart';
import '../domain/print_sheet.dart';

/// Export: exact-size photo, print sheet, PDF — save to gallery or share.
/// Everything is produced on-device.
class ExportScreen extends ConsumerStatefulWidget {
  const ExportScreen({super.key});

  static const String route = '/export';

  @override
  ConsumerState<ExportScreen> createState() => _ExportScreenState();
}

class _ExportScreenState extends ConsumerState<ExportScreen> {
  bool _busy = false;
  String? _messageKey;

  String get _source =>
      ref.read(editSessionProvider).finalPath ??
      ref.read(editSessionProvider).croppedPath ??
      '';

  Future<void> _run(Future<bool> Function() action, String okKey) async {
    if (_busy) return;
    setState(() {
      _busy = true;
      _messageKey = null;
    });
    final ok = await action();
    if (!mounted) return;
    setState(() {
      _busy = false;
      _messageKey = ok ? okKey : 'errorGenericTitle';
    });
  }

  Future<bool> _saveToGallery(String path) async {
    try {
      await Gal.putImage(path);
      await _recordHistory(path);
      return true;
    } on Exception {
      return false;
    }
  }

  /// Keeps a local copy in history so the photo is re-shareable later.
  Future<void> _recordHistory(String path) async {
    final spec = ref.read(selectedSpecProvider);
    if (spec == null) return;
    final repo = ref.read(historyRepositoryProvider);
    if (repo is! FileHistoryRepository) return;
    await repo.importPhoto(
      sourcePath: path,
      specId: spec.id,
      countryCode: spec.countryCode,
    );
    await ref.read(historyProvider.notifier).refresh();
  }

  Future<bool> _share(String path, {bool asPdf = false}) async {
    try {
      await SharePlus.instance.share(
        ShareParams(files: [XFile(path)], text: asPdf ? null : 'PhotoPass'),
      );
      return true;
    } on Exception {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final spec = ref.watch(selectedSpecProvider);
    final source = _source;

    if (spec == null || source.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.exportTitle)),
        body: Center(child: Text(l10n.errorGenericBody)),
      );
    }

    final messageKey = _messageKey;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.exportTitle)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.file(
              File(source),
              fit: BoxFit.contain,
              errorBuilder: (_, _, _) => const AspectRatio(
                aspectRatio: 35 / 45,
                child: ColoredBox(color: Colors.black12),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.exportSizeLabel(spec.widthPx, spec.heightPx),
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 4),
          // Technical detail stays available but secondary (§33.8).
          _DetailsDisclosure(spec: spec, l10n: l10n, theme: theme),
          const SizedBox(height: 16),
          _ActionCard(
            icon: Icons.photo_outlined,
            title: l10n.exportSavePhoto,
            subtitle: l10n.exportSavePhotoHint,
            onTap: _busy
                ? null
                : () => _run(() async => _saveToGallery(source), 'exportDoneSave'),
          ),
          _ActionCard(
            icon: Icons.ios_share_outlined,
            title: l10n.exportShare,
            subtitle: l10n.exportShareHint,
            onTap: _busy
                ? null
                : () => _run(() => _share(source), 'exportDoneShare'),
          ),
          _ActionCard(
            icon: Icons.picture_as_pdf_outlined,
            title: l10n.exportPdf,
            subtitle: l10n.exportPdfHint,
            onTap: _busy
                ? null
                : () => _run(() async {
                    final result = await ref
                        .read(exportServiceProvider)
                        .buildPdf(sourcePath: source, spec: spec);
                    return result.when(
                      success: (file) => _share(file.path, asPdf: true),
                      failure: (_) => false,
                    );
                  }, 'exportDonePdf'),
          ),
          Text(
            l10n.exportPrintSheetTitle,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          for (final sheet in SheetPreset.all)
            _ActionCard(
              icon: Icons.grid_on_outlined,
              title: l10n.exportPrintSheet(
                sheet.id == 'a4' ? 'A4' : '10×15 cm',
              ),
              subtitle: l10n.exportPrintSheetHint,
              onTap: _busy
                  ? null
                  : () => _run(() async {
                      final result = await ref
                          .read(exportServiceProvider)
                          .buildPrintSheet(
                            sourcePath: source,
                            spec: spec,
                            sheet: sheet,
                          );
                      return result.when(
                        success: (file) => _share(file.path),
                        failure: (_) => false,
                      );
                    }, 'exportDoneSheet'),
            ),
          if (messageKey != null) ...[
            const SizedBox(height: 8),
            Text(
              switch (messageKey) {
                'errorGenericTitle' => l10n.errorGenericBody,
                'exportDonePdf' => l10n.exportDonePdf,
                'exportDoneSheet' => l10n.exportDoneSheet,
                'exportDoneShare' => l10n.exportDoneShare,
                _ => l10n.exportDoneSave,
              },
              style: theme.textTheme.bodyMedium?.copyWith(
                color: messageKey == 'errorGenericTitle'
                    ? theme.colorScheme.error
                    : theme.colorScheme.primary,
              ),
            ),
          ],
          if (_busy) ...[
            const SizedBox(height: 16),
            const Center(child: CircularProgressIndicator()),
          ],
          const SizedBox(height: 16),
          Text(
            l10n.exportLocalNote,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
        enabled: onTap != null,
        onTap: onTap,
      ),
    );
  }
}

/// Collapsible technical details: physical size, DPI, file-size limit and
/// accepted formats — shown only when the user asks for them (§33.8).
class _DetailsDisclosure extends StatelessWidget {
  const _DetailsDisclosure({
    required this.spec,
    required this.l10n,
    required this.theme,
  });

  final PhotoSpec spec;
  final AppLocalizations l10n;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final limit = spec.maxFileSizeKb;
    return Theme(
      data: theme.copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        dense: true,
        title: Text(
          l10n.exportAdvancedDetails,
          style: theme.textTheme.titleSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        iconColor: theme.colorScheme.onSurfaceVariant,
        childrenPadding: const EdgeInsets.only(bottom: 8),
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              l10n.exportDetails(
                spec.widthMm.toStringAsFixed(0),
                spec.dpi.toString(),
              ),
              style: theme.textTheme.bodySmall,
            ),
          ),
          if (limit != null)
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                l10n.exportFileSizeLimit(limit),
                style: theme.textTheme.bodySmall,
              ),
            ),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              spec.fileFormats.join(' · '),
              style: theme.textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
