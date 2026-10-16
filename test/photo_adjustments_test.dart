import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:photo_pass/features/editor/domain/photo_adjustments.dart';

/// Builds an RGBA buffer: white background with a dark block in the middle.
Uint8List _imageWithBlock({int width = 40, int height = 40}) {
  final rgba = Uint8List(width * height * 4);
  for (var y = 0; y < height; y++) {
    for (var x = 0; x < width; x++) {
      final o = (y * width + x) * 4;
      final inside = x >= 12 && x < 28 && y >= 12 && y < 28;
      final v = inside ? 40 : 250;
      rgba[o] = v;
      rgba[o + 1] = v;
      rgba[o + 2] = v;
      rgba[o + 3] = 255;
    }
  }
  return rgba;
}

int _pixel(Uint8List rgba, int x, int y, int width) {
  final o = (y * width + x) * 4;
  return (rgba[o] << 16) | (rgba[o + 1] << 8) | rgba[o + 2];
}

void main() {
  group('BackgroundRemover.replaceBackground', () {
    test('replaces the plain border colour but keeps the block', () {
      const width = 40;
      const height = 40;
      final rgba = _imageWithBlock(width: width, height: height);
      BackgroundRemover.replaceBackground(
        rgba: rgba,
        width: width,
        height: height,
        tolerance: 30,
        replacement: 0x00FF00,
      );
      // Border pixel becomes green.
      expect(_pixel(rgba, 0, 0, width), 0x00FF00);
      expect(_pixel(rgba, width - 1, height - 1, width), 0x00FF00);
      // Interior block untouched (not reachable within tolerance).
      expect(_pixel(rgba, 20, 20, width), 0x282828);
    });

    test('tolerance 0 changes nothing', () {
      const width = 20;
      const height = 20;
      final rgba = _imageWithBlock(width: width, height: height);
      final before = Uint8List.fromList(rgba);
      BackgroundRemover.replaceBackground(
        rgba: rgba,
        width: width,
        height: height,
        tolerance: 0,
        replacement: 0x0000FF,
      );
      expect(rgba, before);
    });
  });

  group('BackgroundRemover.adjust', () {
    test('positive brightness lightens pixels across the full range', () {
      final rgba = Uint8List.fromList([100, 100, 100, 255]);
      BackgroundRemover.adjust(rgba: rgba, brightness: 50, contrast: 0, saturation: 0);
      // 50/100 maps to 127.5 of the 255 range.
      expect(rgba[0], 228);
      expect(rgba[3], 255);
    });

    test('zero adjustments leave pixels untouched', () {
      final rgba = Uint8List.fromList([10, 20, 30, 255]);
      final before = Uint8List.fromList(rgba);
      BackgroundRemover.adjust(rgba: rgba, brightness: 0, contrast: 0, saturation: 0);
      expect(rgba, before);
    });

    test('clamps to 0..255', () {
      final rgba = Uint8List.fromList([250, 5, 128, 255]);
      BackgroundRemover.adjust(rgba: rgba, brightness: 100, contrast: 0, saturation: 0);
      expect(rgba[0], 255);
      expect(rgba[1], 255);
      expect(rgba[2], 255);
    });

    test('saturation -100 greys the pixel', () {
      final rgba = Uint8List.fromList([200, 100, 50, 255]);
      BackgroundRemover.adjust(rgba: rgba, brightness: 0, contrast: 0, saturation: -100);
      expect(rgba[0], rgba[1]);
      expect(rgba[1], rgba[2]);
    });
  });

  group('parseHexColor', () {
    test('parses #RRGGBB', () {
      expect(parseHexColor('#FFFFFF'), 0xFFFFFF);
      expect(parseHexColor('1A2B3C'), 0x1A2B3C);
    });

    test('falls back to white on garbage', () {
      expect(parseHexColor('nope'), 0xFFFFFF);
      expect(parseHexColor(''), 0xFFFFFF);
    });
  });
}
