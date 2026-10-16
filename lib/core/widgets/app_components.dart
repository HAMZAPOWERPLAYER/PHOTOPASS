import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';

// Reusable design-system components (spec §39, §41.3).
//
// Screens compose these instead of re-implementing buttons, empty states
// and status rows with drifting styles.

/// Visual severity of a status row (compliance checks, storage warnings…).
enum AppStatus { pass, warn, fail, info }

/// Semantic colour + icon + label mapping for [AppStatus].
class StatusPresentation {
  const StatusPresentation._({
    required this.color,
    required this.container,
    required this.onContainer,
    required this.icon,
  });

  final Color color;
  final Color container;
  final Color onContainer;
  final IconData icon;

  /// Resolves presentation for [status] in the ambient brightness.
  static StatusPresentation of(BuildContext context, AppStatus status) {
    final palette = AppStatusColors.of(context);
    return switch (status) {
      AppStatus.pass => StatusPresentation._(
          color: palette.success,
          container: palette.successContainer,
          onContainer: palette.onSuccessContainer,
          icon: Icons.check_circle_outline_rounded,
        ),
      AppStatus.warn => StatusPresentation._(
          color: palette.warning,
          container: palette.warningContainer,
          onContainer: palette.onWarningContainer,
          icon: Icons.warning_amber_rounded,
        ),
      AppStatus.fail => StatusPresentation._(
          color: palette.error,
          container: palette.errorContainer,
          onContainer: palette.onErrorContainer,
          icon: Icons.cancel_outlined,
        ),
      AppStatus.info => StatusPresentation._(
          color: palette.info,
          container: palette.infoContainer,
          onContainer: palette.onInfoContainer,
          icon: Icons.info_outline_rounded,
        ),
    };
  }
}

/// Convenience accessor for the active status palette.
abstract final class AppStatusColors {
  /// Resolves pass/warn/fail/info colours for the ambient brightness.
  static AppStatusPalette of(BuildContext context) =>
      AppColors.statusOf(Theme.of(context).brightness);
}

/// Consistent button component (spec §34.3).
///
/// Variants: primary (filled), secondary (outlined), destructive (error
/// filled) and text. All meet the 48 dp touch-target minimum and expose an
/// accessible label through their text.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.variant = AppButtonVariant.primary,
    this.expand = false,
    this.busy = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final AppButtonVariant variant;

  /// When true, fills the available horizontal space.
  final bool expand;

  /// Shows a spinner and blocks presses while an operation runs.
  final bool busy;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final enabled = onPressed != null && !busy;

    final child = busy
        ? SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: switch (variant) {
                AppButtonVariant.primary => theme.colorScheme.onPrimary,
                AppButtonVariant.destructive => theme.colorScheme.onErrorContainer,
                AppButtonVariant.secondary => theme.colorScheme.primary,
                AppButtonVariant.text => theme.colorScheme.primary,
              },
            ),
          )
        : Row(
            mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 20),
                const SizedBox(width: AppSpacing.sm),
              ],
              Flexible(child: Text(label)),
            ],
          );

    final onPressedHandler = enabled ? onPressed : null;

    final button = switch (variant) {
      AppButtonVariant.primary => FilledButton(
          onPressed: onPressedHandler,
          style: FilledButton.styleFrom(minimumSize: const Size(64, 52)),
          child: child,
        ),
      AppButtonVariant.secondary => OutlinedButton(
          onPressed: onPressedHandler,
          style: OutlinedButton.styleFrom(minimumSize: const Size(64, 52)),
          child: child,
        ),
      AppButtonVariant.destructive => FilledButton(
          onPressed: onPressedHandler,
          style: FilledButton.styleFrom(
            backgroundColor: theme.colorScheme.errorContainer,
            foregroundColor: theme.colorScheme.onErrorContainer,
            minimumSize: const Size(64, 52),
          ),
          child: child,
        ),
      AppButtonVariant.text => TextButton(
          onPressed: onPressedHandler,
          child: child,
        ),
    };

    return button;
  }
}

enum AppButtonVariant { primary, secondary, destructive, text }

/// Section heading with an optional trailing action (spec §32.3, §33.2).
class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title, this.action});

  final String title;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              title,
              style: theme.textTheme.titleMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ?action,
        ],
      ),
    );
  }
}

/// Polished empty state (spec §39.2): explains why content is missing and
/// offers the next useful action. Never fabricates example data.
class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.body,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String title;
  final String body;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      // Scrollable so enlarged accessibility text never clips (§40.2).
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    size: 34,
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  title,
                  style: theme.textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  body,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
                if (actionLabel != null) ...[
                  const SizedBox(height: AppSpacing.xl),
                  AppButton(
                    label: actionLabel!,
                    onPressed: onAction,
                    icon: Icons.add_a_photo_outlined,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Status row with icon, label and explanation (spec §33.7, §40.4 —
/// status is never communicated by colour alone).
class StatusTile extends StatelessWidget {
  const StatusTile({
    super.key,
    required this.status,
    required this.title,
    required this.detail,
    this.actionText,
    this.measured,
  });

  final AppStatus status;
  final String title;
  final String detail;

  /// Guidance shown for warnings/failures ("what the user can do next").
  final String? actionText;

  /// Optional technical measurement rendered in monospace-ish style.
  final String? measured;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final presentation = StatusPresentation.of(context, status);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: presentation.container.withValues(alpha: .55),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: presentation.color.withValues(alpha: .35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(presentation.icon, color: presentation.color, size: 22),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(title, style: theme.textTheme.titleSmall),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Padding(
            padding: const EdgeInsets.only(left: 34),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  detail,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                if (measured != null) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    measured!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: presentation.onContainer,
                    ),
                  ),
                ],
                if (actionText != null) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    actionText!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: presentation.color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Static skeleton block for loading layouts (spec §39.1).
class SkeletonBox extends StatelessWidget {
  const SkeletonBox({
    super.key,
    this.width,
    this.height = 16,
    this.radius = AppRadius.sm,
  });

  final double? width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
