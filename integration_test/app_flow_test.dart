import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:photo_pass/app/app.dart';
import 'package:photo_pass/app/locale_controller.dart';

/// Phase 11 end-to-end flow: onboarding → home → country select → spec
/// details → history → settings → language switch (RTL) and back.
///
/// Camera capture is excluded (no camera in CI); the flow covers everything
/// reachable without hardware.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('full photo-selection flow with language switch', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: PhotoPassApp()),
    );
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // --- Onboarding ---------------------------------------------------------
    expect(find.text('Your photos never leave your phone'), findsOneWidget);
    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();

    // --- Home ---------------------------------------------------------------
    expect(find.text('Popular'), findsOneWidget);
    expect(find.text('Custom size'), findsOneWidget);

    // --- Country select via the Passport chip -------------------------------
    await tester.tap(find.text('Passport'));
    await tester.pumpAndSettle();

    expect(find.text('Country & document'), findsOneWidget);
    expect(find.text('United States'), findsOneWidget);

    // Search narrows the list.
    await tester.enterText(find.byType(TextField), 'germany');
    await tester.pumpAndSettle();
    expect(find.text('United States'), findsNothing);
    await tester.enterText(find.byType(TextField), '');
    await tester.pumpAndSettle();

    // --- Spec details -------------------------------------------------------
    await tester.tap(find.text('United States'));
    await tester.pumpAndSettle();

    expect(find.text('United States passport'), findsOneWidget);
    expect(find.text('Size'), findsOneWidget);
    expect(find.text('35 × 45 mm'), findsOneWidget);
    expect(find.text('Official source'), findsOneWidget);
    expect(find.text('Use this photo'), findsOneWidget);

    // Back to home.
    Navigator.of(tester.element(find.byType(Scaffold).first)).pop();
    await tester.pumpAndSettle();
    Navigator.of(tester.element(find.byType(Scaffold).first)).pop();
    await tester.pumpAndSettle();
    expect(find.text('Popular'), findsOneWidget);

    // --- History tab (empty state) ------------------------------------------
    await tester.tap(find.text('History'));
    await tester.pumpAndSettle();
    expect(find.text('No photos yet'), findsOneWidget);

    // --- Settings tab & language switch -------------------------------------
    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();
    expect(find.text('Privacy'), findsOneWidget);
    expect(find.text('Language'), findsOneWidget);

    await tester.tap(find.text('Language'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('العربية'));
    await tester.pumpAndSettle();

    // RTL takes effect: nav labels are Arabic now.
    expect(find.text('الرئيسية'), findsOneWidget);
    expect(
      tester
          .widget<Directionality>(find.byType(Directionality).first)
          .textDirection,
      TextDirection.rtl,
    );

    // Switch back to English.
    await tester.tap(find.text('اللغة'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();
    expect(find.text('Settings'), findsOneWidget);

    // Locale provider tracked the round trip.
    final container = ProviderScope.containerOf(
      tester.element(find.byType(MaterialApp)),
      listen: false,
    );
    expect(container.read(localeControllerProvider), const Locale('en'));
  });
}
