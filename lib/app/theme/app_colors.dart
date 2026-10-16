import 'package:flutter/material.dart' show Color, Brightness;

/// Design-token colour system for PhotoPass (design spec §32.2).
///
/// Feature widgets must reference semantic roles ([AppColors.of]) — never raw
/// hex values. Success/warning/error are also exposed with soft container
/// variants for badges and status rows.
abstract final class AppColors {
  // ---------------------------------------------------------------- light
  static const lightPrimary = Color(0xFF2457D6);
  static const lightOnPrimary = Color(0xFFFFFFFF);
  static const lightPrimaryContainer = Color(0xFFE8EEFF);
  static const lightOnPrimaryContainer = Color(0xFF10307E);
  static const lightBackground = Color(0xFFF7F8FC);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightSurfaceElevated = Color(0xFFFFFFFF);
  static const lightOnSurface = Color(0xFF151B2C);
  static const lightOnSurfaceVariant = Color(0xFF657087);
  static const lightOutline = Color(0xFFE2E6EF);
  static const lightOutlineStrong = Color(0xFFC9D0DE);

  // ----------------------------------------------------------------- dark
  static const darkPrimary = Color(0xFF8EACFF);
  static const darkOnPrimary = Color(0xFF0B1B3F);
  static const darkPrimaryContainer = Color(0xFF22345F);
  static const darkOnPrimaryContainer = Color(0xFFDCE6FF);
  static const darkBackground = Color(0xFF10131B);
  static const darkSurface = Color(0xFF191E29);
  static const darkSurfaceElevated = Color(0xFF222938);
  static const darkOnSurface = Color(0xFFF2F4FA);
  static const darkOnSurfaceVariant = Color(0xFFB0B9CB);
  static const darkOutline = Color(0xFF333B4B);
  static const darkOutlineStrong = Color(0xFF4A5468);

  // ------------------------------------------------------------- statuses
  /// Pass / success.
  static const success = Color(0xFF16794B);
  static const successContainerLight = Color(0xFFE1F3EA);
  static const successContainerDark = Color(0xFF173A2B);

  /// Warning.
  static const warning = Color(0xFF986000);
  static const warningContainerLight = Color(0xFFF9EDD8);
  static const warningContainerDark = Color(0xFF3A2C10);

  /// Failure / error.
  static const error = Color(0xFFB42332);
  static const errorContainerLight = Color(0xFFF9E4E7);
  static const errorContainerDark = Color(0xFF431A20);

  /// Neutral information (e.g. "not specified by the source").
  static const info = Color(0xFF35618E);
  static const infoContainerLight = Color(0xFFE4EEF7);
  static const infoContainerDark = Color(0xFF1B2C3F);

  /// Resolves the status colours for the active brightness.
  static AppStatusPalette statusOf(Brightness brightness) => brightness ==
          Brightness.dark
      ? const AppStatusPalette._(
          success: Color(0xFF57BE8C),
          successContainer: successContainerDark,
          onSuccessContainer: Color(0xFFB9E8D0),
          warning: Color(0xFFD9A441),
          warningContainer: warningContainerDark,
          onWarningContainer: Color(0xFFF3DDB6),
          error: Color(0xFFEF6B74),
          errorContainer: errorContainerDark,
          onErrorContainer: Color(0xFFF6C6CB),
          info: Color(0xFF8AB4DC),
          infoContainer: infoContainerDark,
          onInfoContainer: Color(0xFFC6DCF1),
        )
      : const AppStatusPalette._(
          success: success,
          successContainer: successContainerLight,
          onSuccessContainer: Color(0xFF0C4E30),
          warning: warning,
          warningContainer: warningContainerLight,
          onWarningContainer: Color(0xFF5E3B00),
          error: error,
          errorContainer: errorContainerLight,
          onErrorContainer: Color(0xFF7A1622),
          info: info,
          infoContainer: infoContainerLight,
          onInfoContainer: Color(0xFF234566),
        );
}

/// Status colour roles for pass/warn/fail/info states.
class AppStatusPalette {
  const AppStatusPalette._({
    required this.success,
    required this.successContainer,
    required this.onSuccessContainer,
    required this.warning,
    required this.warningContainer,
    required this.onWarningContainer,
    required this.error,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.info,
    required this.infoContainer,
    required this.onInfoContainer,
  });

  final Color success;
  final Color successContainer;
  final Color onSuccessContainer;
  final Color warning;
  final Color warningContainer;
  final Color onWarningContainer;
  final Color error;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color info;
  final Color infoContainer;
  final Color onInfoContainer;
}
