import 'package:flutter/material.dart' show Locale;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/prefs/app_prefs.dart';

const _kLocale = 'locale';

/// Persisted app locale preference; `null` follows the device language.
class LocaleController extends Notifier<Locale?> {
  @override
  Locale? build() {
    final stored = ref.read(appPrefsProvider)?.getString(_kLocale);
    return stored == null || stored.isEmpty ? null : Locale(stored);
  }

  void setLocale(Locale? locale) {
    state = locale;
    final prefs = ref.read(appPrefsProvider);
    if (prefs != null) {
      prefs.setString(_kLocale, locale?.languageCode ?? '').ignore();
    }
  }

  /// Native display names of the supported languages, keyed by code.
  static const Map<String, String> languageNames = {
    'en': 'English',
    'ur': 'اردو',
    'hi': 'हिन्दी',
    'ar': 'العربية',
    'es': 'Español',
    'fr': 'Français',
    'de': 'Deutsch',
    'pt': 'Português',
    'id': 'Bahasa Indonesia',
    'tr': 'Türkçe',
    'ru': 'Русский',
    'bn': 'বাংলা',
    'fa': 'فارسی',
    'zh': '中文（简体）',
    'ja': '日本語',
  };
}

final localeControllerProvider =
    NotifierProvider<LocaleController, Locale?>(LocaleController.new);
