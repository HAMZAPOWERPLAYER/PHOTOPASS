import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:photo_pass/app/app.dart';

void main() {
  testWidgets('onboarding shows and can be skipped to home', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: PhotoPassApp()),
    );
    await tester.pumpAndSettle();

    // First onboarding page: privacy promise.
    expect(find.text('Your photos never leave your phone'), findsOneWidget);

    // Skip goes straight to the home tab.
    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();

    expect(find.byType(NavigationBar), findsOneWidget);
  });
}
