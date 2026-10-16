import 'dart:io' show File;
import 'dart:typed_data';

import 'package:flutter/foundation.dart' show compute;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart' as img;

import '../../../core/errors/failure.dart';
import '../../../core/errors/result.dart';
import '../../editor/domain/crop_engine.dart';
import '../../editor/domain/photo_adjustments.dart';

/// A processed image: encoded JPEG bytes plus its pixel dimensions.
class ProcessedImage {
  const ProcessedImage({required this.bytes, required this.width, required this.height});

  final Uint8List bytes;
  final int width;
  final int height;
}

/// On-device image operations. Every heavy step runs in an isolate so the
/// UI stays responsive; nothing ever leaves the phone.
class ImagePipeline {
  const ImagePipeline();

  /// Decodes [path], bakes EXIF orientation and returns full-resolution
  /// JPEG bytes.
  Future<Result<ProcessedImage>> loadBaked(String path) => _run(path, const _LoadOp());

  /// Returns a small preview (longest edge ≤ [maxDim]) for display.
  Future<Result<ProcessedImage>> loadPreview(String path, {int maxDim = 1280}) =>
      _run(path, _PreviewOp(maxDim: maxDim));

  /// Rotates clockwise by 90° × [turns].
  Future<Result<ProcessedImage>> rotate90(ProcessedImage source, {int turns = 1}) =>
      _process(source.bytes, _RotateOp(turns: turns));

  /// Crops to [rect] (image pixel coordinates).
  Future<Result<ProcessedImage>> crop(ProcessedImage source, PixelRect rect) =>
      _process(source.bytes, _CropOp(rect: rect));

  /// Resizes to exactly [width] × [height] (high-quality cubic filter).
  Future<Result<ProcessedImage>> resize(ProcessedImage source, {required int width, required int height}) =>
      _process(source.bytes, _ResizeOp(width: width, height: height));

  /// Re-encodes as JPEG at [quality] (1–100).
  Future<Result<ProcessedImage>> encodeJpg(ProcessedImage source, {int quality = 92}) =>
      _process(source.bytes, _EncodeOp(quality: quality));

  /// Applies on-device retouching: optional border flood-fill background
  /// replacement plus brightness/contrast/saturation adjustments.
  Future<Result<ProcessedImage>> retouch(
    ProcessedImage source, {
    required bool removeBackground,
    required double tolerance,
    required String backgroundHex,
    required double brightness,
    required double contrast,
    required double saturation,
  }) => _process(
    source.bytes,
    _RetouchOp(
      removeBackground: removeBackground,
      tolerance: tolerance,
      backgroundHex: backgroundHex,
      brightness: brightness,
      contrast: contrast,
      saturation: saturation,
    ),
  );

  Future<Result<ProcessedImage>> _run(String path, _ImageOp op) async {
    try {
      final input = await _readFile(path);
      final bytes = await compute(op.run, input);
      return Success(bytes);
    } on Exception catch (error) {
      return FailureResult(ImageProcessingFailure('image op failed', cause: error));
    }
  }

  Future<Result<ProcessedImage>> _process(Uint8List bytes, _ImageOp op) async {
    try {
      final result = await compute(op.run, bytes);
      return Success(result);
    } on Exception catch (error) {
      return FailureResult(ImageProcessingFailure('image op failed', cause: error));
    }
  }
}

/// Isolate-safe image operation: transforms raw input bytes and encodes.
abstract class _ImageOp {
  const _ImageOp();

  /// Runs inside an isolate with raw input bytes.
  ProcessedImage run(Uint8List input);
}

class _LoadOp extends _ImageOp {
  const _LoadOp();

  @override
  ProcessedImage run(Uint8List input) {
    final decoded = img.decodeImage(input);
    if (decoded == null) throw const FormatException('undecodable image');
    final baked = img.bakeOrientation(decoded);
    final encoded = img.encodeJpg(baked, quality: 95);
    return ProcessedImage(bytes: Uint8List.fromList(encoded), width: baked.width, height: baked.height);
  }
}

class _PreviewOp extends _ImageOp {
  const _PreviewOp({required this.maxDim});

  final int maxDim;

  @override
  ProcessedImage run(Uint8List input) {
    final decoded = img.decodeImage(input);
    if (decoded == null) throw const FormatException('undecodable image');
    final baked = img.bakeOrientation(decoded);
    final scale = baked.width > baked.height
        ? maxDim / baked.width
        : maxDim / baked.height;
    final scaled = scale >= 1
        ? baked
        : img.copyResize(
            baked,
            width: (baked.width * scale).round(),
            height: (baked.height * scale).round(),
            interpolation: img.Interpolation.cubic,
          );
    final encoded = img.encodeJpg(scaled, quality: 88);
    return ProcessedImage(bytes: Uint8List.fromList(encoded), width: scaled.width, height: scaled.height);
  }
}

