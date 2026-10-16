import 'dart:io' show File, Platform;
import 'dart:typed_data';

import 'package:flutter/foundation.dart' show compute;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../core/errors/failure.dart';
import '../../../core/errors/result.dart';
import '../../country_select/domain/photo_spec.dart';
import '../domain/print_sheet.dart';

/// Produces the final deliverables: exact-size photo, print sheet image,
/// and a print-sheet PDF. All on-device; no network.
class ExportService {
  const ExportService();

  /// Returns exact-spec pixels ([PhotoSpec.widthPx] × [PhotoSpec.heightPx])
  /// encoded as JPEG at [quality].
  Future<Result<ExportFile>> buildPhoto({
    required String sourcePath,
    required PhotoSpec spec,
    int quality = 92,
  }) => _run(
    _ExportJob(
      sourcePath: sourcePath,
      targetWidth: spec.widthPx,
      targetHeight: spec.heightPx,
      sheet: null,
      sheetDpi: 0,
      quality: quality,
    ),
    _buildPhotoOp,
  );

  /// Builds a multi-photo print sheet at [dpi] on [sheet].
  Future<Result<ExportFile>> buildPrintSheet({
    required String sourcePath,
    required PhotoSpec spec,
    required SheetPreset sheet,
    int dpi = 300,
    int quality = 92,
    String outName = 'print_sheet.jpg',
  }) => _run(
    _ExportJob(
      sourcePath: sourcePath,
      targetWidth: spec.widthPx,
      targetHeight: spec.heightPx,
      photoWidthMm: spec.widthMm,
      photoHeightMm: spec.heightMm,
      sheet: sheet,
      sheetDpi: dpi,
      quality: quality,
      outName: outName,
    ),
    _buildSheetOp,
  );

  /// Builds a single-photo PDF at the spec's physical size (print ready).
  Future<Result<ExportFile>> buildPdf({
    required String sourcePath,
    required PhotoSpec spec,
  }) async {
    try {
      final bytes = await File(sourcePath).readAsBytes();
      final result = await compute(_preparePdfImage, (
        bytes: bytes,
        width: spec.widthPx,
        height: spec.heightPx,
      ));
      if (result == null) {
        return const FailureResult(ImageProcessingFailure('undecodable image'));
      }
      final pdfBytes = await compute(_composePdf, _PdfJob(
        jpeg: result,
        widthMm: spec.widthMm,
        heightMm: spec.heightMm,
      ));
      final file = await _writeOutput(pdfBytes, 'photo.pdf');
      return Success(file);
    } on Exception catch (error) {
      return FailureResult(ImageProcessingFailure('pdf failed', cause: error));
    }
  }

  Future<Result<ExportFile>> _run(_ExportJob job, _OpRunner runner) async {
    try {
      final out = await compute(runner, job);
      if (out == null) {
        return const FailureResult(ImageProcessingFailure('undecodable image'));
      }
      final file = await _writeOutput(out.bytes, out.name);
      return Success(file);
    } on Exception catch (error) {
      return FailureResult(ImageProcessingFailure('export failed', cause: error));
    }
  }
}

/// A written export artifact in app-private storage.
class ExportFile {
  const ExportFile({required this.path, required this.bytes});

  final String path;
  final int bytes;
}

class _ExportJob {
  const _ExportJob({
    required this.sourcePath,
    required this.targetWidth,
    required this.targetHeight,
    required this.sheet,
    required this.sheetDpi,
    required this.quality,
    this.photoWidthMm = 35,
    this.photoHeightMm = 45,
    this.outName = 'photo.jpg',
  });

  final String sourcePath;
  final int targetWidth;
  final int targetHeight;
  final SheetPreset? sheet;
  final int sheetDpi;
  final int quality;
  final double photoWidthMm;
  final double photoHeightMm;
  final String outName;
}

class _OpOutput {
  const _OpOutput(this.bytes, this.name);

