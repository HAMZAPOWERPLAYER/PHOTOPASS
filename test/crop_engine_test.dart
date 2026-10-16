import 'dart:ui' show Rect;

import 'package:flutter_test/flutter_test.dart';
import 'package:photo_pass/features/country_select/domain/photo_spec.dart';
import 'package:photo_pass/features/editor/domain/crop_engine.dart';
import 'package:photo_pass/features/face_detection/domain/detected_face.dart';

PhotoSpec _spec({
  double widthMm = 35,
  double heightMm = 45,
  double? headMin,
  double? headMax,
  double? eyeMin,
  double? eyeMax,
}) => PhotoSpec(
  id: 'test_spec',
  countryCode: 'US',
  documentType: DocumentType.passport,
  displayNameKey: 'spec_us_passport',
  widthMm: widthMm,
  heightMm: heightMm,
  dpi: 300,
  backgroundHex: '#FFFFFF',
  fileFormats: const ['jpg'],
  glassesAllowed: false,
  sourceUrl: 'https://example.gov',
  lastVerified: '2026-10-15',
  verified: true,
  headHeightMinPct: headMin,
  headHeightMaxPct: headMax,
  eyeLineMinPct: eyeMin,
  eyeLineMaxPct: eyeMax,
);

DetectedFace _face({double top = 600, double height = 800, double centerX = 1500}) =>
    DetectedFace(
      box: Rect.fromLTWH(centerX - height * .35, top, height * .7, height),
      leftEyeY: top + height * .42,
      rightEyeY: top + height * .42,
    );

void main() {
  group('CropEngine.suggest', () {
    test('honours the spec head-height fraction', () {
      final spec = _spec(headMin: 50, headMax: 70); // target 60%
      final face = _face();
      final crop = CropEngine.suggest(
        imageW: 3000,
        imageH: 4000,
        spec: spec,
        face: face,
      );
      final headPct = face.headHeight / crop.h * 100;
      expect(headPct, closeTo(60, 0.001));
    });

    test('places the eye line at the target height from the bottom', () {
      final spec = _spec(eyeMin: 40, eyeMax: 60); // target 50% from bottom
      final face = _face();
      final crop = CropEngine.suggest(
        imageW: 3000,
        imageH: 4000,
        spec: spec,
        face: face,
      );
      final eyeFromBottom = (crop.y + crop.h - face.eyeY) / crop.h * 100;
      expect(eyeFromBottom, closeTo(50, 0.001));
    });

    test('keeps the spec aspect ratio', () {
      final spec = _spec(); // 35/45
      final crop = CropEngine.suggest(
        imageW: 3000,
        imageH: 4000,
        spec: spec,
        face: _face(),
      );
      expect(crop.w / crop.h, closeTo(35 / 45, 0.0001));
    });

    test('centres the crop on the face horizontally', () {
      final spec = _spec();
      final face = _face(centerX: 2000);
      final crop = CropEngine.suggest(
        imageW: 3000,
        imageH: 4000,
        spec: spec,
        face: face,
      );
      expect(crop.centerX, closeTo(face.box.center.dx, 0.5));
    });

    test('stays inside the image when the face is near an edge', () {
      final spec = _spec();
      final face = _face(top: -200, centerX: 100);
      final crop = CropEngine.suggest(
        imageW: 3000,
        imageH: 4000,
        spec: spec,
        face: face,
      );
      expect(crop.x, greaterThanOrEqualTo(0));
      expect(crop.y, greaterThanOrEqualTo(0));
      expect(crop.right, lessThanOrEqualTo(3000));
      expect(crop.bottom, lessThanOrEqualTo(4000));
    });

    test('falls back to a centred crop without a face', () {
      final spec = _spec();
      final crop = CropEngine.suggest(imageW: 3000, imageH: 4000, spec: spec);
      expect(crop.w / crop.h, closeTo(35 / 45, 0.0001));
      expect(crop.x, greaterThanOrEqualTo(0));
      expect(crop.y, greaterThanOrEqualTo(0));
    });
  });

  group('CropEngine.pan/zoom', () {
    test('pan cannot move the window outside the image', () {
      final spec = _spec();
      final crop = CropEngine.suggest(imageW: 3000, imageH: 4000, spec: spec);
      final moved = CropEngine.pan(
        crop,
        dx: -99999,
        dy: -99999,
        imageW: 3000,
        imageH: 4000,
        aspect: spec.frameAspect,
      );
      expect(moved.x, 0);
      expect(moved.y, 0);
      expect(moved.w / moved.h, closeTo(spec.frameAspect, 0.0001));
    });

    test('zoom keeps aspect ratio and bounds', () {
      final spec = _spec();
      final crop = CropEngine.suggest(imageW: 3000, imageH: 4000, spec: spec);
      final zoomed = CropEngine.zoom(
        crop,
        scale: 2,
        focalX: crop.centerX,
        focalY: crop.centerY,
        imageW: 3000,
        imageH: 4000,
        aspect: spec.frameAspect,
      );
      expect(zoomed.w, lessThan(crop.w));
      expect(zoomed.w / zoomed.h, closeTo(spec.frameAspect, 0.0001));
      expect(zoomed.x, greaterThanOrEqualTo(0));
      expect(zoomed.right, lessThanOrEqualTo(3000));
    });

    test('zoom-out cannot exceed the image', () {
      final spec = _spec();
      final crop = CropEngine.suggest(imageW: 3000, imageH: 4000, spec: spec);
      final zoomed = CropEngine.zoom(
        crop,
        scale: 0.01,
        focalX: crop.centerX,
        focalY: crop.centerY,
        imageW: 3000,
        imageH: 4000,
        aspect: spec.frameAspect,
      );
      expect(zoomed.w, lessThanOrEqualTo(3000));
      expect(zoomed.x, greaterThanOrEqualTo(0));
    });
  });

  group('DetectedFace.rotate90cw', () {
    test('maps the box through a 90° clockwise rotation', () {
      const face = DetectedFace(
        box: Rect.fromLTWH(100, 200, 300, 400),
        leftEyeY: 368,
      );
      final rotated = face.rotate90cw(1000);
      // x' = H - bottom = 1000 - 600 = 400; y' = left = 100
      expect(rotated.box.left, 400);
      expect(rotated.box.top, 100);
      expect(rotated.box.width, 400);
      expect(rotated.box.height, 300);
    });
  });
}
