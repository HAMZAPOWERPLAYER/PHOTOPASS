import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/flow/user_data_controller.dart';
import '../../../app/locale_controller.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/widgets/app_components.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../country_select/presentation/home_screen.dart';

/// Onboarding: privacy promise, how it works, language choice (spec §33.1).
///
/// Three concise pages, skippable, no permissions requested, and completion
/// is persisted so it never shows again unnecessarily.
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  static const String route = '/onboarding';

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _pageController = PageController();
  int _page = 0;

  static const _pageCount = 3;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _finish() {
    ref.read(onboardingDoneProvider.notifier).complete();
    context.go(HomeScreen.route);
  }

  void _goTo(int page) => _pageController.animateToPage(
    page,
    duration: AppDurations.slow,
    curve: AppCurves.emphasized,
  );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final motion = AppMotion.of(context);
    final isLast = _page == _pageCount - 1;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.sm),
                child: TextButton(
                  onPressed: _finish,
                  child: Text(l10n.commonSkip),
                ),
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (page) => setState(() => _page = page),
                children: [
                  _InfoPage(
                    icon: Icons.lock_person_outlined,
                    title: l10n.onboardingPrivacyTitle,
                    body: l10n.onboardingPrivacyBody,
                  ),
                  _InfoPage(
                    icon: Icons.badge_outlined,
                    title: l10n.onboardingHowTitle,
                    body: l10n.onboardingHowBody,
                  ),
                  const _LanguagePage(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Row(
                children: [
                  for (var i = 0; i < _pageCount; i++)
                    AnimatedContainer(
                      duration: motion.standard,
                      margin: const EdgeInsetsDirectional.only(end: AppSpacing.sm),
                      width: i == _page ? 24 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: i == _page
                            ? scheme.primary
                            : scheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  const Spacer(),
                  AppButton(
                    label: isLast ? l10n.commonStart : l10n.commonContinue,
                    onPressed: isLast ? _finish : () => _goTo(_page + 1),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoPage extends StatelessWidget {
  const _InfoPage({required this.icon, required this.title, required this.body});

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.xxl),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.sizeOf(context).height * .55,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 112,
              height: 112,
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 52,
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
            Text(
              title,
              style: theme.textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              body,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// Lets the user pick one of the supported languages (or device default).
class _LanguagePage extends ConsumerWidget {
  const _LanguagePage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final selected = ref.watch(localeControllerProvider);
    final controller = ref.read(localeControllerProvider.notifier);

    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.sm,
      ),
      children: [
        Text(
          l10n.onboardingLanguageTitle,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: AppSpacing.md),
        // Device default first, then every supported language by endonym.
        for (final locale in const [null, ...AppLocalizations.supportedLocales])
          ListTile(
            title: Text(
              locale == null
                  ? l10n.settingsThemeSystem
                  : LocaleController.languageNames[locale.toLanguageTag()] ??
                        locale.toLanguageTag(),
            ),
            trailing: selected == locale
                ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary)
                : null,
            onTap: () => controller.setLocale(locale),
          ),
      ],
    );
  }
}
