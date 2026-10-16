import '../../country_select/domain/photo_spec.dart';
import '../../face_detection/domain/detected_face.dart';

/// Rectangle in image pixel coordinates (crop window).
class PixelRect {
  const PixelRect({required this.x, required this.y, required this.w, required this.h});

  final double x;
  final double y;
  final double w;
  final double h;

  double get right => x + w;
  double get bottom => y + h;
  double get centerX => x + w / 2;
  double get centerY => y + h / 2;

  PixelRect copyWith({double? x, double? y, double? w, double? h}) => PixelRect(
    x: x ?? this.x,
    y: y ?? this.y,
    w: w ?? this.w,
    h: h ?? this.h,
  );
}

/// Pure crop-window math for the manual editor.
///
/// All coordinates are pixels of the (rotated) full-resolution image. The
/// crop window keeps the spec's aspect ratio at all times; [clamp] keeps it
/// inside the image and within sensible size bounds.
class CropEngine {
  const CropEngine._();

  /// Smallest crop window (pixels) the editor allows before export downsize.
  static const double minWindowPx = 200;

  /// Aspect-enforcing maximum window width for an image of this size.
  static double _maxW(double imageW, double imageH, double aspect) {
    final byWidth = imageW;
    final byHeight = imageH * aspect;
    return byWidth < byHeight ? byWidth : byHeight;
  }

  /// Suggests a crop for [face] meeting [spec]'s head-height and eye-line
  /// targets. Falls back to a centered window when there is no face.
  static PixelRect suggest({
    required double imageW,
    required double imageH,
    required PhotoSpec spec,
    DetectedFace? face,
  }) {
    final aspect = spec.frameAspect;

    if (face == null) {
      final w = _maxW(imageW, imageH, aspect);
      return clamp(
        PixelRect(x: (imageW - w) / 2, y: (imageH - w / aspect) / 2, w: w, h: w / aspect),
        imageW: imageW,
        imageH: imageH,
        aspect: aspect,
      );
    }

    // Head height in the crop should be targetHeadFraction of crop height.
    final cropH = face.headHeight / spec.targetHeadFraction;
    final cropW = cropH * aspect;

    // Eye line sits targetEyeFromBottom up from the crop's bottom edge.
    final eyeFromTop = (1 - spec.targetEyeFromBottom) * cropH;
    final y = face.eyeY - eyeFromTop;
    final x = face.box.center.dx - cropW / 2;

    return clamp(
      PixelRect(x: x, y: y, w: cropW, h: cropH),
      imageW: imageW,
      imageH: imageH,
      aspect: aspect,
    );
  }

  /// Enforces aspect ratio, image bounds and minimum size.
  static PixelRect clamp(
    PixelRect rect, {
    required double imageW,
    required double imageH,
    required double aspect,
  }) {
    var w = rect.w;
    var h = w / aspect;

    final maxW = _maxW(imageW, imageH, aspect);
    if (w > maxW) {
      w = maxW;
      h = w / aspect;
    }
    const minW = minWindowPx;
    if (w < minW && maxW >= minW) {
      w = minW;
      h = w / aspect;
    }

    final x = rect.x.clamp(0.0, imageW - w);
    final y = rect.y.clamp(0.0, imageH - h);
    return PixelRect(x: x, y: y, w: w, h: h);
  }

  /// Pans the window by image-space [dx]/[dy], keeping it inside the image.
  static PixelRect pan(
    PixelRect rect, {
    required double dx,
    required double dy,
    required double imageW,
    required double imageH,
    required double aspect,
  }) => clamp(
    rect.copyWith(x: rect.x + dx, y: rect.y + dy),
    imageW: imageW,
    imageH: imageH,
    aspect: aspect,
  );

  /// Zooms the window about image-space focal point (focalX, focalY).
  /// [scale] > 1 shrinks the window (zoom in); < 1 grows it (zoom out).
  static PixelRect zoom(
    PixelRect rect, {
    required double scale,
    required double focalX,
    required double focalY,
    required double imageW,
    required double imageH,
    required double aspect,
  }) {
    if (scale == 1) return rect;
    final newW = rect.w / scale;
    final newH = newW / aspect;
    final x = focalX - (focalX - rect.x) * (newW / rect.w);
    final y = focalY - (focalY - rect.y) * (newH / rect.h);
    return clamp(
      PixelRect(x: x, y: y, w: newW, h: newH),
      imageW: imageW,
      imageH: imageH,
      aspect: aspect,
    );
  }
}
