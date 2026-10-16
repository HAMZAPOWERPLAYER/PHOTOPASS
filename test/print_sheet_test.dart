import 'package:flutter_test/flutter_test.dart';
import 'package:photo_pass/features/export/domain/print_sheet.dart';

void main() {
  group('PrintSheetLayout.grid', () {
    test('fits 35×45mm photos on a 10×15cm sheet', () {
      final layout = PrintSheetLayout.grid(
        sheetWidthMm: 100,
        sheetHeightMm: 150,
        photoWidthMm: 35,
        photoHeightMm: 45,
      );
      // columns: (100 - 6 + 3) / 38 = 2 ; rows: (150 - 6 + 3) / 48 = 3
      expect(layout.columns, 2);
      expect(layout.rows, 3);
      expect(layout.photoCount, 6);
    });

    test('fits 35×45mm photos on A4', () {
      final layout = PrintSheetLayout.grid(
        sheetWidthMm: 210,
        sheetHeightMm: 297,
        photoWidthMm: 35,
        photoHeightMm: 45,
      );
      expect(layout.columns, 5);
      expect(layout.rows, 6);
      expect(layout.photoCount, 30);
    });

    test('honours an explicit photo count', () {
      final layout = PrintSheetLayout.grid(
        sheetWidthMm: 100,
        sheetHeightMm: 150,
        photoWidthMm: 35,
        photoHeightMm: 45,
        photoCount: 4,
      );
      expect(layout.photoCount, 4);
    });

    test('every photo stays inside the sheet', () {
      final layout = PrintSheetLayout.grid(
        sheetWidthMm: 210,
        sheetHeightMm: 297,
        photoWidthMm: 35,
        photoHeightMm: 45,
      );
      for (final position in layout.positionsMm) {
        expect(position.x, greaterThanOrEqualTo(0));
        expect(position.y, greaterThanOrEqualTo(0));
        expect(position.x + 35, lessThanOrEqualTo(210));
        expect(position.y + 45, lessThanOrEqualTo(297));
      }
    });

    test('photos do not overlap', () {
      final layout = PrintSheetLayout.grid(
        sheetWidthMm: 100,
        sheetHeightMm: 150,
        photoWidthMm: 35,
        photoHeightMm: 45,
      );
      for (var i = 0; i < layout.photoCount; i++) {
        for (var j = i + 1; j < layout.photoCount; j++) {
          final a = layout.positionsMm[i];
          final b = layout.positionsMm[j];
          final overlapX = a.x < b.x + 35 && b.x < a.x + 35;
          final overlapY = a.y < b.y + 45 && b.y < a.y + 45;
          expect(overlapX && overlapY, isFalse, reason: 'photos $i and $j overlap');
        }
      }
    });

    test('returns an empty layout when the photo cannot fit', () {
      final layout = PrintSheetLayout.grid(
        sheetWidthMm: 10,
        sheetHeightMm: 10,
        photoWidthMm: 35,
        photoHeightMm: 45,
      );
      expect(layout.photoCount, 0);
      expect(layout.columns, 0);
    });
  });
}
