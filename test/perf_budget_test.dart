import 'package:flutter_test/flutter_test.dart';
import 'package:photo_pass/features/country_select/domain/photo_spec.dart';
import 'package:photo_pass/features/country_select/domain/spec_search.dart';
import 'package:photo_pass/features/editor/domain/crop_engine.dart';

/// Performance budgets from design spec §38. These are generous upper
/// bounds measured on the test host (far slower than a real device would
/// need); exceeding them means an accidental complexity regression, not a
/// device-level claim. Real device numbers are recorded in docs, not here.
void main() {
  PhotoSpec spec(String id, {String type = 'passport'}) => PhotoSpec.fromJson({
    'id': id,
    'countryCode': 'US',
    'documentType': type,
    'displayNameKey': 'spec_us_passport',
    'widthMm': 51,
    'heightMm': 51,
    'dpi': 600,
    'backgroundHex': '#FFFFFF',
    'fileFormats': ['JPEG'],
    'glassesAllowed': false,
    'sourceUrl': 'https://example.gov/photo-rules',
    'lastVerified': '2026-10-15',
    'verified': true,
  });

  test('country search stays under the 100 ms budget', () {
    final specs = [for (var i = 0; i < 200; i++) spec('spec_$i')];
    const names = {'US': 'United States'};

    // Warm up, then measure a representative mix of queries.
    searchSpecs(specs, 'unit', countryNames: names);
    final watch = Stopwatch()..start();
    for (final query in ['unit', 'passport', 'spec_1', 'zzz', '', 'US']) {
      searchSpecs(specs, query, countryNames: names);
      groupByCountry(searchSpecs(specs, query, countryNames: names));
    }
    watch.stop();

    // Six full search+group passes over 200 specs.
    expect(
      watch.elapsedMilliseconds,
      lessThan(100),
      reason: 'search+group budget is 100 ms for six passes',
    );
  });

  test('crop suggestion stays under the 50 ms budget', () {
    final photo = spec('spec_crop');
    CropEngine.suggest(imageW: 4000, imageH: 3000, spec: photo, face: null);

    final watch = Stopwatch()..start();
    for (var i = 0; i < 20; i++) {
      CropEngine.suggest(imageW: 4000, imageH: 3000, spec: photo, face: null);
    }
    watch.stop();

    // 20 suggestions must fit in 50 ms (≈2.5 ms each on this host).
    expect(
      watch.elapsedMilliseconds,
      lessThan(50),
      reason: 'crop suggest budget is 50 ms for 20 iterations',
    );
  });
}
