import 'package:flutter/widgets.dart' show BuildContext, Curve, Cubic, MediaQuery;

/// Spacing, shape and motion tokens (design spec §32.4, §32.5, §35).
///
/// Layout code composes values from these scales instead of inventing
/// pixel constants per screen.
abstract final class AppSpacing {
  /// 4 px — micro spacing (icon-to-label).
  static const double xs = 4;

  /// 8 px — compact spacing (inside controls).
  static const double sm = 8;

  /// 12 px — component spacing.
  static const double md = 12;

  /// 16 px — standard screen padding and component padding.
  static const double lg = 16;

  /// 24 px — section spacing.
  static const double xl = 24;

  /// 32 px — major section spacing.
  static const double xxl = 32;

  /// 40–48 px — large visual separation.
  static const double xxxl = 40;
}

/// Corner-radius tokens.
abstract final class AppRadius {
  /// Small controls (chips, tags).
  static const double sm = 8;

  /// Inputs and buttons.
  static const double md = 12;

  /// Cards.
  static const double lg = 16;

  /// Large hero surfaces and sheets.
  static const double xl = 20;
}

/// Motion tokens (design spec §35).
///
/// All durations collapse to zero when the platform reports reduced motion —
/// see [AppMotion.of].
abstract final class AppDurations {
  /// Button press feedback.
  static const Duration quick = Duration(milliseconds: 140);

  /// Simple state changes (selection, toggles).
  static const Duration standard = Duration(milliseconds: 180);

  /// Screen transitions.
  static const Duration screen = Duration(milliseconds: 220);

  /// Larger contextual transitions (bottom sheets, panels).
  static const Duration slow = Duration(milliseconds: 300);
}

/// Easing curves shared across the app.
abstract final class AppCurves {
  /// Primary emphasis curve for purposeful motion.
  static const emphasized = _EmphasizedCurve();

  /// Standard gentle in-out for ordinary UI transitions.
  static const standard = _StandardCurve();
}

class _EmphasizedCurve extends Curve {
  const _EmphasizedCurve();

  @override
  double transformInternal(double t) => _emphasized.transform(t);
}

class _StandardCurve extends Curve {
  const _StandardCurve();

  @override
  double transformInternal(double t) => _standard.transform(t);
}

const _emphasized = Cubic(0.2, 0, 0, 1);
const _standard = Cubic(0.4, 0, 0.2, 1);

/// Motion resolver honouring the system reduced-motion preference.
///
/// Read tiered durations through this so every transition automatically
/// collapses to instant when the user enables "remove animations".
class AppMotion {
  const AppMotion._({required this.disabled});

  /// True when the platform asks the app to minimise motion.
  final bool disabled;

  /// Resolves the ambient motion preference.
  static AppMotion of(BuildContext context) =>
      AppMotion._(disabled: MediaQuery.disableAnimationsOf(context));

  Duration get quick => _scale(AppDurations.quick);
  Duration get standard => _scale(AppDurations.standard);
  Duration get screen => _scale(AppDurations.screen);
  Duration get slow => _scale(AppDurations.slow);

  Duration _scale(Duration base) => disabled ? Duration.zero : base;
}
