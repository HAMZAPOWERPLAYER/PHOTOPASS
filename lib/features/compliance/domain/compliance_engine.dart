import 'dart:typed_data';

import '../../country_select/domain/photo_spec.dart';
import '../../editor/domain/photo_adjustments.dart';
import '../../face_detection/domain/detected_face.dart';

/// Outcome of one compliance check.
enum CheckStatus { pass, warn, fail, info }

/// A single requirement check for the produced photo.
class ComplianceCheck {
  const ComplianceCheck({
    required this.id,
    required this.status,
    this.measured,
  });

  /// Stable identifier mapped to an l10n key (`compliance_$id`).
  final String id;
  final CheckStatus status;

  /// Human-friendly measured value (already formatted), when applicable.
  final String? measured;
}

/// Result of running the whole checklist against a photo + spec.
class ComplianceReport {
  const ComplianceReport(this.checks);

  final List<ComplianceCheck> checks;

  bool get allPassed => checks.every((check) => check.status == CheckStatus.pass);

  bool get hasFailure => checks.any((check) => check.status == CheckStatus.fail);
}

/// Pure, offline compliance evaluation — no Flutter, no platform code.
class ComplianceEngine {
  const ComplianceEngine._();

  /// Runs the checklist for a photo of [width]×[height] pixels that was
  /// produced from a crop window of the source photo (so head/eye ratios
  /// scale identically), with [face] detected in the crop, and border
  /// pixel samples for the background check.
  ///
  /// All measurements are honest: if a value cannot be measured it is
  /// reported as [CheckStatus.info], never as a pass.
  static ComplianceReport evaluate({
    required PhotoSpec spec,
    required int width,
    required int height,
    required DetectedFace? face,
    Uint8List? rgba,
    int bytesLength = 0,
  }) {
    final checks = <ComplianceCheck>[];

    // 1. Pixel dimensions must match the spec exactly.
    final sizeOk = width == spec.widthPx && height == spec.heightPx;
    checks.add(
      ComplianceCheck(
        id: 'dimensions',
        status: sizeOk ? CheckStatus.pass : CheckStatus.fail,
        measured: '$width×$height',
      ),
    );

    // 2. Face present.
    if (face == null) {
      checks.add(const ComplianceCheck(id: 'face', status: CheckStatus.fail));
    } else {
      checks.add(const ComplianceCheck(id: 'face', status: CheckStatus.pass));

      // 3. Head height within the official range (when published).
      final minHead = spec.headHeightMinPct;
      final maxHead = spec.headHeightMaxPct;
      if (minHead != null && maxHead != null) {
        final headPct = face.headHeight / height * 100;
        final ok = headPct >= minHead && headPct <= maxHead;
        checks.add(
          ComplianceCheck(
            id: 'headHeight',
            status: ok
                ? CheckStatus.pass
                : (headPct < minHead ? CheckStatus.fail : CheckStatus.warn),
            measured: '${headPct.toStringAsFixed(1)}%',
          ),
        );
      } else {
        checks.add(
          const ComplianceCheck(id: 'headHeight', status: CheckStatus.info),
        );
      }

      // 4. Eye line within the official range (when published).
      final minEye = spec.eyeLineMinPct;
      final maxEye = spec.eyeLineMaxPct;
      if (minEye != null && maxEye != null) {
        final eyePct = (height - face.eyeY) / height * 100;
        final ok = eyePct >= minEye && eyePct <= maxEye;
        checks.add(
          ComplianceCheck(
            id: 'eyeLine',
            status: ok ? CheckStatus.pass : CheckStatus.warn,
            measured: '${eyePct.toStringAsFixed(1)}%',
          ),
        );
      } else {
        checks.add(
          const ComplianceCheck(id: 'eyeLine', status: CheckStatus.info),
        );
      }
    }

    // 5. Background: uniformity + closeness to the required colour.
    if (rgba != null) {
      final bg = _analyzeBorder(rgba, width, height);
      final required = parseHexColor(spec.backgroundHex);
      final distance = _colorDistance(bg.meanRgb, required);
      final uniform = bg.stddev <= 18;
      final status = uniform && distance <= 60
          ? CheckStatus.pass
          : uniform
          ? CheckStatus.warn
          : CheckStatus.fail;
      checks.add(ComplianceCheck(id: 'background', status: status));
    } else {
      checks.add(
        const ComplianceCheck(id: 'background', status: CheckStatus.info),
      );
    }

    // 6. Glasses rule (informational; the app cannot detect lenses
    // reliably, so it reports the spec's rule rather than a verdict).
    checks.add(
      ComplianceCheck(
        id: 'glasses',
        status: CheckStatus.info,
        measured: spec.glassesAllowed
            ? 'compliance_glasses_allowed'
            : 'compliance_glasses_forbidden',
      ),
    );

    // 7. File size guidance (bytes measured after encoding).
    final maxKb = spec.maxFileSizeKb;
    if (maxKb != null && bytesLength > 0) {
      final kb = bytesLength / 1024;
      checks.add(
        ComplianceCheck(
          id: 'fileSize',
          status: kb <= maxKb ? CheckStatus.pass : CheckStatus.warn,
          measured: '${kb.toStringAsFixed(0)} KB',
        ),
      );
    }

    return ComplianceReport(checks);
  }

  static int _colorDistance(int a, int b) {
    final dr = ((a >> 16 & 0xFF) - (b >> 16 & 0xFF)).abs();
    final dg = ((a >> 8 & 0xFF) - (b >> 8 & 0xFF)).abs();
    final db = ((a & 0xFF) - (b & 0xFF)).abs();
    return dr + dg + db;
  }

  static _BorderStats _analyzeBorder(Uint8List rgba, int width, int height) {
    var sumR = 0;
    var sumG = 0;
    var sumB = 0;
    var sum = 0;
    var sumSq = 0;
    var count = 0;
    final step = width > 600 ? width ~/ 300 : 1;
    void sample(int index) {
      final o = index * 4;
      final r = rgba[o];
      final g = rgba[o + 1];
      final b = rgba[o + 2];
      sumR += r;
      sumG += g;
      sumB += b;
      final luma = (r * 299 + g * 587 + b * 114) ~/ 1000;
      sum += luma;
      sumSq += luma * luma;
      count++;
    }

    for (var x = 0; x < width; x += step) {
      sample(x);
      sample((height - 1) * width + x);
    }
    for (var y = 0; y < height; y += step) {
      sample(y * width);
      sample(y * width + width - 1);
    }
    if (count == 0) {
      return const _BorderStats(meanRgb: 0, stddev: 999);
    }
    final mean = sum / count;
    final variance = sumSq / count - mean * mean;
    final meanRgb = ((sumR ~/ count) << 16) | ((sumG ~/ count) << 8) | (sumB ~/ count);
    return _BorderStats(meanRgb: meanRgb, stddev: _sqrt(variance.clamp(0, double.infinity)));
  }

  /// Newton-free integer sqrt for the stddev computation.
  static double _sqrt(double value) {
    if (value <= 0) return 0;
    var x = value;
    for (var i = 0; i < 24; i++) {
      x = (x + value / x) / 2;
    }
    return x;
  }
}

class _BorderStats {
  const _BorderStats({required this.meanRgb, required this.stddev});

  /// Mean border colour packed as 0xRRGGBB.
  final int meanRgb;

  /// Standard deviation of border luma (uniformity).
  final double stddev;
}
