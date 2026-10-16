import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:photo_pass/app/app.dart';
import 'package:photo_pass/core/prefs/app_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Design spec §33.1/§32: onboarding completion and theme/language
/// preferences persist locally via SharedPreferences (never the network).
Future<void> pumpColdStart(WidgetTester tester) async {
  final prefs = await AppPrefs.open();
  await tester.pumpWidget(
    ProviderScope(
      overrides: [appPrefsProvider.overrideWithValue(prefs)],
      child: const PhotoPassApp(),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('skipping onboarding persists completion across restarts',
      (tester) async {
    await pumpColdStart(tester);

    // First run: onboarding shows its Skip action.
    expect(find.text('Skip'), findsOneWidget);
    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();
    expect(find.byType(NavigationBar), findsOneWidget);

    final store = await SharedPreferences.getInstance();
    expect(store.getBool('onboardingDone'), isTrue);

    // Simulate a cold start: fresh scope, same preferences store.
    await pumpColdStart(tester);
    expect(find.text('Skip'), findsNothing);
    expect(find.byType(NavigationBar), findsOneWidget);
  });

  testWidgets('theme choice persists across restarts', (tester) async {
    SharedPreferences.setMockInitialValues({'themeMode': 'dark'});

    await pumpColdStart(tester);

    final app = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(app.themeMode, ThemeMode.dark);
  });

  testWidgets('language choice persists across restarts', (tester) async {
    SharedPreferences.setMockInitialValues({'locale': 'ar'});

    await pumpColdStart(tester);

    final app = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(app.locale, const Locale('ar'));
  });

  testWidgets('changing the theme writes through to preferences',
      (tester) async {
    await pumpColdStart(tester);
    expect(find.text('Skip'), findsOneWidget);
    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.settings_outlined));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.dark_mode_outlined));
    await tester.pumpAndSettle();

    final store = await SharedPreferences.getInstance();
    expect(store.getString('themeMode'), 'dark');
  });
}
