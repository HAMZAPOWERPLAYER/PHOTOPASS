import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:photo_pass/app/app.dart';
import 'package:photo_pass/core/prefs/app_prefs.dart';
import 'package:photo_pass/features/history/data/file_history_repository.dart';
import 'package:photo_pass/features/history/domain/history_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// In-memory history: the real repository awaits path_provider channels
/// that are unavailable under fake-async tests.
class _EmptyHistoryRepository implements HistoryRepository {
  const _EmptyHistoryRepository();

  @override
  Future<List<HistoryEntry>> list() async => const [];

  @override
  Future<void> add(HistoryEntry entry) async {}

  @override
  Future<void> remove(String id) async {}

  @override
  Future<void> clearAll() async {}
}

/// Design spec §33.1/§36: no layout must clip or overflow at 1.5× text
/// scaling on a small viewport. RenderFlex overflows throw in tests, so a
/// null [WidgetTester.takeException] is the assertion.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // In-memory preferences: AppPrefs.open() must never touch real channels.
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  Future<void> pumpColdStart(WidgetTester tester) async {
    final prefs = await AppPrefs.open();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appPrefsProvider.overrideWithValue(prefs),
          historyRepositoryProvider.overrideWithValue(
            const _EmptyHistoryRepository(),
          ),
        ],
        child: const PhotoPassApp(),
      ),
    );
    await tester.pumpAndSettle();
  }

  void configureSmallViewport(WidgetTester tester) {
    tester.view.physicalSize = const Size(640, 1136);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);
    tester.platformDispatcher.textScaleFactorTestValue = 1.5;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
  }

  testWidgets('onboarding + home render at 1.5× text scale without overflow',
      (tester) async {
    configureSmallViewport(tester);
    await pumpColdStart(tester);

    expect(tester.takeException(), isNull);

    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('settings + history tabs render at 1.5× text scale',
      (tester) async {
    configureSmallViewport(tester);
    await pumpColdStart(tester);
    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.settings_outlined));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);

    await tester.tap(find.byIcon(Icons.history_outlined));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  testWidgets('Arabic home renders at 1.5× text scale without overflow',
      (tester) async {
    configureSmallViewport(tester);
    SharedPreferences.setMockInitialValues({
      'onboardingDone': true,
      'locale': 'ar',
    });
    await pumpColdStart(tester);

    expect(find.byType(NavigationBar), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
