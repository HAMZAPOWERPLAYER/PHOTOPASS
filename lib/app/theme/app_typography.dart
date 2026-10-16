import 'package:flutter/material.dart'
    show Brightness, Color, FontWeight, TextTheme, TextStyle;

import 'app_colors.dart';

/// Type-scale tokens (design spec §32.3).
///
/// Exposed as a Material [TextTheme] so every widget can read roles through
/// `Theme.of(context).textTheme`. Sizes assume the default Roboto/Noto system
/// font and scale with the user's font-size setting.
abstract final class AppTypography {
  /// Builds the role-mapped text theme for the given brightness.
  static TextTheme textTheme(Brightness brightness) {
    final Color primary;
    final Color secondary;
    if (brightness == Brightness.dark) {
      primary = AppColors.darkOnSurface;
      secondary = AppColors.darkOnSurfaceVariant;
    } else {
      primary = AppColors.lightOnSurface;
      secondary = AppColors.lightOnSurfaceVariant;
    }

    TextStyle base(double size, double height, int weight, {double? spacing}) =>
        TextStyle(
          fontSize: size,
          height: height / size,
          fontWeight: weight == 500
              ? FontWeight.w500
              : weight == 600
                  ? FontWeight.w600
                  : FontWeight.w400,
          letterSpacing: spacing ?? 0,
          color: primary,
        );

    return TextTheme(
      // Display & hero headings.
      displayLarge: base(32, 40, 600),
      displayMedium: base(28, 36, 600),
      // Screen titles.
      headlineMedium: base(24, 32, 600),
      // Section headings.
      headlineSmall: base(20, 28, 600),
      // Card titles / toolbar titles.
      titleLarge: base(20, 28, 600),
      titleMedium: base(16, 24, 600),
      titleSmall: base(14, 20, 600, spacing: .1),
      // Body text.
      bodyLarge: base(16, 24, 400),
      // Secondary descriptions.
      bodyMedium: base(14, 20, 400),
      // Captions & fine print.
      bodySmall: base(12, 16, 400),
      // Buttons and labels.
      labelLarge: base(15, 20, 600, spacing: .1),
      labelMedium: base(12, 16, 500, spacing: .2),
      labelSmall: base(11, 16, 500, spacing: .2),
    ).apply(
      bodyColor: primary,
      displayColor: primary,
      // Secondary roles inherit through copyWith in components; keeping the
      // palette mapping here lets callers swap colours per context.
      decorationColor: secondary,
    );
  }

  /// Technical measurement style (pixel sizes, mm, DPI values).
  ///
  /// Tabular figures keep numeric columns aligned in compliance rows.
  static TextStyle technical(TextTheme theme, Brightness brightness) {
    final role = theme.bodyMedium;
    return (role ?? const TextStyle()).copyWith(
      fontWeight: FontWeight.w500,
      letterSpacing: .2,
      color: brightness == Brightness.dark
          ? AppColors.darkOnSurfaceVariant
          : AppColors.lightOnSurfaceVariant,
    );
  }
}
