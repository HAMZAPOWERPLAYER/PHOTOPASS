/// Print-sheet layout math (pure, unit-testable).
///
/// Positions are in millimetres relative to the sheet's top-left corner.
class PrintSheetLayout {
  const PrintSheetLayout({
    required this.sheetWidthMm,
    required this.sheetHeightMm,
    required this.photoWidthMm,
    required this.photoHeightMm,
    required this.columns,
    required this.rows,
    required this.positionsMm,
  });

  final double sheetWidthMm;
  final double sheetHeightMm;
  final double photoWidthMm;
  final double photoHeightMm;
  final int columns;
  final int rows;

  /// Top-left corner of each photo, in (x, y) millimetre pairs.
  final List<({double x, double y})> positionsMm;

  int get photoCount => positionsMm.length;

  /// Computes a centred grid of [photoCount] photos (or as many as fit).
  ///
  /// [marginMm] is the outer margin; [gapMm] the spacing between photos.
  factory PrintSheetLayout.grid({
    required double sheetWidthMm,
    required double sheetHeightMm,
    required double photoWidthMm,
    required double photoHeightMm,
    double marginMm = 3,
    double gapMm = 3,
    int? photoCount,
  }) {
    final columns = ((sheetWidthMm - 2 * marginMm + gapMm) / (photoWidthMm + gapMm)).floor();
    final rows = ((sheetHeightMm - 2 * marginMm + gapMm) / (photoHeightMm + gapMm)).floor();
    final maxCount = columns * rows;
    final count = photoCount == null
        ? maxCount
        : photoCount.clamp(0, maxCount);
    if (columns <= 0 || rows <= 0 || count == 0) {
      return PrintSheetLayout(
        sheetWidthMm: sheetWidthMm,
        sheetHeightMm: sheetHeightMm,
        photoWidthMm: photoWidthMm,
        photoHeightMm: photoHeightMm,
        columns: 0,
        rows: 0,
        positionsMm: const [],
      );
    }

    // Centre the used grid inside the sheet.
    final gridW = columns * photoWidthMm + (columns - 1) * gapMm;
    final gridH = rows * photoHeightMm + (rows - 1) * gapMm;
    final offsetX = (sheetWidthMm - gridW) / 2;
    final offsetY = (sheetHeightMm - gridH) / 2;

    final positions = <({double x, double y})>[];
    for (var i = 0; i < count; i++) {
      final col = i % columns;
      final row = i ~/ columns;
      positions.add((
        x: offsetX + col * (photoWidthMm + gapMm),
        y: offsetY + row * (photoHeightMm + gapMm),
      ));
    }

    return PrintSheetLayout(
      sheetWidthMm: sheetWidthMm,
      sheetHeightMm: sheetHeightMm,
      photoWidthMm: photoWidthMm,
      photoHeightMm: photoHeightMm,
      columns: columns,
      rows: rows,
      positionsMm: positions,
    );
  }
}

/// Standard consumer photo-paper sheets, in millimetres.
class SheetPreset {
  const SheetPreset(this.id, this.widthMm, this.heightMm);

  final String id;
  final double widthMm;
  final double heightMm;

  static const photo46 = SheetPreset('photo_4x6', 100, 150);
  static const a4 = SheetPreset('a4', 210, 297);

  static const all = [photo46, a4];
}
