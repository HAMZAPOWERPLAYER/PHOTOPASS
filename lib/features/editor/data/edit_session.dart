import 'dart:io' show Directory, File, Platform;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import '../../../app/flow/selected_spec_provider.dart';
import '../../../core/errors/failure.dart';
import '../../../core/errors/result.dart';
import '../../../core/errors/result_extensions.dart';
import '../../country_select/domain/photo_spec.dart';
import '../../face_detection/data/face_detection_service.dart';
import '../../face_detection/domain/detected_face.dart';
import '../domain/crop_engine.dart';
import 'image_pipeline.dart';

/// Everything the crop/retouch/compliance/export flow needs, carried
/// between screens. Photos stay in app-private temp files on-device.
class EditSessionState {
  const EditSessionState({
    this.sourcePath,
    this.preview,
    this.working,
    this.crop,
    this.face,
    this.croppedPath,
    this.retouch = const RetouchSettings(),
    this.finalPath,
    this.busy = false,
    this.errorKey,
  });

  final String? sourcePath;
  final ProcessedImage? preview;
  final ProcessedImage? working;
  final PixelRect? crop;
  final DetectedFace? face;

  /// Full-resolution cropped file, written by [EditSessionController.applyCrop].
  final String? croppedPath;

  final RetouchSettings retouch;

  /// Final processed file (after retouch), consumed by compliance/export.
  final String? finalPath;

  final bool busy;
  final String? errorKey;

  EditSessionState copyWith({
    String? sourcePath,
    ProcessedImage? preview,
    ProcessedImage? working,
    PixelRect? crop,
    DetectedFace? face,
    String? croppedPath,
    RetouchSettings? retouch,
    String? finalPath,
    bool? busy,
    String? errorKey,
  }) => EditSessionState(
    sourcePath: sourcePath ?? this.sourcePath,
    preview: preview ?? this.preview,
    working: working ?? this.working,
    crop: crop ?? this.crop,
    face: face ?? this.face,
    croppedPath: croppedPath ?? this.croppedPath,
    retouch: retouch ?? this.retouch,
    finalPath: finalPath ?? this.finalPath,
    busy: busy ?? this.busy,
    errorKey: errorKey,
  );
}

/// User-tunable retouch parameters (Phase 5). All processed on-device.
class RetouchSettings {
  const RetouchSettings({
    this.removeBackground = false,
    this.backgroundTolerance = 40,
    this.backgroundHex = '#FFFFFF',
    this.brightness = 0,
    this.contrast = 0,
    this.saturation = 0,
  });

  /// Sliders use [-100, 100]; 0 means untouched.
  final double brightness;
  final double contrast;
  final double saturation;

  final bool removeBackground;

  /// Color-distance tolerance (0–255) for the border flood fill.
  final double backgroundTolerance;

  /// Replacement background colour as `#RRGGBB`.
  final String backgroundHex;

  RetouchSettings copyWith({
    double? brightness,
    double? contrast,
    double? saturation,
    bool? removeBackground,
    double? backgroundTolerance,
    String? backgroundHex,
  }) => RetouchSettings(
    brightness: brightness ?? this.brightness,
    contrast: contrast ?? this.contrast,
    saturation: saturation ?? this.saturation,
    removeBackground: removeBackground ?? this.removeBackground,
    backgroundTolerance: backgroundTolerance ?? this.backgroundTolerance,
    backgroundHex: backgroundHex ?? this.backgroundHex,
  );
}

/// Drives the whole photo flow: load → crop → retouch.
class EditSessionController extends Notifier<EditSessionState> {
  @override
  EditSessionState build() => const EditSessionState();

  ImagePipeline get _pipeline => ref.read(imagePipelineProvider);

