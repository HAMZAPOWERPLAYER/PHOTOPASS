import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:photo_pass/app/app.dart';
import 'package:photo_pass/core/prefs/app_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Design spec §41: golden snapshots for the key screens in light, dark and
/// RTL configurations. Regenerate after intentional UI changes with:
///   flutter test --update-goldens test/goldens
Future<void> _pump(
  WidgetTester tester, {
  ThemeMode themeMode = ThemeMode.system,
  String? locale,
}) async {
  final values = <String, Object>{
    'onboardingDone': true,
    'themeMode': themeMode.name,
  };
  if (locale != null) values['locale'] = locale;
  SharedPreferences.setMockInitialValues(values);
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
  testWidgets('home — light', (tester) async {
    await _pump(tester, themeMode: ThemeMode.light);
    expect(find.byType(NavigationBar), findsOneWidget);
    await expectLater(
      find.byType(PhotoPassApp),
      matchesGoldenFile('goldens/home_light.png'),
    );
  });

  testWidgets('home — dark', (tester) async {
    await _pump(tester, themeMode: ThemeMode.dark);
    expect(find.byType(NavigationBar), findsOneWidget);
    await expectLater(
      find.byType(PhotoPassApp),
      matchesGoldenFile('goldens/home_dark.png'),
    );
  });

  testWidgets('home — Arabic RTL', (tester) async {
    await _pump(tester, themeMode: ThemeMode.light, locale: 'ar');
    expect(find.byType(NavigationBar), findsOneWidget);
    await expectLater(
      find.byType(PhotoPassApp),
      matchesGoldenFile('goldens/home_rtl.png'),
    );
  });

  testWidgets('settings — light', (tester) async {
    await _pump(tester, themeMode: ThemeMode.light);
    await tester.tap(find.byIcon(Icons.settings_outlined));
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(PhotoPassApp),
      matchesGoldenFile('goldens/settings_light.png'),
    );
  });
}
