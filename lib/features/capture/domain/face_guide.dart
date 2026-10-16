import '../../../features/country_select/domain/photo_spec.dart';

/// Normalized face-guide geometry for the capture overlay.
///
/// All coordinates are fractions of the photo frame (0..1), with y measured
/// from the **top** for painting. Derived purely from a [PhotoSpec] — no
/// platform code, fully unit-testable.
class FaceGuide {
  const FaceGuide({
    required this.headBox,
    required this.oval,
    required this.eyeLineY,
  });

  /// Distance from chin to eye line as a fraction of head height
  /// (anatomical constant used by photo-composition templates).
  static const double _eyesAtHeadFraction = 0.45;

  /// Head bounding box (chin to crown), centered horizontally.
  final RectLike headBox;

  /// Head-shaped oval guide, slightly larger than [headBox].
  final RectLike oval;

  /// Eye-line height as a fraction of frame height from the top.
  final double eyeLineY;

  /// Builds guide geometry for [spec].
  ///
  /// Uses the spec's head-height and eye-line targets (midpoints of the
  /// official ranges). When the spec is silent, documented UI fallbacks from
  /// [PhotoSpec] keep the guide useful (e.g. Schengen visas).
  factory FaceGuide.fromSpec(PhotoSpec spec) {
    final aspect = spec.heightMm / spec.widthMm; // frame is portrait

    final headFraction = spec.targetHeadFraction;
    final eyeFromBottom = spec.targetEyeFromBottom;

    final chinFromBottom = eyeFromBottom - _eyesAtHeadFraction * headFraction;
    final crownFromBottom = chinFromBottom + headFraction;

    // Head box: square-ish; width derived from height via frame aspect.
    final boxHeight = headFraction;
    final boxWidth = headFraction * aspect * 0.7;
    final boxLeft = (1 - boxWidth) / 2;
    final boxTop = 1 - crownFromBottom;

    // Oval: slightly padded around the head box, taller than wide.
    final ovalPadX = boxWidth * 0.15;
    final ovalPadY = boxHeight * 0.08;

    return FaceGuide(
      headBox: RectLike(
        left: boxLeft,
        top: boxTop,
        width: boxWidth,
        height: boxHeight,
      ),
      oval: RectLike(
        left: boxLeft - ovalPadX,
        top: boxTop - ovalPadY,
        width: boxWidth + 2 * ovalPadX,
        height: boxHeight + 2 * ovalPadY,
      ),
      eyeLineY: 1 - eyeFromBottom,
    );
  }
}

/// Minimal rectangle in normalized coordinates — avoids importing Flutter
/// types into the domain layer.
class RectLike {
  const RectLike({
    required this.left,
    required this.top,
    required this.width,
    required this.height,
  });

  final double left;
  final double top;
  final double width;
  final double height;
}
