import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;

import 'package:photo_pass/core/errors/result.dart';
import 'package:photo_pass/features/editor/data/edit_session.dart';
import 'package:photo_pass/features/editor/data/image_pipeline.dart';
import 'package:photo_pass/features/editor/domain/crop_engine.dart';
import 'package:photo_pass/features/editor/presentation/editor_screen.dart';
import 'package:photo_pass/l10n/generated/app_localizations.dart';

/// A session that starts fully loaded (source, preview, crop) so the
/// editor's mode selector can be exercised without camera or file IO.
class _FakeSession extends EditSessionController {
  @override
  EditSessionState build() {
    final bytes = _tinyJpeg();
    final image = ProcessedImage(bytes: bytes, width: 64, height: 64);
    return EditSessionState(
      preview: image,
      working: image,
      crop: const PixelRect(x: 8, y: 8, w: 48, h: 48),
    );
  }
}

/// Runs pipeline operations on the main isolate so widget tests settle
/// deterministically (the real pipeline's isolates don't resume under
/// fake-async test zones).
class _FakePipeline extends ImagePipeline {
  const _FakePipeline();

  @override
  Future<Result<ProcessedImage>> crop(
    ProcessedImage source,
    PixelRect rect,
  ) async => Success(source);

  @override
  Future<Result<ProcessedImage>> retouch(
    ProcessedImage source, {
    required bool removeBackground,
    required double tolerance,
    required String backgroundHex,
    required double brightness,
    required double contrast,
    required double saturation,
  }) async => Success(source);
}

Uint8List _tinyJpeg() {
  final source = img.Image(width: 64, height: 64);
  img.fill(source, color: img.ColorRgb8(180, 190, 210));
  return Uint8List.fromList(img.encodeJpg(source, quality: 80));
}

Future<void> _openEditor(WidgetTester tester) async {
  // Portrait phone: exercises the stacked photo-over-controls layout (§36).
  tester.view.physicalSize = const Size(800, 1280);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        editSessionProvider.overrideWith(_FakeSession.new),
        imagePipelineProvider.overrideWithValue(const _FakePipeline()),
      ],
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: Builder(
            builder: (context) => TextButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<void>(builder: (_) => const EditorScreen()),
              ),
              child: const Text('open'),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('open'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('editor shows the mode selector and crop controls',
      (tester) async {
    await _openEditor(tester);

    expect(find.text('Edit photo'), findsOneWidget);
    expect(find.text('Crop'), findsOneWidget);
    expect(find.text('Background'), findsOneWidget);
    expect(find.text('Adjust'), findsOneWidget);
    expect(find.text('Drag to move, pinch to zoom.'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('background mode shows required/suggested palette and a real '
      'processed preview', (tester) async {
    await _openEditor(tester);

    await tester.ensureVisible(find.text('Background'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Background'));
    await tester.pumpAndSettle();

    // The switch is available immediately (§33.6).
    expect(find.text('Replace background'), findsOneWidget);

    // Enabling background replacement reveals tolerance + palette.
    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();

    // Required vs suggested distinction (§33.6).
    expect(find.text('Required'), findsWidgets);
    expect(find.text('Suggested'), findsWidgets);

    // The preview area now renders an actual processed image (§33.6).
    expect(find.byType(Image), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('adjust mode exposes sliders with numeric feedback',
      (tester) async {
    await _openEditor(tester);

    await tester.ensureVisible(find.text('Adjust'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Adjust'));
    await tester.pumpAndSettle();

    expect(find.byType(Slider), findsNWidgets(3));
    expect(find.text('0'), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('leaving with unsaved edits asks for confirmation (§34.1)',
      (tester) async {
    await _openEditor(tester);

    await tester.ensureVisible(find.text('Adjust'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Adjust'));
    await tester.pumpAndSettle();

    // Modify a parameter → the session now has unsaved edits.
    await tester.drag(find.byType(Slider).first, const Offset(40, 0));
    await tester.pumpAndSettle();

    await tester.pageBack();
    await tester.pumpAndSettle();

    expect(find.text('Discard changes?'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
    expect(find.text('Discard'), findsOneWidget);
  });
}
