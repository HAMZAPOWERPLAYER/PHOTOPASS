import 'dart:typed_data';
import 'dart:ui' show Rect;

import 'package:flutter_test/flutter_test.dart';
import 'package:photo_pass/features/compliance/domain/compliance_engine.dart';
import 'package:photo_pass/features/country_select/domain/photo_spec.dart';
import 'package:photo_pass/features/face_detection/domain/detected_face.dart';

PhotoSpec _spec({
  double? headMin,
  double? headMax,
  double? eyeMin,
  double? eyeMax,
  int maxKb = 0,
}) => PhotoSpec(
  id: 'spec',
  countryCode: 'US',
  documentType: DocumentType.passport,
  displayNameKey: 'spec_us_passport',
  widthMm: 2,
  heightMm: 2.5,
  dpi: 118, // 2mm @118dpi ≈ 9×11 px (rounded)
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
  maxFileSizeKb: maxKb == 0 ? null : maxKb,
);

/// White border RGBA image of the given size.
Uint8List _whiteBorder(int width, int height) {
  final rgba = Uint8List(width * height * 4);
  for (var i = 0; i < width * height; i++) {
    rgba[i * 4] = 252;
    rgba[i * 4 + 1] = 252;
    rgba[i * 4 + 2] = 252;
    rgba[i * 4 + 3] = 255;
  }
  return rgba;
}

ComplianceCheck _check(ComplianceReport report, String id) =>
    report.checks.firstWhere((check) => check.id == id);

void main() {
  final spec = _spec(); // widthPx/heightPx computed from mm & dpi

  group('dimensions check', () {
    test('passes on exact spec pixels', () {
      final report = ComplianceEngine.evaluate(
        spec: spec,
        width: spec.widthPx,
        height: spec.heightPx,
        face: null,
      );
      expect(_check(report, 'dimensions').status, CheckStatus.pass);
    });

    test('fails on wrong pixels', () {
      final report = ComplianceEngine.evaluate(
        spec: spec,
        width: spec.widthPx + 1,
        height: spec.heightPx,
        face: null,
      );
      expect(_check(report, 'dimensions').status, CheckStatus.fail);
    });
  });

  group('face and head checks', () {
    test('fails when no face is present', () {
      final report = ComplianceEngine.evaluate(
        spec: spec,
        width: spec.widthPx,
        height: spec.heightPx,
        face: null,
      );
      expect(_check(report, 'face').status, CheckStatus.fail);
      expect(report.hasFailure, isTrue);
    });

    test('reports head height in range as pass', () {
      // Build a face whose head height equals 60% of image height.
      final h = spec.heightPx.toDouble();
      final head = h * 0.6;
      final face = DetectedFace(
        box: Rect.fromLTWH(0, 0, 10, head / 1.15),
        leftEyeY: head * .42,
      );
      final ranged = _spec(headMin: 50, headMax: 70);
      final report = ComplianceEngine.evaluate(
        spec: ranged,
        width: spec.widthPx,
        height: spec.heightPx,
        face: face,
      );
      expect(_check(report, 'headHeight').status, CheckStatus.pass);
    });

    test('reports info when the spec publishes no head range', () {
      final h = spec.heightPx.toDouble();
      final face = DetectedFace(
        box: Rect.fromLTWH(0, 0, 10, h * .5 / 1.15),
      );
      final report = ComplianceEngine.evaluate(
        spec: spec,
        width: spec.widthPx,
        height: spec.heightPx,
        face: face,
      );
      expect(_check(report, 'headHeight').status, CheckStatus.info);
      expect(_check(report, 'eyeLine').status, CheckStatus.info);
    });
  });

  group('background check', () {
    test('uniform white border passes for a white spec', () {
      final white = _spec(headMin: 50, headMax: 70);
      final report = ComplianceEngine.evaluate(
        spec: white,
        width: white.widthPx,
        height: white.heightPx,
        face: null,
        rgba: _whiteBorder(white.widthPx, white.heightPx),
      );
      expect(_check(report, 'background').status, CheckStatus.pass);
    });

    test('missing pixels report info', () {
      final report = ComplianceEngine.evaluate(
        spec: spec,
        width: spec.widthPx,
        height: spec.heightPx,
        face: null,
      );
      expect(_check(report, 'background').status, CheckStatus.info);
    });
  });

  group('glasses check', () {
    test('always informational with the spec rule', () {
      final report = ComplianceEngine.evaluate(
        spec: spec,
        width: spec.widthPx,
        height: spec.heightPx,
        face: null,
      );
      final glasses = _check(report, 'glasses');
      expect(glasses.status, CheckStatus.info);
      expect(glasses.measured, 'compliance_glasses_forbidden');
    });
  });

  group('file size check', () {
    test('passes under the limit and warns above', () {
      final limited = _spec(maxKb: 50);
      final ok = ComplianceEngine.evaluate(
        spec: limited,
        width: limited.widthPx,
        height: limited.heightPx,
        face: null,
        bytesLength: 20 * 1024,
      );
      expect(_check(ok, 'fileSize').status, CheckStatus.pass);
      final tooBig = ComplianceEngine.evaluate(
        spec: limited,
        width: limited.widthPx,
        height: limited.heightPx,
        face: null,
        bytesLength: 80 * 1024,
      );
      expect(_check(tooBig, 'fileSize').status, CheckStatus.warn);
    });
  });
}
