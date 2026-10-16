import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_spacing.dart';
import '../../../core/widgets/app_components.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../export/presentation/export_screen.dart';
import '../data/compliance_runner.dart';
import '../domain/compliance_engine.dart';

/// Checklist screen: honest pass/warn/fail per requirement with the measured
/// value and a concrete next step for warnings/failures (spec §33.7). Nothing
/// here blocks export — the checklist advises, and no government approval is
/// ever implied.
class ComplianceScreen extends ConsumerWidget {
  const ComplianceScreen({super.key});

  static const String route = '/compliance';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(complianceProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!state.running && state.report == null && !state.error) {
        ref.read(complianceProvider.notifier).evaluate();
      }
    });

    return Scaffold(
      appBar: AppBar(title: Text(l10n.complianceTitle)),
      body: _Body(state: state),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: AppButton(
            label: l10n.complianceContinue,
            icon: Icons.ios_share_outlined,
            expand: true,
            onPressed: state.report == null || state.running
                ? null
                : () => context.push(ExportScreen.route),
          ),
        ),
      ),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body({required this.state});

  final ComplianceState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    if (state.error) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline_rounded,
                size: 40,
                color: theme.colorScheme.error,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(l10n.errorGenericBody, textAlign: TextAlign.center),
              const SizedBox(height: AppSpacing.lg),
              AppButton(
                label: l10n.commonRetry,
                icon: Icons.refresh_rounded,
                onPressed: () =>
                    ref.read(complianceProvider.notifier).evaluate(),
              ),
            ],
          ),
        ),
      );
    }

    final report = state.report;
    if (report == null || state.running) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        Text(l10n.complianceIntro, style: theme.textTheme.bodyMedium),
        const SizedBox(height: AppSpacing.lg),
        for (final check in report.checks)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: StatusTile(
              status: _appStatus(check.status),
              title: _titleFor(l10n, check),
              detail: _detailFor(l10n, check),
              measured: _measuredFor(l10n, check),
              actionText: _actionFor(l10n, check),
            ),
          ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          l10n.disclaimer,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  AppStatus _appStatus(CheckStatus status) => switch (status) {
    CheckStatus.pass => AppStatus.pass,
    CheckStatus.warn => AppStatus.warn,
    CheckStatus.fail => AppStatus.fail,
    CheckStatus.info => AppStatus.info,
  };

  String _titleFor(AppLocalizations l10n, ComplianceCheck check) =>
      switch (check.id) {
        'dimensions' => l10n.complianceDimensions,
        'face' => l10n.complianceFace,
        'headHeight' => l10n.complianceHeadHeight,
        'eyeLine' => l10n.complianceEyeLine,
        'background' => l10n.complianceBackground,
        'glasses' => l10n.complianceGlasses,
        'fileSize' => l10n.complianceFileSize,
        _ => check.id,
      };

  String _detailFor(AppLocalizations l10n, ComplianceCheck check) {
    final measured = check.measured;
    if (check.id == 'glasses' && measured != null) {
      return measured == 'compliance_glasses_allowed'
          ? l10n.complianceGlassesAllowed
          : l10n.complianceGlassesForbidden;
    }
    return switch (check.id) {
      'dimensions' => l10n.complianceDimensionsDetail,
      'face' => l10n.complianceFaceDetail,
      'headHeight' => l10n.complianceHeadHeightDetail,
      'eyeLine' => l10n.complianceEyeLineDetail,
      'background' => l10n.complianceBackgroundDetail,
      'fileSize' => l10n.complianceFileSizeDetail,
      _ => '',
    };
  }

  String? _measuredFor(AppLocalizations l10n, ComplianceCheck check) {
    final measured = check.measured;
    if (measured == null || check.id == 'glasses') return null;
    return '${l10n.complianceMeasured}: $measured';
  }

  /// Guidance for warnings/failures: what the user can do next (§33.7).
  String? _actionFor(AppLocalizations l10n, ComplianceCheck check) {
    if (check.status == CheckStatus.pass || check.status == CheckStatus.info) {
      return null;
    }
    return switch (check.id) {
      'background' => check.status == CheckStatus.warn
          ? l10n.complianceActionRetake
          : l10n.complianceActionBackground,
      'dimensions' => l10n.complianceActionDimensions,
      'fileSize' => l10n.complianceActionFilesize,
      'face' || 'headHeight' || 'eyeLine' => l10n.complianceActionCenter,
      _ => null,
    };
  }
}
