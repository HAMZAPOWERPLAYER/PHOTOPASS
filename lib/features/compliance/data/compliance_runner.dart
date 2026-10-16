import 'dart:io' show File;
import 'dart:typed_data';

import 'package:flutter/foundation.dart' show compute;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart' as img;

import '../../../app/flow/selected_spec_provider.dart';
import '../../../core/errors/result.dart';
import '../../country_select/domain/photo_spec.dart';
import '../../editor/data/edit_session.dart';
import '../../face_detection/data/face_detection_service.dart';
import '../../face_detection/domain/detected_face.dart';
import '../domain/compliance_engine.dart';

/// The compliance report for the current session's photo.
class ComplianceState {
  const ComplianceState({this.report, this.running = false, this.error = false});

  final ComplianceReport? report;
  final bool running;
  final bool error;
}

/// Runs the checklist against the session's final image. Detection and
/// pixel analysis happen off the UI thread; everything stays on-device.
class ComplianceController extends Notifier<ComplianceState> {
  @override
  ComplianceState build() => const ComplianceState();

  Future<void> evaluate() async {
    final session = ref.read(editSessionProvider);
    final spec = ref.read(selectedSpecProvider);
    final path = session.finalPath ?? session.croppedPath;
    if (spec == null || path == null) {
      state = const ComplianceState(error: true);
      return;
    }
    state = const ComplianceState(running: true);

    final faceResult = await ref
        .read(faceDetectionServiceProvider)
        .detectLargestFace(path);
    final face = faceResult is Success<DetectedFace?> ? faceResult.value : null;

    final analysis = await _analyzePixels(path);
    if (analysis == null) {
      state = const ComplianceState(error: true);
      return;
    }

    final report = ComplianceEngine.evaluate(
      spec: spec,
      width: analysis.width,
      height: analysis.height,
      face: face,
      rgba: analysis.rgba,
      bytesLength: await File(path).length(),
    );
    state = ComplianceState(report: report);
  }
}

class _PixelAnalysis {
  const _PixelAnalysis({required this.width, required this.height, required this.rgba});

  final int width;
  final int height;
  final Uint8List rgba;
}

/// Decodes the photo and returns border-analysable pixels; runs in an
/// isolate because decoding a full-res JPEG is expensive.
Future<_PixelAnalysis?> _analyzePixels(String path) async {
  try {
    final bytes = await File(path).readAsBytes();
    final analysis = await compute(_decodeRgba, bytes);
    return analysis;
  } on Exception {
    return null;
  }
}

_PixelAnalysis? _decodeRgba(Uint8List bytes) {
  final decoded = img.decodeImage(bytes);
  if (decoded == null) return null;
  return _PixelAnalysis(
    width: decoded.width,
    height: decoded.height,
    rgba: decoded.getBytes(order: img.ChannelOrder.rgba),
  );
}

final complianceProvider = NotifierProvider<ComplianceController, ComplianceState>(
  ComplianceController.new,
);

/// Convenience: the spec driving compliance (null when flow not started).
final complianceSpecProvider = Provider<PhotoSpec?>(
  (ref) => ref.watch(selectedSpecProvider),
);
