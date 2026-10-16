import 'dart:async' show unawaited;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/flow/selected_spec_provider.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/errors/result_extensions.dart';
import '../../../core/widgets/app_components.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../capture/data/camera_service.dart';
import '../../compliance/presentation/compliance_screen.dart';
import '../../country_select/domain/photo_spec.dart';
import '../data/edit_session.dart';
import '../data/image_pipeline.dart';
import '../domain/crop_engine.dart';

enum _EditorMode { crop, background, adjust }

/// Photo-first editor (spec §33.5): the photograph occupies most of the
/// screen, with a mode selector for crop, background replacement and image
/// adjustments, contextual controls below, and one persistent Continue
/// action. Leaving with unsaved edits asks for confirmation (§34.1).
class EditorScreen extends ConsumerStatefulWidget {
  const EditorScreen({super.key});

  static const String route = '/editor';

  @override
  ConsumerState<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends ConsumerState<EditorScreen> {
  _EditorMode _mode = _EditorMode.crop;
  late RetouchSettings _draft;
  bool _touched = false;
  bool _continuing = false;
  bool _wasCurrent = true;

  // Live processed preview for the background/adjust modes. `_base` is the
  // cropped preview (spec aspect); `_shown` is `_base` after the draft is
  // applied. Both are display-resolution only — never full-res copies.
  ProcessedImage? _base;
  ProcessedImage? _shown;
  ProcessedImage? _baseSourcePreview;
  PixelRect? _baseCrop;
  bool _previewBusy = false;
  bool _previewError = false;
  int _gen = 0;

  @override
  void initState() {
    super.initState();
    _draft = ref.read(editSessionProvider).retouch;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final current = ModalRoute.of(context)?.isCurrent ?? true;
    // Popping back from compliance/export may have released the images to
    // save memory — reload the source, preserving the manual crop.
    if (current && !_wasCurrent) _maybeLoad();
    _wasCurrent = current;
  }

  /// Loads the captured/imported photo once, when visible.
  void _maybeLoad() {
    if (!mounted) return;
    final route = ModalRoute.of(context);
    if (route != null && !route.isCurrent) return;
    final session = ref.read(editSessionProvider);
    final spec = ref.read(selectedSpecProvider);
    if (spec == null || session.busy || session.errorKey != null) return;
    final source = session.sourcePath ?? ref.read(capturedPhotoProvider);
    if (source == null) return;
    if (session.working != null && session.sourcePath == source) return;
    ref.read(editSessionProvider.notifier).loadFromCapture(source, spec);
  }

  Future<void> _retryLoad() async {
    final session = ref.read(editSessionProvider);
    final spec = ref.read(selectedSpecProvider);
    final source = session.sourcePath ?? ref.read(capturedPhotoProvider);
    if (spec == null || source == null) return;
    await ref.read(editSessionProvider.notifier).loadFromCapture(source, spec);
  }

  // ------------------------------------------------------- preview pipeline

  /// Invalidates the cached display preview when the session's image, crop
  /// or rotation changes (called from build; schedules async work only).
  void _syncPreviewBase(EditSessionState session) {
    final preview = session.preview;
    final crop = session.crop;
    final working = session.working;
    if (preview == null || crop == null || working == null) {
      if (_base != null || _shown != null || _previewBusy) {
        _base = null;
        _shown = null;
        _baseSourcePreview = null;
        _baseCrop = null;
        _previewBusy = false;
        _previewError = false;
      }
      return;
    }
    if (identical(_baseSourcePreview, preview) &&
        identical(_baseCrop, crop)) {
      return;
    }
    _baseSourcePreview = preview;
    _baseCrop = crop;
    _base = null;
    _shown = null;
    _previewError = false;
    if (_mode != _EditorMode.crop) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _computeBase());
    }
  }

  /// Crops the display-sized preview to the current crop rectangle.
  Future<void> _computeBase() async {
    final session = ref.read(editSessionProvider);
    final preview = session.preview;
    final crop = session.crop;
    final working = session.working;
    if (!mounted || preview == null || crop == null || working == null) {
      return;
    }
    _baseSourcePreview = preview;
    _baseCrop = crop;
    final gen = ++_gen;
    final scale = working.width == 0 ? 1.0 : preview.width / working.width;
    final rect = PixelRect(
      x: crop.x * scale,
      y: crop.y * scale,
      w: crop.w * scale,
      h: crop.h * scale,
    );
    setState(() {
      _previewBusy = true;
      _previewError = false;
    });
    final result = await ref.read(imagePipelineProvider).crop(preview, rect);
    if (!mounted || gen != _gen) return;
    if (!result.isSuccess) {
      setState(() {
        _previewBusy = false;
        _previewError = true;
      });
      return;
    }
    setState(() {
      _base = result.requireValue;
      _shown = _base;
      _previewBusy = false;
    });
    unawaited(_runRetouchPreview());
  }

  /// Applies the draft settings to the preview so the background/adjust
  /// modes show the actual processed result (spec §33.6), not a simulation.
  Future<void> _runRetouchPreview() async {
    final base = _base;
    if (base == null || !mounted) return;
    final gen = ++_gen;
    setState(() {
      _previewBusy = true;
      _previewError = false;
    });
    final result = await ref
        .read(editSessionProvider.notifier)
        .previewRetouch(base, _draft);
    if (!mounted || gen != _gen) return;
    setState(() {
      _previewBusy = false;
      if (result.isSuccess) {
        _shown = result.requireValue;
      } else {
        _previewError = true;
      }
    });
  }

  // ------------------------------------------------------------- behaviour

  void _setMode(_EditorMode mode) {
    if (mode == _mode) return;
    setState(() => _mode = mode);
    if (mode != _EditorMode.crop && _base == null) unawaited(_computeBase());
  }

  void _updateDraft(RetouchSettings next, {bool process = false}) {
    setState(() {
      _draft = next;
      _touched = true;
    });
    ref.read(editSessionProvider.notifier).markEdited();
    if (process && _mode != _EditorMode.crop) {
      unawaited(_runRetouchPreview());
    }
  }

  void _resetAll() {
    ref.read(editSessionProvider.notifier).autoFit();
    setState(() {
      _draft = const RetouchSettings();
      _touched = false;
      _mode = _EditorMode.crop;
    });
  }

  void _confirmDiscard() {
    final l10n = AppLocalizations.of(context);
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.editorDiscardTitle),
        content: Text(l10n.editorDiscardBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(l10n.commonCancel),
          ),
          AppButton(
            label: l10n.editorDiscardConfirm,
            variant: AppButtonVariant.destructive,
            onPressed: () {
              Navigator.of(dialogContext).pop();
              _discardEdits();
            },
          ),
        ],
      ),
    );
  }

  void _discardEdits() {
    final notifier = ref.read(editSessionProvider.notifier);
    notifier.autoFit(); // back to the face-guided suggestion
    notifier.markEdited();
    setState(() {
      _draft = const RetouchSettings();
      _touched = false;
    });
    if (mounted) context.pop();
  }

  Future<void> _continue() async {
    if (_continuing) return;
    setState(() => _continuing = true);
    final notifier = ref.read(editSessionProvider.notifier);
    final cropResult = await notifier.applyCrop();
    if (!cropResult.isSuccess) {
      if (mounted) setState(() => _continuing = false);
      return;
    }
    final retouchResult = await notifier.applyRetouch(_draft);
    if (!mounted) return;
    if (!retouchResult.isSuccess) {
      setState(() => _continuing = false);
      return;
    }
    setState(() => _continuing = false);
    unawaited(context.push(ComplianceScreen.route));
    // Free full-resolution previews while compliance/export only need the
    // finalised file (spec §37.4).
    ref.read(editSessionProvider.notifier).releaseImages();
  }

  // ------------------------------------------------------------------ build

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final session = ref.watch(editSessionProvider);
    final spec = ref.watch(selectedSpecProvider);

    _syncPreviewBase(session);
    WidgetsBinding.instance.addPostFrameCallback((_) => _maybeLoad());

    return PopScope(
      canPop:
          !_touched ||
          _continuing ||
          session.busy ||
          session.finalPath != null,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop && mounted) _confirmDiscard();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.editorTitle),
          actions: [
            if (_mode == _EditorMode.crop) ...[
              IconButton(
                tooltip: l10n.editorRotate,
                onPressed:
                    session.working == null || session.busy
                    ? null
                    : () {
                        _touched = true;
                        unawaited(
                          ref.read(editSessionProvider.notifier).rotate(),
                        );
                      },
                icon: const Icon(Icons.rotate_90_degrees_cw_outlined),
              ),
              IconButton(
                tooltip: l10n.editorAutoFit,
                onPressed:
                    session.working == null || session.busy
                    ? null
                    : () {
                        _touched = true;
                        unawaited(
                          ref.read(editSessionProvider.notifier).autoFit(),
                        );
                      },
                icon: const Icon(Icons.center_focus_strong_outlined),
              ),
            ],
            IconButton(
              tooltip: l10n.editorReset,
              onPressed: session.working == null || session.busy
                  ? null
                  : _resetAll,
              icon: const Icon(Icons.restart_alt_rounded),
            ),
          ],
        ),
        body: SafeArea(child: _buildBody(l10n, session, spec)),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: AppButton(
              label: l10n.commonContinue,
              icon: Icons.arrow_forward_rounded,
              expand: true,
              busy: _continuing || session.busy,
              onPressed:
                  session.working == null ||
                      session.crop == null ||
                      session.busy
                  ? null
                  : _continue,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(
    AppLocalizations l10n,
    EditSessionState session,
    PhotoSpec? spec,
  ) {
    final errorKey = session.errorKey;
    if (errorKey != null) {
      return _ErrorView(onRetry: _retryLoad);
    }
    if (session.preview == null ||
        session.working == null ||
        session.crop == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final photo = _buildPhoto(l10n, session);
        final controls = _buildControls(l10n, session, spec);
        final wide =
            constraints.maxWidth > constraints.maxHeight &&
            constraints.maxWidth >= 600;
        if (wide) {
          // Landscape/tablet: photo left, controls in a right rail (§36).
          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(flex: 5, child: photo),
              const VerticalDivider(width: 1),
              SizedBox(
                width: 360,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: controls,
                ),
              ),
            ],
          );
        }
        return Column(
          children: [
            Expanded(child: photo),
            _buildControls(l10n, session, spec),
          ],
        );
      },
    );
  }

  Widget _buildPhoto(AppLocalizations l10n, EditSessionState session) {
    if (_mode == _EditorMode.crop) {
      return _CropView(
        session: session,
        onEdited: () => _touched = true,
      );
    }
    final shown = _shown ?? _base;
    if (shown == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.memory(shown.bytes, fit: BoxFit.contain, gaplessPlayback: true),
        if (_previewBusy)
          const Positioned.fill(
            child: ColoredBox(
              color: Colors.black38,
              child: Center(
                child: SizedBox(
                  width: 28,
                  height: 28,
                  child: CircularProgressIndicator(strokeWidth: 2.5),
                ),
              ),
            ),
          ),
        if (_previewError)
          Positioned.fill(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.errorGenericBody,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    AppButton(
                      label: l10n.commonRetry,
                      icon: Icons.refresh_rounded,
                      onPressed: () => unawaited(_computeBase()),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildControls(
    AppLocalizations l10n,
    EditSessionState session,
    PhotoSpec? spec,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          child: SegmentedButton<_EditorMode>(
            showSelectedIcon: false,
            segments: [
              ButtonSegment(
                value: _EditorMode.crop,
                label: Text(l10n.editorModeCrop),
              ),
              ButtonSegment(
                value: _EditorMode.background,
                label: Text(l10n.editorModeBackground),
              ),
              ButtonSegment(
                value: _EditorMode.adjust,
                label: Text(l10n.editorModeAdjust),
              ),
            ],
            selected: {_mode},
            onSelectionChanged: (selection) => _setMode(selection.first),
          ),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 280),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              0,
              AppSpacing.lg,
              AppSpacing.lg,
            ),
            child: switch (_mode) {
              _EditorMode.crop => _CropControls(l10n: l10n),
              _EditorMode.background => _BackgroundControls(
                  l10n: l10n,
                  spec: spec,
                  draft: _draft,
                  onChanged: _updateDraft,
                ),
              _EditorMode.adjust => _AdjustControls(
                  l10n: l10n,
                  draft: _draft,
                  onChanged: _updateDraft,
                ),
            },
          ),
        ),
      ],
    );
  }
}

