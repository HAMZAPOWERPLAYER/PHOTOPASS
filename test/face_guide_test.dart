import 'package:flutter_test/flutter_test.dart';
import 'package:photo_pass/features/capture/domain/face_guide.dart';
import 'package:photo_pass/features/country_select/domain/photo_spec.dart';

void main() {
  PhotoSpec spec({
    double? headMin,
    double? headMax,
    double? eyeMin,
    double? eyeMax,
  }) => PhotoSpec(
    id: 'xx_passport',
    countryCode: 'XX',
    documentType: DocumentType.passport,
    displayNameKey: 'spec_xx_passport',
    widthMm: 35,
    heightMm: 45,
    dpi: 600,
    backgroundHex: '#FFFFFF',
    fileFormats: const ['jpg'],
    glassesAllowed: true,
    sourceUrl: 'https://example.gov',
    lastVerified: '2026-10-15',
    verified: true,
    headHeightMinPct: headMin,
    headHeightMaxPct: headMax,
    eyeLineMinPct: eyeMin,
    eyeLineMaxPct: eyeMax,
  );

  group('FaceGuide.fromSpec', () {
    test('uses midpoints of published head and eye ranges', () {
      final guide = FaceGuide.fromSpec(
        spec(headMin: 49, headMax: 69, eyeMin: 55, eyeMax: 69),
      );

      // Head height: midpoint 59% of frame.
      expect(guide.headBox.height, closeTo(0.59, 0.001));
      // Eye line: midpoint 62% from bottom = 38% from top.
      expect(guide.eyeLineY, closeTo(0.38, 0.001));
    });

    test('head box stays inside the frame', () {
      final guide = FaceGuide.fromSpec(
        spec(headMin: 49, headMax: 69, eyeMin: 55, eyeMax: 69),
      );

      expect(guide.headBox.top, greaterThanOrEqualTo(0));
      expect(guide.headBox.top + guide.headBox.height, lessThanOrEqualTo(1));
      expect(guide.headBox.left, greaterThanOrEqualTo(0));
      expect(guide.headBox.left + guide.headBox.width, lessThanOrEqualTo(1));
    });

    test('oval fully contains the head box', () {
      final guide = FaceGuide.fromSpec(
        spec(headMin: 49, headMax: 69, eyeMin: 55, eyeMax: 69),
      );

      expect(guide.oval.left, lessThanOrEqualTo(guide.headBox.left));
      expect(guide.oval.top, lessThanOrEqualTo(guide.headBox.top));
      expect(
        guide.oval.left + guide.oval.width,
        greaterThanOrEqualTo(guide.headBox.left + guide.headBox.width),
      );
      expect(
        guide.oval.top + guide.oval.height,
        greaterThanOrEqualTo(guide.headBox.top + guide.headBox.height),
      );
    });

    test('falls back to defaults when the spec is silent', () {
      final guide = FaceGuide.fromSpec(spec());

      // Default head height 0.6; frame stays valid.
      expect(guide.headBox.height, closeTo(0.6, 0.001));
      expect(guide.eyeLineY, inInclusiveRange(0, 1));
      expect(guide.headBox.top, greaterThanOrEqualTo(0));
    });

    test('portrait frames give the head box more relative width', () {
      // Normalized head-box width scales with frame aspect (h/w): a narrower
      // portrait frame makes the same physical head a larger fraction of it.
      final portrait = FaceGuide.fromSpec(
        spec(headMin: 50, headMax: 50, eyeMin: 60, eyeMax: 60),
      );
      const squareSpec = PhotoSpec(
        id: 'yy_passport',
        countryCode: 'YY',
        documentType: DocumentType.passport,
        displayNameKey: 'spec_yy_passport',
        widthMm: 51,
        heightMm: 51,
        dpi: 300,
        backgroundHex: '#FFFFFF',
        fileFormats: ['jpg'],
        glassesAllowed: true,
        sourceUrl: 'https://example.gov',
        lastVerified: '2026-10-15',
        verified: true,
        headHeightMinPct: 50,
        headHeightMaxPct: 50,
        eyeLineMinPct: 60,
        eyeLineMaxPct: 60,
      );
      final square = FaceGuide.fromSpec(squareSpec);

      expect(portrait.headBox.width, greaterThan(square.headBox.width));
    });
  });
}
