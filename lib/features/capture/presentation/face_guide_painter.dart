import 'package:flutter/material.dart';

import '../domain/face_guide.dart';

/// Draws the spec-driven capture guide: dimmed area outside the head oval,
/// oval, head box and dashed eye line — all derived from the chosen spec.
class FaceGuidePainter extends CustomPainter {
  FaceGuidePainter({
    required this.guide,
    required this.frameAspect,
    required this.color,
  });

  /// Guide geometry in normalized photo-frame coordinates.
  final FaceGuide guide;

  /// Photo frame width/height (e.g. 35/45 for UK passport).
  final double frameAspect;

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final frame = _fitFrame(size, frameAspect);

    // Dim everything outside the head oval.
    final oval = _toRect(frame, guide.oval);
    final scrim = Path()
      ..fillType = PathFillType.evenOdd
      ..addRect(Offset.zero & size)
      ..addOval(oval);
    canvas.drawPath(scrim, Paint()..color = Colors.black.withValues(alpha: .45));

    // Head oval.
    canvas.drawOval(
      oval,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..color = color.withValues(alpha: .9),
    );

    // Head bounding box (dashed).
    final box = _toRect(frame, guide.headBox);
    _drawDashed(
      canvas,
      box,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5
        ..color = color.withValues(alpha: .6),
    );

    // Eye line (dashed), spanning the frame width.
    final eyeY = frame.top + guide.eyeLineY * frame.height;
    _drawDashed(
      canvas,
      Rect.fromLTWH(frame.left, eyeY, frame.width, 0),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = color.withValues(alpha: .75),
    );
  }

  /// Largest rect of [aspect] (w/h) centered in [size].
  static Rect _fitFrame(Size size, double aspect) {
    if (size.width / size.height > aspect) {
      final width = size.height * aspect;
      return Rect.fromLTWH((size.width - width) / 2, 0, width, size.height);
    }
    final height = size.width / aspect;
    return Rect.fromLTWH(0, (size.height - height) / 2, size.width, height);
  }

  static Rect _toRect(Rect frame, RectLike r) => Rect.fromLTWH(
    frame.left + r.left * frame.width,
    frame.top + r.top * frame.height,
    r.width * frame.width,
    r.height * frame.height,
  );

  static void _drawDashed(Canvas canvas, Rect rect, Paint paint) {
    const dashWidth = 8.0;
    const dashSpace = 6.0;

    if (rect.height == 0) {
      // Horizontal line.
      var x = rect.left;
      while (x < rect.right) {
        final end = (x + dashWidth).clamp(x, rect.right);
        canvas.drawLine(Offset(x, rect.top), Offset(end, rect.top), paint);
        x = end + dashSpace;
      }
      return;
    }

    // Rectangle perimeter.
    final path = Path()..addRect(rect);
    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        canvas.drawPath(
          metric.extractPath(distance, distance + dashWidth),
          paint,
        );
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(FaceGuidePainter oldDelegate) =>
      oldDelegate.guide != guide ||
      oldDelegate.frameAspect != frameAspect ||
      oldDelegate.color != color;
}
