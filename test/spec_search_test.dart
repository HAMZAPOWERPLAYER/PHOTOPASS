import 'package:flutter_test/flutter_test.dart';
import 'package:photo_pass/features/country_select/domain/country_info.dart';
import 'package:photo_pass/features/country_select/domain/photo_spec.dart';
import 'package:photo_pass/features/country_select/domain/spec_search.dart';

void main() {
  PhotoSpec spec(String id, String code, DocumentType type) => PhotoSpec(
    id: id,
    countryCode: code,
    documentType: type,
    displayNameKey: id,
    widthMm: 35,
    heightMm: 45,
    dpi: 600,
    backgroundHex: '#FFFFFF',
    fileFormats: const ['jpg'],
    glassesAllowed: true,
    sourceUrl: 'https://example.gov',
    lastVerified: '2026-10-15',
    verified: true,
  );

  final specs = [
    spec('us_passport', 'US', DocumentType.passport),
    spec('gb_passport', 'GB', DocumentType.passport),
    spec('cn_visa', 'CN', DocumentType.visa),
  ];

  group('searchSpecs', () {
    test('returns everything for a blank query', () {
      expect(searchSpecs(specs, '   '), hasLength(3));
    });

    test('matches country name case-insensitively', () {
      final results = searchSpecs(
        specs,
        'united',
        countryNames: const {'US': 'United States', 'GB': 'United Kingdom'},
      );
      expect(results, hasLength(2));
    });

    test('matches ISO country code', () {
      expect(searchSpecs(specs, 'cn'), hasLength(1));
    });

    test('matches document type', () {
      expect(searchSpecs(specs, 'visa'), hasLength(1));
    });

    test('returns empty for no match', () {
      expect(searchSpecs(specs, 'mars'), isEmpty);
    });
  });

  group('groupByCountry', () {
    test('groups specs by country preserving order', () {
      final grouped = groupByCountry(specs);
      expect(grouped.keys, ['US', 'GB', 'CN']);
      expect(grouped['US'], hasLength(1));
    });
  });

  group('CountryInfo', () {
    test('flagOf produces regional indicator emoji', () {
      expect(CountryInfo.flagOf('US'), '🇺🇸');
      expect(CountryInfo.flagOf('gb'), '🇬🇧');
    });

    test('nameOf falls back to the code', () {
      expect(CountryInfo.nameOf('US'), 'United States');
      expect(CountryInfo.nameOf('ZZ'), 'ZZ');
    });
  });
}
