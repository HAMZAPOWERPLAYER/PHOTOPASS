// CI gate for the preset database: fails the build if any bundled spec is
// missing sourceUrl/lastVerified, carries impossible values, or drifts from
// the schema. Keep this strict — accuracy is the product.
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:photo_pass/features/country_select/domain/photo_spec.dart';

void main() {
  final file = File('assets/presets/photo_specs.json');
  final raw = file.readAsStringSync();
  final version = PhotoSpec.schemaVersionFromJsonString(raw);
  final specs = PhotoSpec.listFromJsonString(raw);

  test('preset schema version is supported', () {
    expect(version, equals(1));
  });

  test('preset database is not empty', () {
    expect(specs, isNotEmpty);
  });

  test('spec ids are unique', () {
    final ids = specs.map((spec) => spec.id).toList();
    expect(ids.toSet().length, ids.length, reason: 'duplicate spec ids');
  });

  for (final spec in specs) {
    group('spec ${spec.id}', () {
      test('has an official source and verification date', () {
        expect(spec.sourceUrl, startsWith('https://'));
        expect(
          RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(spec.lastVerified),
          isTrue,
          reason: 'lastVerified must be an ISO date',
        );
        expect(
          DateTime.tryParse(spec.lastVerified),
          isNotNull,
          reason: 'lastVerified must parse as a date',
        );
      });

      test('verification flags are consistent', () {
        if (spec.verified) {
          expect(spec.lastVerified, isNotEmpty);
        }
      });

      test('has plausible physical dimensions', () {
        expect(spec.widthMm, greaterThan(0));
        expect(spec.heightMm, greaterThan(0));
        expect(spec.widthMm, lessThanOrEqualTo(200));
        expect(spec.heightMm, lessThanOrEqualTo(200));
        expect(spec.dpi, inInclusiveRange(100, 1200));
      });

      test('has valid percentage ranges', () {
        for (final value in [
          spec.headHeightMinPct,
          spec.headHeightMaxPct,
          spec.eyeLineMinPct,
          spec.eyeLineMaxPct,
        ]) {
          if (value != null) {
            expect(value, inInclusiveRange(0, 100));
          }
        }
        if (spec.headHeightMinPct != null && spec.headHeightMaxPct != null) {
          expect(
            spec.headHeightMinPct! <= spec.headHeightMaxPct!,
            isTrue,
            reason: 'headHeightMinPct must not exceed headHeightMaxPct',
          );
        }
      });

      test('has a well-formed background colour', () {
        expect(
          RegExp(r'^#[0-9A-F]{6}$').hasMatch(spec.backgroundHex),
          isTrue,
        );
      });

      test('declares file formats', () {
        expect(spec.fileFormats, isNotEmpty);
        for (final format in spec.fileFormats) {
          expect(
            const ['jpg', 'png'],
            contains(format),
            reason: 'unsupported format "$format"',
          );
        }
      });

      test('has an ISO country code and known document type', () {
        expect(
          RegExp(r'^[A-Z]{2}$').hasMatch(spec.countryCode),
          isTrue,
        );
        expect(
          DocumentType.values,
          contains(spec.documentType),
        );
      });
    });
  }
}
