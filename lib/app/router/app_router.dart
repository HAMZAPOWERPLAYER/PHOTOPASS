import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_pass/app/shell/app_shell.dart';

import '../../features/capture/presentation/capture_screen.dart';
import '../../features/compliance/presentation/compliance_screen.dart';
import '../../features/country_select/presentation/country_select_screen.dart';
import '../../features/country_select/presentation/home_screen.dart';
import '../../features/country_select/presentation/spec_details_screen.dart';
import '../../features/editor/presentation/editor_screen.dart';
import '../../features/export/presentation/export_screen.dart';
import '../../features/history/presentation/history_screen.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../flow/user_data_controller.dart';
import '../theme/app_spacing.dart';

/// Navigator for full-screen flows pushed above the bottom navigation shell.
final rootNavigatorKey = GlobalKey<NavigatorState>();

/// Shared page transition: modest fade + slide with the emphasized curve
/// (spec §35). Respects the system reduced-motion setting.
CustomTransitionPage<void> appPage({
  required Widget child,
  required GoRouterState state,
}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    transitionDuration: AppDurations.screen,
    reverseTransitionDuration: AppDurations.screen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      if (MediaQuery.disableAnimationsOf(context)) return child;
      final curved = CurvedAnimation(
        parent: animation,
        curve: AppCurves.emphasized,
      );
      return FadeTransition(
        opacity: curved,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, .015),
            end: Offset.zero,
          ).animate(curved),
          child: child,
        ),
      );
    },
    child: child,
  );
}

/// All app routes. Full-screen flows (capture, editor, export, …) are pushed
/// on the root navigator so they cover the navigation bar; the three tabs
/// live inside a [StatefulShellRoute].
final appRouterProvider = Provider<GoRouter>((ref) {
  // Start on the home tab once onboarding has been completed (spec §33.1).
  final onboardingDone = ref.watch(onboardingDoneProvider);

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: onboardingDone ? HomeScreen.route : OnboardingScreen.route,
    routes: [
      GoRoute(
        path: OnboardingScreen.route,
        pageBuilder: (context, state) =>
            appPage(state: state, child: const OnboardingScreen()),
      ),
      GoRoute(
        path: CountrySelectScreen.route,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) =>
            appPage(state: state, child: const CountrySelectScreen()),
      ),
      GoRoute(
        path: SpecDetailsScreen.route,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) => appPage(
          state: state,
          child: SpecDetailsScreen(
            countryCode: state.pathParameters['code'] ?? '',
          ),
        ),
      ),
      GoRoute(
        path: CaptureScreen.route,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) =>
            appPage(state: state, child: const CaptureScreen()),
      ),
      GoRoute(
        path: EditorScreen.route,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) =>
            appPage(state: state, child: const EditorScreen()),
      ),
      GoRoute(
        path: ComplianceScreen.route,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) =>
            appPage(state: state, child: const ComplianceScreen()),
      ),
      GoRoute(
        path: ExportScreen.route,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) =>
            appPage(state: state, child: const ExportScreen()),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: HomeScreen.route,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: HistoryScreen.route,
                builder: (context, state) => const HistoryScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: SettingsScreen.route,
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