class _RotateOp extends _ImageOp {
  const _RotateOp({required this.turns});

  final int turns;

  @override
  ProcessedImage run(Uint8List input) {
    final decoded = img.decodeImage(input);
    if (decoded == null) throw const FormatException('undecodable image');
    final rotated = turns % 4 == 0
        ? decoded
        : img.copyRotate(decoded, angle: 90.0 * (turns % 4));
    final encoded = img.encodeJpg(rotated, quality: 95);
    return ProcessedImage(bytes: Uint8List.fromList(encoded), width: rotated.width, height: rotated.height);
  }
}

class _CropOp extends _ImageOp {
  const _CropOp({required this.rect});

  final PixelRect rect;

  @override
  ProcessedImage run(Uint8List input) {
    final decoded = img.decodeImage(input);
    if (decoded == null) throw const FormatException('undecodable image');
    final x = rect.x.round().clamp(0, decoded.width - 1);
    final y = rect.y.round().clamp(0, decoded.height - 1);
    final w = rect.w.round().clamp(1, decoded.width - x);
    final h = rect.h.round().clamp(1, decoded.height - y);
    final cropped = img.copyCrop(decoded, x: x, y: y, width: w, height: h);
    final encoded = img.encodeJpg(cropped, quality: 95);
    return ProcessedImage(bytes: Uint8List.fromList(encoded), width: cropped.width, height: cropped.height);
  }
}

class _ResizeOp extends _ImageOp {
  const _ResizeOp({required this.width, required this.height});

  final int width;
  final int height;

  @override
  ProcessedImage run(Uint8List input) {
    final decoded = img.decodeImage(input);
    if (decoded == null) throw const FormatException('undecodable image');
    final resized = img.copyResize(
      decoded,
      width: width,
      height: height,
      interpolation: img.Interpolation.cubic,
    );
    final encoded = img.encodeJpg(resized, quality: 95);
    return ProcessedImage(bytes: Uint8List.fromList(encoded), width: resized.width, height: resized.height);
  }
}

class _EncodeOp extends _ImageOp {
  const _EncodeOp({required this.quality});

  final int quality;

  @override
  ProcessedImage run(Uint8List input) {
    final decoded = img.decodeImage(input);
    if (decoded == null) throw const FormatException('undecodable image');
    final encoded = img.encodeJpg(decoded, quality: quality.clamp(1, 100));
    return ProcessedImage(bytes: Uint8List.fromList(encoded), width: decoded.width, height: decoded.height);
  }
}

class _RetouchOp extends _ImageOp {
  const _RetouchOp({
    required this.removeBackground,
    required this.tolerance,
    required this.backgroundHex,
    required this.brightness,
    required this.contrast,
    required this.saturation,
  });

  final bool removeBackground;
  final double tolerance;
  final String backgroundHex;
  final double brightness;
  final double contrast;
  final double saturation;

  @override
  ProcessedImage run(Uint8List input) {
    final decoded = img.decodeImage(input);
    if (decoded == null) throw const FormatException('undecodable image');
    final rgba = decoded.getBytes(order: img.ChannelOrder.rgba);
    if (removeBackground) {
      BackgroundRemover.replaceBackground(
        rgba: rgba,
        width: decoded.width,
        height: decoded.height,
        tolerance: tolerance,
        replacement: parseHexColor(backgroundHex),
      );
    }
    BackgroundRemover.adjust(
      rgba: rgba,
      brightness: brightness,
      contrast: contrast,
      saturation: saturation,
    );
    final out = img.Image.fromBytes(
      width: decoded.width,
      height: decoded.height,
      bytes: rgba.buffer,
      order: img.ChannelOrder.rgba,
      numChannels: 4,
    );    final encoded = img.encodeJpg(out, quality: 95);
    return ProcessedImage(bytes: Uint8List.fromList(encoded), width: out.width, height: out.height);
  }
}

/// Reads a source photo file as raw bytes.
Future<Uint8List> _readFile(String path) => File(path).readAsBytes();

/// Shared pipeline instance (stateless; every op runs in an isolate).
final imagePipelineProvider = Provider<ImagePipeline>(
  (ref) => const ImagePipeline(),
);
