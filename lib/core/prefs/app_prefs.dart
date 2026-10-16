import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Thin wrapper over [SharedPreferences] with an injectable default.
///
/// The provider defaults to `null` so widget tests (and any context without
/// async initialization) keep working — controllers fall back to in-memory
/// behaviour when preferences are unavailable.
class AppPrefs {
  AppPrefs(this._sp);

  final SharedPreferences _sp;

  static Future<AppPrefs> open() async =>
      AppPrefs(await SharedPreferences.getInstance());

  bool? getBool(String key) => _sp.getBool(key);

  Future<void> setBool(String key, bool value) => _sp.setBool(key, value);

  String? getString(String key) => _sp.getString(key);

  Future<void> setString(String key, String value) => _sp.setString(key, value);

  List<String>? getStringList(String key) => _sp.getStringList(key);

  Future<void> setStringList(String key, List<String> value) =>
      _sp.setStringList(key, value);
}

/// Ambient preferences; overridden in `main()` with the real store.
final appPrefsProvider = Provider<AppPrefs?>((ref) => null);
