import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import '../../../core/errors/failure.dart';
import '../../../core/errors/result.dart';
import '../../face_detection/domain/detected_face.dart';

/// Locates the most prominent face in a photo. Abstracted so the editor is
/// widget-testable without ML Kit.
abstract interface class FaceDetectionService {
  /// Returns the largest face, or `null` when the photo contains none.
  Future<Result<DetectedFace?>> detectLargestFace(String imagePath);
}

/// On-device implementation backed by ML Kit. Nothing leaves the phone.
class MlKitFaceDetectionService implements FaceDetectionService {
  const MlKitFaceDetectionService();

  @override
  Future<Result<DetectedFace?>> detectLargestFace(String imagePath) async {
    final detector = FaceDetector(
      options: FaceDetectorOptions(
        enableLandmarks: true,
        enableClassification: false,
        performanceMode: FaceDetectorMode.accurate,
      ),
    );
    try {
      final input = InputImage.fromFilePath(imagePath);
      final faces = await detector.processImage(input);
      if (faces.isEmpty) return const Success(null);

      faces.sort((a, b) {
        final areaA = a.boundingBox.width * a.boundingBox.height;
        final areaB = b.boundingBox.width * b.boundingBox.height;
        return areaB.compareTo(areaA);
      });
      final best = faces.first;

      double? landmarkY(FaceLandmarkType type) =>
          best.landmarks[type]?.position.y.toDouble();

      return Success(
        DetectedFace(
          box: best.boundingBox,
          leftEyeY: landmarkY(FaceLandmarkType.leftEye),
          rightEyeY: landmarkY(FaceLandmarkType.rightEye),
        ),
      );
    } on Exception catch (error) {
      return FailureResult(FaceDetectionFailure('face detection failed', cause: error));
    } finally {
      await detector.close();
    }
  }
}

final faceDetectionServiceProvider = Provider<FaceDetectionService>(
  (ref) => const MlKitFaceDetectionService(),
);
