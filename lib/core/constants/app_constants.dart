/// App-wide constants.
abstract final class AppConstants {
  /// Product name, used in store metadata and about screens.
  static const String appName = 'PhotoPass';

  /// Current app version; must match `version:` in pubspec.yaml.
  static const String appVersion = '1.0.0+1';

  /// In-app disclaimer shown on Settings and Export (legal requirement).
  static const String photoSpecDisclaimer =
      'Requirements can change. Always check the official source. '
      'PhotoPass cannot guarantee acceptance.';
}