  final Uint8List bytes;
  final String name;
}

typedef _OpRunner = _OpOutput? Function(_ExportJob job);

_OpOutput? _buildPhotoOp(_ExportJob job) {
  final source = _decodeFile(job.sourcePath);
  if (source == null) return null;
  final resized = img.copyResize(
    source,
    width: job.targetWidth,
    height: job.targetHeight,
    interpolation: img.Interpolation.cubic,
  );
  return _OpOutput(
    Uint8List.fromList(img.encodeJpg(resized, quality: job.quality.clamp(1, 100))),
    job.outName,
  );
}

_OpOutput? _buildSheetOp(_ExportJob job) {
  final sheet = job.sheet;
  if (sheet == null) return null;
  final source = _decodeFile(job.sourcePath);
  if (source == null) return null;

  final photo = img.copyResize(
    source,
    width: job.targetWidth,
    height: job.targetHeight,
    interpolation: img.Interpolation.cubic,
  );
  final sheetW = (sheet.widthMm / 25.4 * job.sheetDpi).round();
  final sheetH = (sheet.heightMm / 25.4 * job.sheetDpi).round();
  final pxPerMm = job.sheetDpi / 25.4;

  final layout = PrintSheetLayout.grid(
    sheetWidthMm: sheet.widthMm,
    sheetHeightMm: sheet.heightMm,
    photoWidthMm: job.photoWidthMm,
    photoHeightMm: job.photoHeightMm,
  );
  if (layout.photoCount == 0) return null;

  final canvas = img.Image(width: sheetW, height: sheetH);
  img.fill(canvas, color: img.ColorRgb8(255, 255, 255));
  for (final position in layout.positionsMm) {
    img.compositeImage(
      canvas,
      photo,
      dstX: (position.x * pxPerMm).round(),
      dstY: (position.y * pxPerMm).round(),
    );
  }
  return _OpOutput(
    Uint8List.fromList(img.encodeJpg(canvas, quality: job.quality.clamp(1, 100))),
    job.outName,
  );
}

img.Image? _decodeFile(String path) {
  final file = File(path);
  if (!file.existsSync()) return null;
  return img.decodeImage(file.readAsBytesSync());
}

class _PdfJob {
  const _PdfJob({required this.jpeg, required this.widthMm, required this.heightMm});

  final Uint8List jpeg;
  final double widthMm;
  final double heightMm;
}

Uint8List? _preparePdfImage(({Uint8List bytes, int width, int height}) job) {
  final decoded = img.decodeImage(job.bytes);
  if (decoded == null) return null;
  final resized = img.copyResize(
    decoded,
    width: job.width,
    height: job.height,
    interpolation: img.Interpolation.cubic,
  );
  return Uint8List.fromList(img.encodeJpg(resized, quality: 95));
}

Future<Uint8List> _composePdf(_PdfJob job) async {
  final doc = pw.Document();
  final pageWidth = job.widthMm * PdfPageFormat.mm;
  final pageHeight = job.heightMm * PdfPageFormat.mm;
  doc.addPage(
    pw.Page(
      pageFormat: PdfPageFormat(pageWidth, pageHeight),
      margin: pw.EdgeInsets.zero,
      build: (context) => pw.SizedBox(
        width: pageWidth,
        height: pageHeight,
        child: pw.Image(pw.MemoryImage(job.jpeg), fit: pw.BoxFit.fill),
      ),
    ),
  );
  return doc.save();
}

Future<ExportFile> _writeOutput(List<int> bytes, String name) async {
  final dir = await getTemporaryDirectory();
  final file = File(
    '${dir.path}${Platform.pathSeparator}export-${DateTime.now().microsecondsSinceEpoch}-$name',
  );
  await file.writeAsBytes(bytes, flush: true);
  return ExportFile(path: file.path, bytes: bytes.length);
}

final exportServiceProvider = Provider<ExportService>((ref) => const ExportService());
