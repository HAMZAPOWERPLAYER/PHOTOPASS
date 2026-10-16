import 'package:flutter_test/flutter_test.dart';
import 'package:photo_pass/features/country_select/domain/photo_spec.dart';

void main() {
  group('PhotoSpec.fromJson', () {
    Map<String, Object?> validJson() => <String, Object?>{
      'id': 'xx_passport',
      'countryCode': 'XX',
      'documentType': 'passport',
      'displayNameKey': 'spec_xx_passport',
      'widthMm': 35,
      'heightMm': 45,
      'minPx': 600,
      'maxPx': 1200,
      'dpi': 600,
      'backgroundHex': '#FFFFFF',
      'headHeightMinPct': 60.0,
      'headHeightMaxPct': 75.0,
      'eyeLineMinPct': null,
      'eyeLineMaxPct': null,
      'maxFileSizeKb': 5120,
      'fileFormats': <Object?>['jpg', 'png'],
      'glassesAllowed': true,
      'notes': null,
      'sourceUrl': 'https://example.gov/photo',
      'lastVerified': '2026-10-15',
      'verified': true,
    };

    test('parses a complete spec', () {
      final spec = PhotoSpec.fromJson(validJson());

      expect(spec.id, 'xx_passport');
      expect(spec.documentType, DocumentType.passport);
      expect(spec.widthMm, 35);
      expect(spec.heightMm, 45);
      expect(spec.fileFormats, ['jpg', 'png']);
      expect(spec.verified, isTrue);
    });

    test('computes exact pixel dimensions from mm and dpi', () {
      final spec = PhotoSpec.fromJson(validJson());

      // 35 mm at 600 dpi = 827 px; 45 mm = 1063 px.
      expect(spec.widthPx, 827);
      expect(spec.heightPx, 1063);
    });

    test('throws when sourceUrl is missing', () {
      final json = validJson()..remove('sourceUrl');
      expect(() => PhotoSpec.fromJson(json), throwsFormatException);
    });

    test('throws when lastVerified is missing', () {
      final json = validJson()..remove('lastVerified');
      expect(() => PhotoSpec.fromJson(json), throwsFormatException);
    });

    test('throws on unknown documentType', () {
      final json = validJson()..['documentType'] = 'bus_pass';
      expect(() => PhotoSpec.fromJson(json), throwsFormatException);
    });

    test('throws on missing widthMm', () {
      final json = validJson()..remove('widthMm');
      expect(() => PhotoSpec.fromJson(json), throwsFormatException);
    });
  });

  group('schemaVersion parsing', () {
    test('reads schemaVersion from the preset file', () {
      const source = '{"schemaVersion": 1, "specs": []}';
      expect(PhotoSpec.schemaVersionFromJsonString(source), 1);
    });

    test('throws when schemaVersion is absent', () {
      const source = '{"specs": []}';
      expect(
        () => PhotoSpec.schemaVersionFromJsonString(source),
        throwsFormatException,
      );
    });
  });
}