/// Interactive crop: pan/zoom gestures locked to the spec's aspect ratio
/// with dimming, rule-of-thirds guides.
class _CropView extends ConsumerWidget {
  const _CropView({required this.session, required this.onEdited});

  final EditSessionState session;
  final VoidCallback onEdited;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preview = session.preview;
    final crop = session.crop;
    final working = session.working;
    if (preview == null || crop == null || working == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final viewport = Size(constraints.maxWidth, constraints.maxHeight);
        // Fit the working image (contain) inside the viewport.
        final fitScale = [
          viewport.width / working.width,
          viewport.height / working.height,
        ].reduce((a, b) => a < b ? a : b);
        final displayW = working.width * fitScale;
        final displayH = working.height * fitScale;
        final origin = Offset(
          (viewport.width - displayW) / 2,
          (viewport.height - displayH) / 2,
        );

        final cropDisplay = Rect.fromLTWH(
          origin.dx + crop.x * fitScale,
          origin.dy + crop.y * fitScale,
          crop.w * fitScale,
          crop.h * fitScale,
        );

        return GestureDetector(
          onScaleStart: (_) => onEdited(),
          onScaleUpdate: (details) {
            onEdited();
            final notifier = ref.read(editSessionProvider.notifier);
            // Convert screen deltas to image pixels.
            notifier.panCrop(
              details.focalPointDelta.dx / fitScale,
              details.focalPointDelta.dy / fitScale,
            );
            if (details.scale != 1 && details.pointerCount > 1) {
              final focal = details.localFocalPoint;
              notifier.zoomCrop(
                details.scale,
                (focal.dx - origin.dx) / fitScale,
                (focal.dy - origin.dy) / fitScale,
              );
            }
          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.memory(preview.bytes, fit: BoxFit.fill, gaplessPlayback: true),
              // Dim everything outside the crop window.
              CustomPaint(
                painter: _CropShadePainter(viewport: viewport, crop: cropDisplay),
              ),
              // Crop window border.
              Positioned(
                left: cropDisplay.left,
                top: cropDisplay.top,
                width: cropDisplay.width,
                height: cropDisplay.height,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: CustomPaint(
                    painter: _RuleOfThirdsPainter(
                      color: Colors.white.withValues(alpha: .5),
                    ),
                  ),
                ),
              ),
              if (session.busy)
                const Positioned.fill(
                  child: ColoredBox(
                    color: Colors.black38,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _CropShadePainter extends CustomPainter {
  const _CropShadePainter({required this.viewport, required this.crop});

  final Size viewport;
  final Rect crop;

  @override
  void paint(Canvas canvas, Size size) {
    final shade = Path()
      ..fillType = PathFillType.evenOdd
      ..addRect(Offset.zero & size)
      ..addRect(crop);
    canvas.drawPath(shade, Paint()..color = Colors.black.withValues(alpha: .55));
  }

  @override
  bool shouldRepaint(_CropShadePainter oldDelegate) =>
      oldDelegate.crop != crop || oldDelegate.viewport != viewport;
}

class _RuleOfThirdsPainter extends CustomPainter {
  const _RuleOfThirdsPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = .7;
    for (var i = 1; i <= 2; i++) {
      canvas.drawLine(
        Offset(size.width * i / 3, 0),
        Offset(size.width * i / 3, size.height),
        paint,
      );
      canvas.drawLine(
        Offset(0, size.height * i / 3),
        Offset(size.width, size.height * i / 3),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_RuleOfThirdsPainter oldDelegate) =>
      oldDelegate.color != color;
}

// ------------------------------------------------------------- error states

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.onRetry});

  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 40,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(l10n.errorGenericBody, textAlign: TextAlign.center),
            const SizedBox(height: AppSpacing.lg),
            AppButton(
              label: l10n.commonRetry,
              icon: Icons.refresh_rounded,
              onPressed: onRetry,
            ),
          ],
        ),
      ),
    );
  }
}