  /// Loads [path] (captured or imported), builds a preview and runs face
  /// detection to seed the auto-crop.
  ///
  /// Reloading the *same* source (e.g. returning from compliance after the
  /// images were released to save memory) preserves the manual crop, face and
  /// retouch draft instead of starting over.
  Future<void> loadFromCapture(String path, PhotoSpec spec) async {
    final previous = state;
    final sameSource = previous.sourcePath == path;
    final keepCrop = sameSource ? previous.crop : null;
    final keepFace = sameSource ? previous.face : null;
    final keepRetouch = sameSource ? previous.retouch : const RetouchSettings();
    state = EditSessionState(
      busy: true,
      sourcePath: path,
      crop: keepCrop,
      face: keepFace,
      retouch: keepRetouch,
    );
    final preview = await _pipeline.loadPreview(path);
    final working = await _pipeline.loadBaked(path);
    final failure = preview.failureOrNull ?? working.failureOrNull;
    if (failure != null) {
      state = EditSessionState(errorKey: 'errorGenericTitle', sourcePath: path);
      return;
    }
    final previewImage = preview.requireValue;
    final workingImage = working.requireValue;
    final DetectedFace? faceOrNull;
    if (keepFace != null) {
      faceOrNull = keepFace;
    } else {
      final face = await ref
          .read(faceDetectionServiceProvider)
          .detectLargestFace(path);
      faceOrNull = face is Success<DetectedFace?> ? face.value : null;
    }

    final crop =
        keepCrop ??
        CropEngine.suggest(
          imageW: workingImage.width.toDouble(),
          imageH: workingImage.height.toDouble(),
          spec: spec,
          face: faceOrNull,
        );
    state = EditSessionState(
      sourcePath: path,
      preview: previewImage,
      working: workingImage,
      face: faceOrNull,
      crop: crop,
      retouch: keepRetouch,
    );
  }

  /// Rotates the working image 90° clockwise and re-fits the crop.
  Future<void> rotate() async {
    final working = state.working;
    final spec = ref.read(selectedSpecOrNullProvider);
    if (working == null || state.busy || spec == null) return;
    state = state.copyWith(busy: true, errorKey: null);
    final rotated = await _pipeline.rotate90(working);
    final failure = rotated.failureOrNull;
    if (failure != null) {
      state = state.copyWith(busy: false, errorKey: 'errorGenericTitle');
      return;
    }
    final rotatedImage = rotated.requireValue;
    final face = state.face;
    final rotatedFace = face?.rotate90cw(working.height.toDouble());
    markEdited();
    state = state.copyWith(
      working: rotatedImage,
      face: rotatedFace,
      crop: CropEngine.suggest(
        imageW: rotatedImage.width.toDouble(),
        imageH: rotatedImage.height.toDouble(),
        spec: spec,
        face: rotatedFace,
      ),
      busy: false,
    );
  }

  void setCrop(PixelRect crop) {
    final working = state.working;
    if (working == null) return;
    final spec = ref.read(selectedSpecOrNullProvider);
    markEdited();
    state = state.copyWith(
      crop: CropEngine.clamp(
        crop,
        imageW: working.width.toDouble(),
        imageH: working.height.toDouble(),
        aspect: spec?.frameAspect ?? crop.w / crop.h,
      ),
    );
  }

  void panCrop(double dx, double dy) {
    final working = state.working;
    final crop = state.crop;
    final spec = ref.read(selectedSpecOrNullProvider);
    if (working == null || crop == null) return;
    setCrop(
      CropEngine.pan(
        crop,
        dx: dx,
        dy: dy,
        imageW: working.width.toDouble(),
        imageH: working.height.toDouble(),
        aspect: spec?.frameAspect ?? crop.w / crop.h,
      ),
    );
  }

  void zoomCrop(double scale, double focalX, double focalY) {
    final working = state.working;
    final crop = state.crop;
    final spec = ref.read(selectedSpecOrNullProvider);
    if (working == null || crop == null) return;
    setCrop(
      CropEngine.zoom(
        crop,
        scale: scale,
        focalX: focalX,
        focalY: focalY,
        imageW: working.width.toDouble(),
        imageH: working.height.toDouble(),
        aspect: spec?.frameAspect ?? crop.w / crop.h,
      ),
    );
  }

  /// Re-runs the face-guided auto-crop.
  Future<void> autoFit() async {
    final working = state.working;
    final spec = ref.read(selectedSpecOrNullProvider);
    if (working == null || spec == null) return;
    setCrop(
      CropEngine.suggest(
        imageW: working.width.toDouble(),
        imageH: working.height.toDouble(),
        spec: spec,
        face: state.face,
      ),
    );
  }

  /// Marks the session edited: any previously finalised photo is now stale,
  /// so compliance/export must not silently reuse it (spec §39.4).
  void markEdited() {
    final s = state;
    if (s.finalPath == null) return;
    state = EditSessionState(
      sourcePath: s.sourcePath,
      preview: s.preview,
      working: s.working,
      crop: s.crop,
      face: s.face,
      croppedPath: s.croppedPath,
      retouch: s.retouch,
      busy: s.busy,
      errorKey: s.errorKey,
      // finalPath intentionally omitted — it no longer reflects the edits.
    );
  }

