import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'core/prefs/app_prefs.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await AppPrefs.open();
  runApp(
    ProviderScope(
      overrides: [appPrefsProvider.overrideWithValue(prefs)],
      child: const PhotoPassApp(),
    ),
  );
}
