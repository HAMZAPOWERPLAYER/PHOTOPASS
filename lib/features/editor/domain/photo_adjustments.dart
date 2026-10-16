import 'dart:math' as math;
import 'dart:typed_data';

/// Pure on-device photo retouching.
///
/// Background removal: the background of a passport photo is expected to be
/// a plain light surface, so pixels reachable from the image border whose
/// colour is within [tolerance] of the border's median colour are flood
/// filled and replaced with the target colour. Faces are far from the
/// border and far in colour from a plain wall, so they survive — and the
/// whole pass is deterministic, isolate-safe and needs no ML model.
class BackgroundRemover {
  const BackgroundRemover._();

  /// Replaces the plain background of an RGBA8 image with [replacement].
  ///
  /// [tolerance] is the max per-channel colour distance (0–255) from the
  /// estimated border colour. Returns the modified pixel buffer in place.
  static void replaceBackground({
    required Uint8List rgba,
    required int width,
    required int height,
    required double tolerance,
    required int replacement,
  }) {
    if (width <= 0 || height <= 0) return;
    final border = _medianBorderColor(rgba, width, height);
    final tol = tolerance.clamp(0, 255);
    if (tol <= 0) return;

    final visited = Uint8List(width * height);
    final queue = <int>[];

    void enqueue(int index) {
      if (visited[index] == 1) return;
      final o = index * 4;
      final distance = math.max(
        (rgba[o] - border.r).abs(),
        math.max((rgba[o + 1] - border.g).abs(), (rgba[o + 2] - border.b).abs()),
      );
      if (distance <= tol) {
        visited[index] = 1;
        queue.add(index);
      }
    }

    // Seed from every border pixel.
    for (var x = 0; x < width; x++) {
      enqueue(x);
      enqueue((height - 1) * width + x);
    }
    for (var y = 0; y < height; y++) {
      enqueue(y * width);
      enqueue(y * width + width - 1);
    }

    // Scanline-free BFS flood fill (4-connected).
    while (queue.isNotEmpty) {
      final index = queue.removeLast();
      final o = index * 4;
      rgba[o] = replacement >> 16 & 0xFF;
      rgba[o + 1] = replacement >> 8 & 0xFF;
      rgba[o + 2] = replacement & 0xFF;
      rgba[o + 3] = 0xFF;
      final x = index % width;
      final y = index ~/ width;
      if (x > 0) enqueue(index - 1);
      if (x < width - 1) enqueue(index + 1);
      if (y > 0) enqueue(index - width);
      if (y < height - 1) enqueue(index + width);
    }
  }

  /// Applies brightness/contrast/saturation (each −100..100) in place.
  static void adjust({
    required Uint8List rgba,
    required double brightness,
    required double contrast,
    required double saturation,
  }) {
    final b = brightness.clamp(-100, 100) * 2.55;
    final c = contrast.clamp(-100, 100);
    final s = saturation.clamp(-100, 100);
    final applyB = b != 0;
    final applyC = c != 0;
    final applyS = s != 0;
    if (!applyB && !applyC && !applyS) return;

    // Contrast factor: classic piecewise-linear around mid-grey.
    final f = (259 * (c + 255)) / (255 * (259 - c));
    final satFactor = 1 + s / 100;

    for (var o = 0; o + 3 < rgba.length; o += 4) {
      var r = rgba[o].toDouble();
      var g = rgba[o + 1].toDouble();
      var bl = rgba[o + 2].toDouble();

      if (applyS) {
        final luma = 0.2126 * r + 0.7152 * g + 0.0722 * bl;
        r = luma + (r - luma) * satFactor;
        g = luma + (g - luma) * satFactor;
        bl = luma + (bl - luma) * satFactor;
      }
      if (applyC) {
        r = f * (r - 128) + 128;
        g = f * (g - 128) + 128;
        bl = f * (bl - 128) + 128;
      }
      if (applyB) {
        r += b;
        g += b;
        bl += b;
      }

      rgba[o] = r.round().clamp(0, 255);
      rgba[o + 1] = g.round().clamp(0, 255);
      rgba[o + 2] = bl.round().clamp(0, 255);
    }
  }

  static _Rgb _medianBorderColor(Uint8List rgba, int width, int height) {
    final rs = <int>[];
    final gs = <int>[];
    final bs = <int>[];
    void sample(int index) {
      final o = index * 4;
      rs.add(rgba[o]);
      gs.add(rgba[o + 1]);
      bs.add(rgba[o + 2]);
    }

    // Sample every pixel on the 4 edges (capped for large images).
    final stepX = math.max(1, width ~/ 512);
    final stepY = math.max(1, height ~/ 512);
    for (var x = 0; x < width; x += stepX) {
      sample(x);
      sample((height - 1) * width + x);
    }
    for (var y = 0; y < height; y += stepY) {
      sample(y * width);
      sample(y * width + width - 1);
    }
    rs.sort();
    gs.sort();
    bs.sort();
    final mid = rs.length ~/ 2;
    return _Rgb(rs[mid], gs[mid], bs[mid]);
  }
}

class _Rgb {
  const _Rgb(this.r, this.g, this.b);

  final int r;
  final int g;
  final int b;
}

/// Parses `#RRGGBB` (or `RRGGBB`) into a 0xRRGGBB int; white on garbage.
int parseHexColor(String hex) {
  var value = hex.trim();
  if (value.startsWith('#')) value = value.substring(1);
  if (value.length != 6) return 0xFFFFFF;
  final parsed = int.tryParse(value, radix: 16);
  return parsed == null ? 0xFFFFFF : parsed & 0xFFFFFF;
}
