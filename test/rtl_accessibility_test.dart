import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:photo_pass/app/app.dart';
import 'package:photo_pass/app/locale_controller.dart';

/// Phase 10: RTL rendering (Arabic) and accessibility semantics.
void main() {
  Future<void> pumpApp(WidgetTester tester, {Locale? locale}) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          if (locale != null)
            localeControllerProvider.overrideWith(() => _FixedLocale(locale)),
        ],
        child: const PhotoPassApp(),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('Arabic renders with right-to-left directionality', (tester) async {
    await pumpApp(tester, locale: const Locale('ar'));

    final directionality =
        tester.widget<Directionality>(find.byType(Directionality).first);
    expect(directionality.textDirection, TextDirection.rtl);

    // Onboarding is in Arabic; skip to the shell and check nav labels.
    final onboardingTitle = tester.widgetList<Text>(find.byType(Text));
    expect(
      onboardingTitle.map((t) => t.data).whereType<String>().any((v) => v.isNotEmpty),
      isTrue,
    );
    await tester.tap(find.text('تخطٍ').hitTestable());
    await tester.pumpAndSettle();

    expect(find.text('الرئيسية'), findsOneWidget);
    expect(find.text('الإعدادات'), findsOneWidget);
  });

  testWidgets('Persian onboarding renders RTL with translated copy',
      (tester) async {
    await pumpApp(tester, locale: const Locale('fa'));

    final directionality =
        tester.widget<Directionality>(find.byType(Directionality).first);
    expect(directionality.textDirection, TextDirection.rtl);

    // Onboarding privacy title differs from English and is non-empty.
    final texts = tester.widgetList<Text>(find.byType(Text)).map((t) => t.data);
    expect(texts.whereType<String>().any((value) => value.isNotEmpty), isTrue);
    expect(texts, isNot(contains('Your photos never leave your phone')));
  });

  testWidgets('navigation destinations expose localized semantics',
      (tester) async {
    final handle = tester.ensureSemantics();
    await pumpApp(tester);
    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();

    expect(find.bySemanticsLabel(RegExp('Home')), findsWidgets);
    expect(find.bySemanticsLabel(RegExp('History')), findsWidgets);
    expect(find.bySemanticsLabel(RegExp('Settings')), findsWidgets);
    handle.dispose();
  });

  testWidgets('icon buttons carry tooltips for screen readers', (tester) async {
    await pumpApp(tester);
    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();

    // Every IconButton rendered on the home tab has an accessible name.
    final buttons = tester.widgetList<IconButton>(find.byType(IconButton));
    for (final button in buttons) {
      expect(button.tooltip, isNotNull,
          reason: 'IconButton without tooltip/semantic label');
    }
  });

  testWidgets('language picker lists every supported language by native name',
      (tester) async {
    expect(LocaleController.languageNames.length, 15);
    expect(LocaleController.languageNames['ur'], 'اردو');
    expect(LocaleController.languageNames['ja'], '日本語');
    expect(LocaleController.languageNames['zh'], '中文（简体）');
  });

  testWidgets('primary action buttons meet the 48dp touch target minimum',
      (tester) async {
    await pumpApp(tester);

    final buttons = find.byType(FilledButton);
    expect(buttons, findsWidgets);
    for (final element in buttons.evaluate()) {
      final size = tester.getSize(find.byWidget(element.widget));
      expect(size.height, greaterThanOrEqualTo(48),
          reason: 'FilledButton touch target is ${size.height}px high');
    }
  });
}

class _FixedLocale extends LocaleController {
  _FixedLocale(this.value);
  final Locale value;
  @override
  Locale? build() => value;
}
