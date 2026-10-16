import 'package:camera/camera.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Camera hardware access, abstracted so the capture UI is widget-testable.
abstract interface class CameraService {
  Future<List<CameraDescription>> availableCameras();

  CameraController createController(CameraDescription description);
}

/// Device implementation backed by the `camera` plugin.
class DeviceCameraService implements CameraService {
  const DeviceCameraService();

  @override
  Future<List<CameraDescription>> availableCameras() => availableCameras();

  @override
  CameraController createController(CameraDescription description) =>
      CameraController(
        description,
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );
}

final cameraServiceProvider = Provider<CameraService>(
  (ref) => const DeviceCameraService(),
);

/// Where the most recent captured or imported photo lives (a file path).
///
/// Set by capture/gallery, consumed by the editor (Phase 4). Kept on-device;
/// the original file is never modified.
class CapturedPhotoController extends Notifier<String?> {
  @override
  String? build() => null;

  void setPath(String path) => state = path;

  void clear() => state = null;
}

final capturedPhotoProvider =
    NotifierProvider<CapturedPhotoController, String?>(
  CapturedPhotoController.new,
);
