// Generates the PhotoPass app icon and adaptive-icon layers.
//
// Usage: dart run tool/generate_icon.dart
//
// Design: deep passport blue field, white photo frame with a simple person
// silhouette — evokes an ID photo. Outputs:
//   assets/icon/icon_1024.png            (full square icon)
//   assets/icon/adaptive_background.png  (solid brand blue)
//   assets/icon/adaptive_foreground.png  (frame + person, transparent)
import 'dart:io';

import 'package:image/image.dart' as img;

const int size = 1024;

/// Brand colours.
const int blueDark = 0xFF0D2B55;
const int blueLight = 0xFF1E4A8C;
const int frameWhite = 0xFFF7F9FC;
const int personBlue = 0xFF2C5FA8;

void main() {
  final outDir = Directory('assets/icon');
  if (!outDir.existsSync()) outDir.createSync(recursive: true);

  _writeIcon('${outDir.path}/icon_1024.png', _fullIcon());
  _writeIcon('${outDir.path}/adaptive_background.png', _background());
  _writeIcon('${outDir.path}/adaptive_foreground.png', _foreground());

  stdout.writeln('Icons written to ${outDir.path}');
}

void _writeIcon(String path, img.Image image) {
  File(path).writeAsBytesSync(img.encodePng(image));
  stdout.writeln('  $path (${image.width}×${image.height})');
}

/// Vertical blue gradient background.
img.Image _background() {
  final image = img.Image(width: size, height: size);
  for (var y = 0; y < size; y++) {
    final t = y / size;
    final color = _lerpColor(blueDark, blueLight, t);
    for (var x = 0; x < size; x++) {
      image.setPixelRgb(x, y, color.r, color.g, color.b);
    }
  }
  return image;
}

/// White photo frame (35×45-style portrait) with a person silhouette.
img.Image _foreground() {
  // Frame: portrait rectangle centred, with generous icon-safe margins.
  final frameW = (size * 0.46).round();
  final frameH = (size * 0.58).round();
  final frameX = (size - frameW) ~/ 2;
  final frameY = (size - frameH) ~/ 2 - (size * 0.02).round();
  final radius = (size * 0.055).round();

  final out = img.Image(width: size, height: size); // transparent
  _fillRoundedRect(
    out,
    x: frameX,
    y: frameY,
    w: frameW,
    h: frameH,
    radius: radius,
    color: img.ColorRgba8(
      (frameWhite >> 16) & 0xFF,
      (frameWhite >> 8) & 0xFF,
      frameWhite & 0xFF,
      255,
    ),
  );

  // Person silhouette inside the frame: head + shoulders.
  final headR = (frameW * 0.24).round();
  final headCx = frameX + frameW ~/ 2;
  final headCy = frameY + (frameH * 0.40).round();
  _fillCircle(out, headCx, headCy, headR, personBlue);

  final shoulderW = (frameW * 0.68).round();
  final shoulderH = (frameH * 0.34).round();
  final shoulderX = headCx - shoulderW ~/ 2;
  final shoulderY = headCy + headR + (frameH * 0.05).round();
  _fillRoundedRect(
    out,
    x: shoulderX,
    y: shoulderY,
    w: shoulderW,
    h: shoulderH,
    radius: (shoulderW * 0.45).round(),
    color: img.ColorRgba8(44, 95, 168, 255),
  );

  return out;
}

/// Full square icon: gradient background + frame + person.
img.Image _fullIcon() {
  final bg = _background();
  final fg = _foreground();
  final out = img.Image(width: size, height: size);
  img.compositeImage(out, bg);
  img.compositeImage(out, fg);
  return out;
}

void _fillRoundedRect(
  img.Image image, {
  required int x,
  required int y,
  required int w,
  required int h,
  required int radius,
  required img.Color color,
}) {
  for (var py = y; py < y + h; py++) {
    for (var px = x; px < x + w; px++) {
      if (_insideRoundedCorner(px, py, x, y, w, h, radius)) continue;
      image.setPixel(px, py, color);
    }
  }
}

bool _insideRoundedCorner(
  int px,
  int py,
  int x,
  int y,
  int w,
  int h,
  int radius,
) {
  final lx = px - x;
  final ly = py - y;
  final corners = [
    (radius, radius),
    (w - 1 - radius, radius),
    (radius, h - 1 - radius),
    (w - 1 - radius, h - 1 - radius),
  ];
  for (final (cx, cy) in corners) {
    final inX = lx < cx ? lx < cx : lx > cx;
    final inY = ly < cy ? ly < cy : ly > cy;
    if (!inX || !inY) continue;
    final dx = lx - cx;
    final dy = ly - cy;
    if (dx * dx + dy * dy > radius * radius) return true;
  }
  return false;
}

void _fillCircle(img.Image image, int cx, int cy, int radius, int color) {
  final r2 = radius * radius;
  for (var y = cy - radius; y <= cy + radius; y++) {
    for (var x = cx - radius; x <= cx + radius; x++) {
      final dx = x - cx;
      final dy = y - cy;
      if (dx * dx + dy * dy <= r2) {
        image.setPixelRgb(
          x,
          y,
          (color >> 16) & 0xFF,
          (color >> 8) & 0xFF,
          color & 0xFF,
        );
      }
    }
  }
}

({int r, int g, int b}) _lerpColor(int a, int b, double t) {
  final tt = t.clamp(0, 1);
  int l(int shift) {
    final av = (a >> shift) & 0xFF;
    final bv = (b >> shift) & 0xFF;
    return (av + (bv - av) * tt).round();
  }
  return (r: l(16), g: l(8), b: l(0));
}
