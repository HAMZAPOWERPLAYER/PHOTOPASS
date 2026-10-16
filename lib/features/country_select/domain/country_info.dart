/// Country metadata helpers: display names and flag emoji derived from
/// ISO 3166-1 alpha-2 codes. No assets or network needed.
///
/// Display names are English for now; localized names land in Phase 10 by
/// swapping [CountryInfo.nameOf] for an l10n lookup.
library;

abstract final class CountryInfo {
  /// English display names for countries present in the bundled presets.
  /// Extend alongside each new preset batch.
  static const Map<String, String> _names = {
    'US': 'United States',
    'GB': 'United Kingdom',
    'CA': 'Canada',
    'CN': 'China',
    'DE': 'Germany',
    'FR': 'France',
    'IT': 'Italy',
    'ES': 'Spain',
  };

  /// Display name for [countryCode], falling back to the raw code.
  static String nameOf(String countryCode) =>
      _names[countryCode.toUpperCase()] ?? countryCode.toUpperCase();

  /// Flag emoji for [countryCode] (regional indicator symbols).
  ///
  /// Returns an empty string for codes that are not two ASCII letters.
  static String flagOf(String countryCode) {
    final code = countryCode.toUpperCase();
    if (code.length != 2 || !RegExp(r'^[A-Z]{2}$').hasMatch(code)) return '';

    final base = 'A'.codeUnitAt(0);
    return String.fromCharCodes(
      code.codeUnits.map((unit) => 0x1F1E6 + unit - base),
    );
  }
}
