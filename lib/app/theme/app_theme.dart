import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_spacing.dart';
import 'app_typography.dart';

/// Material 3 themes built entirely from design tokens (spec §32).
///
/// Light and dark palettes come from [AppColors]; component themes use the
/// spacing/radius scales from [AppSpacing]/[AppRadius]. Feature widgets must
/// reference semantic roles (`theme.colorScheme.*`, `textTheme.*`) instead of
/// raw values.
abstract final class AppTheme {
  static ThemeData get light => _base(Brightness.light);

  static ThemeData get dark => _base(Brightness.dark);

  static ThemeData _base(Brightness brightness) {
    final isDark = brightness == Brightness.dark;

    final scheme = ColorScheme(
      brightness: brightness,
      primary: isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
      onPrimary: isDark ? AppColors.darkOnPrimary : AppColors.lightOnPrimary,
      primaryContainer:
          isDark ? AppColors.darkPrimaryContainer : AppColors.lightPrimaryContainer,
      onPrimaryContainer: isDark
          ? AppColors.darkOnPrimaryContainer
          : AppColors.lightOnPrimaryContainer,
      secondary: isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
      onSecondary: isDark ? AppColors.darkOnPrimary : AppColors.lightOnPrimary,
      secondaryContainer: isDark
          ? AppColors.darkPrimaryContainer
          : AppColors.lightPrimaryContainer,
      onSecondaryContainer: isDark
          ? AppColors.darkOnPrimaryContainer
          : AppColors.lightOnPrimaryContainer,
      tertiary: isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
      onTertiary: isDark ? AppColors.darkOnPrimary : AppColors.lightOnPrimary,
      tertiaryContainer: isDark
          ? AppColors.darkSurfaceElevated
          : AppColors.lightSurfaceElevated,
      onTertiaryContainer:
          isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface,
      error: isDark ? AppColors.statusOf(brightness).error : AppColors.error,
      onError: isDark ? AppColors.errorContainerDark : AppColors.lightOnPrimary,
      errorContainer: isDark
          ? AppColors.statusOf(brightness).errorContainer
          : AppColors.errorContainerLight,
      onErrorContainer: isDark
          ? AppColors.statusOf(brightness).onErrorContainer
          : const Color(0xFF7A1622),
      surface: isDark ? AppColors.darkSurface : AppColors.lightSurface,
      onSurface: isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface,
      onSurfaceVariant: isDark
          ? AppColors.darkOnSurfaceVariant
          : AppColors.lightOnSurfaceVariant,
      surfaceContainerHighest: isDark
          ? AppColors.darkSurfaceElevated
          : AppColors.lightBackground,
      surfaceContainerHigh: isDark
          ? AppColors.darkSurfaceElevated
          : AppColors.lightBackground,
      surfaceContainerLow: isDark
          ? AppColors.darkSurfaceElevated
          : AppColors.lightBackground,
      surfaceContainer: isDark ? AppColors.darkSurface : AppColors.lightSurface,
      surfaceContainerLowest:
          isDark ? AppColors.darkSurface : AppColors.lightSurface,
      surfaceTint: isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
      outline: isDark ? AppColors.darkOutline : AppColors.lightOutline,
      outlineVariant: isDark ? AppColors.darkOutline : AppColors.lightOutline,
      shadow: const Color(0xFF000000),
      scrim: const Color(0xFF000000),
      inverseSurface: isDark
          ? AppColors.lightOnSurface
          : AppColors.darkOnSurface,
      onInverseSurface: isDark
          ? AppColors.lightSurface
          : AppColors.darkSurface,
      inversePrimary: isDark
          ? AppColors.lightPrimary
          : AppColors.darkPrimary,
    );

    final textTheme = AppTypography.textTheme(brightness);

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      textTheme: textTheme,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      splashFactory: InkSparkle.splashFactory,
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        foregroundColor: scheme.onSurface,
        titleTextStyle: textTheme.titleLarge?.copyWith(color: scheme.onSurface),
        iconTheme: IconThemeData(color: scheme.onSurface, size: 24),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: scheme.surface,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          side: BorderSide(color: scheme.outline),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(64, 52),
          textStyle: textTheme.labelLarge,
          foregroundColor: scheme.onPrimary,
          backgroundColor: scheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(64, 52),
          textStyle: textTheme.labelLarge,
          elevation: 0,
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(64, 52),
          textStyle: textTheme.labelLarge,
          foregroundColor: scheme.primary,
          side: BorderSide(color: scheme.outline),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: scheme.primary,
          textStyle: textTheme.labelLarge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
        ),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          textStyle: WidgetStatePropertyAll(textTheme.labelLarge),
          foregroundColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? scheme.onPrimaryContainer
                : scheme.onSurfaceVariant,
          ),
          backgroundColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? scheme.primaryContainer
                : scheme.surface,
          ),
          side: WidgetStatePropertyAll(BorderSide(color: scheme.outline)),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
          ),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: scheme.surface,
        elevation: 0,
        height: 72,
        indicatorColor: scheme.primaryContainer,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected)
                ? scheme.onPrimaryContainer
                : scheme.onSurfaceVariant,
          ),
        ),
        labelTextStyle: WidgetStatePropertyAll(
          textTheme.labelMedium ?? const TextStyle(),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surfaceContainerLow,
        hintStyle: textTheme.bodyLarge?.copyWith(
          color: scheme.onSurfaceVariant,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md + 2,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide(color: scheme.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide(color: scheme.error, width: 1.5),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: scheme.outline,
        space: 1,
        thickness: 1,
      ),
      dialogTheme: DialogThemeData(
        elevation: 0,
        backgroundColor: scheme.surfaceContainerHigh,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.xl),
        ),
        titleTextStyle: textTheme.titleLarge?.copyWith(color: scheme.onSurface),
        contentTextStyle:
            textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        elevation: 0,
        backgroundColor: scheme.surfaceContainerHigh,
        surfaceTintColor: Colors.transparent,
        showDragHandle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppRadius.xl),
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: isDark
            ? AppColors.darkSurfaceElevated
            : AppColors.lightOnSurface,
        contentTextStyle:
            textTheme.bodyMedium?.copyWith(color: isDark ? AppColors.darkOnSurface : AppColors.lightSurface),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: scheme.primary,
        linearTrackColor: scheme.surfaceContainerLow,
      ),
      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        iconColor: scheme.onSurfaceVariant,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.xs,
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: scheme.surfaceContainerLow,
        side: BorderSide(color: scheme.outline),
        labelStyle: textTheme.labelLarge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm + 4),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: scheme.onSurface,
        unselectedLabelColor: scheme.onSurfaceVariant,
        indicatorColor: scheme.primary,
        labelStyle: textTheme.titleSmall,
        unselectedLabelStyle: textTheme.titleSmall,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? scheme.onPrimary
              : scheme.surface,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? scheme.primary
              : scheme.surfaceContainerHighest,
        ),
      ),
    );
  }
}