  /// Frees the full-resolution previews once the final photo exists
  /// (spec §37.4: never hold the original plus several full-res derivatives
  /// at once). The finalised files stay on disk; popping back to the editor
  /// reloads the source and preserves the crop/face/retouch draft.
  void releaseImages() {
    final s = state;
    if (s.finalPath == null) return;
    if (s.preview == null && s.working == null) return;
    state = EditSessionState(
      sourcePath: s.sourcePath,
      crop: s.crop,
      face: s.face,
      croppedPath: s.croppedPath,
      retouch: s.retouch,
      finalPath: s.finalPath,
      // preview/working intentionally omitted to release memory.
    );
  }

  /// Crops the full-resolution image and writes it to a temp file.
  /// Returns the stored path, or a failure.
  Future<Result<String>> applyCrop() async {
    final working = state.working;
    final crop = state.crop;
    if (working == null || crop == null) {
      return const FailureResult(
        ImageProcessingFailure('no image loaded'),
      );
    }
    state = state.copyWith(busy: true, errorKey: null);
    final cropped = await _pipeline.crop(working, crop);
    final failure = cropped.failureOrNull;
    if (failure != null) {
      state = state.copyWith(busy: false, errorKey: 'errorGenericTitle');
      return FailureResult(failure);
    }
    final path = await _writeTemp(cropped.requireValue.bytes, 'cropped.jpg');
    state = state.copyWith(croppedPath: path, busy: false);
    return Success(path);
  }

  /// Replaces the working image with the retouched result of [croppedPath]
  /// and stores it for compliance/export.
  Future<Result<String>> applyRetouch(RetouchSettings settings) async {
    final path = state.croppedPath;
    if (path == null) {
      return const FailureResult(ImageProcessingFailure('no cropped image'));
    }
    state = state.copyWith(busy: true, retouch: settings, errorKey: null);
    final loaded = await _pipeline.loadBaked(path);
    final failure = loaded.failureOrNull;
    if (failure != null) {
      state = state.copyWith(busy: false, errorKey: 'errorGenericTitle');
      return FailureResult(failure);
    }
    final processed = await retouchImageData(
      ref,
      source: loaded.requireValue,
      settings: settings,
    );
    final processedFailure = processed.failureOrNull;
    if (processedFailure != null) {
      state = state.copyWith(busy: false, errorKey: 'errorGenericTitle');
      return FailureResult(processedFailure);
    }
    final out = await _writeTemp(processed.requireValue.bytes, 'final.jpg');
    state = state.copyWith(finalPath: out, busy: false);
    return Success(out);
  }

  /// Applies [settings] to the editor's display-sized [source] for the live
  /// processed preview (runs in the shared pipeline isolate).
  Future<Result<ProcessedImage>> previewRetouch(
    ProcessedImage source,
    RetouchSettings settings,
  ) => retouchImageData(ref, source: source, settings: settings);

  /// Clears the session (called when leaving the flow or deleting data).
  void reset() => state = const EditSessionState();
}

/// Applies retouch settings to [source] via the shared pipeline.
///
/// Kept top-level so both the session and preview code share one path.
Future<Result<ProcessedImage>> retouchImageData(
  Ref ref, {
  required ProcessedImage source,
  required RetouchSettings settings,
}) => ref
    .read(imagePipelineProvider)
    .retouch(
      source,
      removeBackground: settings.removeBackground,
      tolerance: settings.backgroundTolerance,
      backgroundHex: settings.backgroundHex,
      brightness: settings.brightness,
      contrast: settings.contrast,
      saturation: settings.saturation,
    );

Future<String> _writeTemp(List<int> bytes, String name) async {
  final dir = await getTemporaryDirectory();
  final file = File('${dir.path}${Platform.pathSeparator}$name-${DateTime.now().microsecondsSinceEpoch}.jpg');
  await file.writeAsBytes(bytes, flush: true);
  return file.path;
}

/// Deletes every temp photo created by the session flow.
Future<void> clearTempPhotos() async {
  final dir = await getTemporaryDirectory();
  if (!await dir.exists()) return;
  await for (final entity in dir.list()) {
    if (entity is File && entity.path.contains(RegExp(r'(cropped|final|session)-\d+\.jpg'))) {
      await entity.delete();
    }
  }
}

final editSessionProvider =
    NotifierProvider<EditSessionController, EditSessionState>(
  EditSessionController.new,
);

/// Spec currently driving the flow, if any — a convenience view over
/// [selectedSpecProvider] that tolerates a null during teardown.
final selectedSpecOrNullProvider = Provider<PhotoSpec?>(
  (ref) => ref.watch(selectedSpecProvider),
);

/// Temp directory helper shared by history/export.
Future<Directory> appTempDir() => getTemporaryDirectory();
