import 'package:flutter/material.dart' show ThemeMode;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/prefs/app_prefs.dart';

const _kThemeMode = 'themeMode';

/// Persisted app-wide theme mode preference.
class ThemeController extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    final stored = ref.read(appPrefsProvider)?.getString(_kThemeMode);
    return ThemeMode.values.asNameMap()[stored] ?? ThemeMode.system;
  }

  void setMode(ThemeMode mode) {
    state = mode;
    final prefs = ref.read(appPrefsProvider);
    if (prefs != null) {
      // Fire-and-forget: persistence must never block the UI.
      prefs.setString(_kThemeMode, mode.name).ignore();
    }
  }
}

final themeControllerProvider =
    NotifierProvider<ThemeController, ThemeMode>(ThemeController.new);
