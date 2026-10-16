import 'dart:ui' show Rect;

/// A face located in an image, in image pixel coordinates.
class DetectedFace {
  const DetectedFace({required this.box, this.leftEyeY, this.rightEyeY});

  /// Face bounding box as reported by the detector (pixels, image space).
  ///
  /// The box covers roughly hairline to chin.
  final Rect box;

  /// Eye centre Y positions (pixels), when landmarks are available.
  final double? leftEyeY;
  final double? rightEyeY;

  /// Estimated eye-line Y (pixels). Uses landmarks when available, else a
  /// documented anatomical fallback (eyes ~42% down the face box).
  double get eyeY {
    final left = leftEyeY;
    final right = rightEyeY;
    if (left != null && right != null) return (left + right) / 2;
    if (left != null || right != null) return left ?? right!;
    return box.top + 0.42 * box.height;
  }

  /// Estimated head height in pixels (crown to chin). Detector boxes usually
  /// cut off some hair; 1.15 is the documented template constant.
  double get headHeight => box.height * 1.15;

  /// Estimated chin Y (pixels).
  double get chinY => box.bottom;

  /// Returns this face mapped through a 90° clockwise rotation of the image
  /// (original image height [imageH] becomes the new width).
  DetectedFace rotate90cw(double imageH) => DetectedFace(
    box: Rect.fromLTWH(imageH - box.bottom, box.left, box.height, box.width),
    leftEyeY: leftEyeY == null ? null : box.center.dx,
    rightEyeY: rightEyeY == null ? null : box.center.dx,
  );
}