// ----------------------------------------------------------- control panels

class _CropControls extends StatelessWidget {
  const _CropControls({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.xs),
      child: Row(
        children: [
          Icon(Icons.open_with_rounded, size: 18, color: theme.colorScheme.onSurfaceVariant),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              l10n.editorCropHint,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

typedef _DraftCallback = void Function(RetouchSettings next, {bool process});

/// Background replacement: required/suggested palette distinction (§33.6),
/// tolerance control, and a real processed preview driven by the parent.
class _BackgroundControls extends StatelessWidget {
  const _BackgroundControls({
    required this.l10n,
    required this.spec,
    required this.draft,
    required this.onChanged,
  });

  final AppLocalizations l10n;
  final PhotoSpec? spec;
  final RetouchSettings draft;
  final _DraftCallback onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final requiredHex = (spec?.backgroundHex ?? '#FFFFFF').toUpperCase();
    // Required colour first, then the neutral suggestions.
    final colors = <String>{
      requiredHex,
      '#FFFFFF',
      '#F2F2F2',
      '#DFE7EF',
    }.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(l10n.retouchRemoveBackground),
          subtitle: Text(l10n.retouchRemoveBackgroundHint),
          value: draft.removeBackground,
          onChanged: (value) =>
              onChanged(draft.copyWith(removeBackground: value), process: true),
        ),
        if (draft.removeBackground) ...[
          Text(
            l10n.retouchTolerance(draft.backgroundTolerance.round()),
            style: theme.textTheme.bodySmall,
          ),
          Slider(
            value: draft.backgroundTolerance,
            min: 10,
            max: 120,
            divisions: 11,
            onChangeEnd: (value) => onChanged(
              draft.copyWith(backgroundTolerance: value),
              process: true,
            ),
            onChanged: (value) =>
                onChanged(draft.copyWith(backgroundTolerance: value)),
          ),
          Text(
            l10n.retouchBackgroundColor,
            style: theme.textTheme.titleSmall,
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.sm,
            children: [
              for (final hex in colors)
                _BgSwatch(
                  hex: hex,
                  requiredColor: hex == requiredHex,
                  selected: draft.backgroundHex.toUpperCase() == hex,
                  labels: (required: l10n.swatchRequired, suggested: l10n.swatchSuggested),
                  onSelected: () =>
                      onChanged(draft.copyWith(backgroundHex: hex), process: true),
                ),
            ],
          ),
        ],
        const SizedBox(height: AppSpacing.sm),
        Text(
          l10n.retouchLocalNote,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _BgSwatch extends StatelessWidget {
  const _BgSwatch({
    required this.hex,
    required this.requiredColor,
    required this.selected,
    required this.labels,
    required this.onSelected,
  });

  final String hex;
  final bool requiredColor;
  final bool selected;
  final ({String required, String suggested}) labels;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = Color(int.parse('FF${hex.substring(1)}', radix: 16));
    return InkWell(
      onTap: onSelected,
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color,
              border: Border.all(
                color: selected || requiredColor
                    ? theme.colorScheme.primary
                    : theme.colorScheme.outline,
                width: selected ? 3 : requiredColor ? 2 : 1,
              ),
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: selected
                ? Icon(
                    Icons.check_rounded,
                    size: 20,
                    color: Colors.black.withValues(alpha: .55),
                  )
                : null,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            requiredColor ? labels.required : labels.suggested,
            style: theme.textTheme.labelSmall?.copyWith(
              color: requiredColor
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurfaceVariant,
              fontWeight: requiredColor ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

/// Brightness/contrast/saturation with visible numeric feedback (§33.5).
class _AdjustControls extends StatelessWidget {
  const _AdjustControls({
    required this.l10n,
    required this.draft,
    required this.onChanged,
  });

  final AppLocalizations l10n;
  final RetouchSettings draft;
  final _DraftCallback onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _AdjustmentSlider(
          label: l10n.retouchBrightness,
          value: draft.brightness,
          onChangeEnd: (v) =>
              onChanged(draft.copyWith(brightness: v), process: true),
          onChanged: (v) => onChanged(draft.copyWith(brightness: v)),
        ),
        _AdjustmentSlider(
          label: l10n.retouchContrast,
          value: draft.contrast,
          onChangeEnd: (v) =>
              onChanged(draft.copyWith(contrast: v), process: true),
          onChanged: (v) => onChanged(draft.copyWith(contrast: v)),
        ),
        _AdjustmentSlider(
          label: l10n.retouchSaturation,
          value: draft.saturation,
          onChangeEnd: (v) =>
              onChanged(draft.copyWith(saturation: v), process: true),
          onChanged: (v) => onChanged(draft.copyWith(saturation: v)),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          l10n.retouchLocalNote,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _AdjustmentSlider extends StatelessWidget {
  const _AdjustmentSlider({
    required this.label,
    required this.value,
    required this.onChanged,
    required this.onChangeEnd,
  });

  final String label;
  final double value;
  final ValueChanged<double> onChanged;
  final ValueChanged<double> onChangeEnd;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 96, child: Text(label)),
        Expanded(
          child: Slider(
            value: value,
            min: -100,
            max: 100,
            onChanged: onChanged,
            onChangeEnd: onChangeEnd,
          ),
        ),
        SizedBox(
          width: 44,
          child: Text(
            value.round().toString(),
            textAlign: TextAlign.end,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}
