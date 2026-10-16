import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../app/flow/selected_spec_provider.dart';
import '../../../core/widgets/placeholder_screen.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../country_select/domain/photo_spec.dart';
import '../../editor/presentation/editor_screen.dart';
import '../data/camera_service.dart';
import '../data/permission_service.dart';
import '../domain/face_guide.dart';
import 'face_guide_painter.dart';

/// Camera capture with the spec-driven face guide, plus gallery import.
class CaptureScreen extends ConsumerStatefulWidget {
  const CaptureScreen({super.key});

  static const String route = '/capture';

  @override
  ConsumerState<CaptureScreen> createState() => _CaptureScreenState();
}

class _CaptureScreenState extends ConsumerState<CaptureScreen> {
  CameraController? _controller;
  bool _initializing = false;
  bool _showRationale = false;
  bool _permanentlyDenied = false;
  bool _usingFrontCamera = false;
  bool _capturing = false;
  FlashMode _flashMode = FlashMode.auto;
  String? _error;

  @override
  void initState() {
    super.initState();
    _startCaptureFlow();
  }

  /// Entry point: permission first, then camera.
  Future<void> _startCaptureFlow() async {
    final service = ref.read(permissionServiceProvider);
    if (await service.isGranted()) {
      await _initCamera();
    } else if (mounted) {
      final permanent = await service.isPermanentlyDenied();
      if (!mounted) return;
      setState(() {
        _showRationale = true;
        _permanentlyDenied = permanent;
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _initCamera() async {
    final spec = ref.read(selectedSpecProvider);
    if (spec == null) return;

    setState(() {
      _initializing = true;
      _error = null;
      _showRationale = false;
    });

    try {
      final service = ref.read(cameraServiceProvider);
      final cameras = await service.availableCameras();
      if (cameras.isEmpty) {
        setState(() => _error = 'no-camera');
        return;
      }

      final camera = cameras.firstWhere(
        (camera) => camera.lensDirection ==
            (_usingFrontCamera
                ? CameraLensDirection.front
                : CameraLensDirection.back),
        orElse: () => cameras.first,
      );

      final controller = service.createController(camera);
      await controller.initialize();
      if (!mounted) {
        await controller.dispose();
        return;
      }
      setState(() => _controller = controller);
      // Apply the selected flash mode; not every device supports every mode.
      controller.setFlashMode(_flashMode).ignore();
    } on CameraException catch (e) {
      if (mounted) setState(() => _error = e.code);
    } finally {
      if (mounted) setState(() => _initializing = false);
    }
  }

  Future<void> _requestPermission() async {
    final service = ref.read(permissionServiceProvider);
    final granted = await service.request();
    if (granted) {
      await _initCamera();
    } else if (mounted) {
      final permanent = await service.isPermanentlyDenied();
      setState(() {
        _showRationale = true;
        _permanentlyDenied = permanent;
      });
    }
  }

  Future<void> _takePicture() async {
    final controller = _controller;
    if (controller == null || _capturing) return;

    setState(() => _capturing = true);
    try {
      final file = await controller.takePicture();
      if (!mounted) return;
      ref.read(capturedPhotoProvider.notifier).setPath(file.path);
      await context.push(EditorScreen.route);
    } on CameraException catch (e) {
      if (mounted) setState(() => _error = e.code);
    } finally {
      if (mounted) setState(() => _capturing = false);
    }
  }

  Future<void> _pickFromGallery() async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 4096,
      maxHeight: 4096,
    );
    if (picked == null || !mounted) return;
    ref.read(capturedPhotoProvider.notifier).setPath(picked.path);
    await context.push(EditorScreen.route);
  }

  void _switchCamera() {
    setState(() => _usingFrontCamera = !_usingFrontCamera);
    _controller?.dispose();
    _controller = null;
    _initCamera();
  }

  /// Cycles auto → always → off (spec §33.4); failures are ignored because
  /// not every lens/device supports every flash mode.
  void _cycleFlash() {
    setState(() {
      _flashMode = switch (_flashMode) {
        FlashMode.auto => FlashMode.always,
        FlashMode.always => FlashMode.off,
        _ => FlashMode.auto,
      };
    });
    _controller?.setFlashMode(_flashMode).ignore();
  }

  IconData get _flashIcon => switch (_flashMode) {
    FlashMode.off => Icons.flash_off_rounded,
    FlashMode.always => Icons.flash_on_rounded,
    _ => Icons.flash_auto_rounded,
  };

  @override
  Widget build(BuildContext context) {
    final spec = ref.watch(selectedSpecProvider);
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    if (spec == null) {
      return PlaceholderScreen(title: l10n.captureTitle);
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(l10n.captureTitle),
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      body: _buildBody(context, l10n, theme, spec),
    );
  }

  Widget _buildBody(
    BuildContext context,
    AppLocalizations l10n,
    ThemeData theme,
    PhotoSpec spec,
  ) {
    if (_showRationale) {
      return _PermissionRationale(
        permanentlyDenied: _permanentlyDenied,
        onRequest: _requestPermission,
        onOpenSettings: () => ref.read(permissionServiceProvider).openSettings(),
      );
    }

    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.no_photography_outlined,
                size: 56,
                color: theme.colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                l10n.captureCameraError,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: _initCamera,
                icon: const Icon(Icons.refresh_rounded),
                label: Text(l10n.commonRetry),
              ),
            ],
          ),
        ),
      );
    }

    if (_initializing || _controller == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final guide = FaceGuide.fromSpec(spec);

    return Stack(
      fit: StackFit.expand,
      children: [
        CameraPreview(_controller!),
        IgnorePointer(
          child: CustomPaint(
            painter: FaceGuidePainter(
              guide: guide,
              frameAspect: spec.widthMm / spec.heightMm,
              color: Colors.white,
            ),
          ),
        ),
        // Live hint banner area (face analysis arrives in Phase 4).
        Positioned(
          top: 16,
          left: 16,
          right: 16,
          child: Text(
            l10n.captureHintFace,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: _cycleFlash,
                  iconSize: 32,
                  tooltip: l10n.captureFlash,
                  color: _flashMode == FlashMode.off
                      ? Colors.white54
                      : Colors.white,
                  icon: Icon(_flashIcon),
                ),
                IconButton(
                  onPressed: _pickFromGallery,
                  iconSize: 32,
                  tooltip: l10n.captureGallery,
                  color: Colors.white,
                  icon: const Icon(Icons.photo_library_outlined),
                ),
                // Shutter: large, one-handed friendly.
                GestureDetector(
                  onTap: _takePicture,
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _capturing
                          ? Colors.white38
                          : Colors.white,
                      border: Border.all(color: Colors.black26, width: 4),
                    ),
                    child: _capturing
                        ? const CircularProgressIndicator()
                        : null,
                  ),
                ),
                IconButton(
                  onPressed: _switchCamera,
                  iconSize: 32,
                  tooltip: l10n.captureSwitchCamera,
                  color: Colors.white,
                  icon: const Icon(Icons.cameraswitch_outlined),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Shown when camera permission is denied; explains why before re-requesting.
class _PermissionRationale extends StatelessWidget {
  const _PermissionRationale({
    required this.permanentlyDenied,
    required this.onRequest,
    required this.onOpenSettings,
  });

  final bool permanentlyDenied;
  final VoidCallback onRequest;
  final VoidCallback onOpenSettings;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.photo_camera_outlined,
              size: 64,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(height: 24),
            Text(
              l10n.captureRationaleTitle,
              style: theme.textTheme.headlineSmall?.copyWith(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              permanentlyDenied
                  ? l10n.captureRationaleDenied
                  : l10n.captureRationaleBody,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: permanentlyDenied ? onOpenSettings : onRequest,
              icon: permanentlyDenied
                  ? const Icon(Icons.settings_rounded)
                  : const Icon(Icons.photo_camera_rounded),
              label: Text(
                permanentlyDenied
                    ? l10n.captureOpenSettings
                    : l10n.captureRationaleAction,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
