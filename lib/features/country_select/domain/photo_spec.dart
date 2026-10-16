import 'dart:convert';

/// Domain model for a country/document photo specification.
///
/// Every field maps 1:1 to an entry in `assets/presets/photo_specs.json`.
/// Values must come from official government sources — see the preset
/// database policy in docs/product_policy.md.
class PhotoSpec {
  const PhotoSpec({
    required this.id,
    required this.countryCode,
    required this.documentType,
    required this.displayNameKey,
    required this.widthMm,
    required this.heightMm,
    required this.dpi,
    required this.backgroundHex,
    required this.fileFormats,
    required this.glassesAllowed,
    required this.sourceUrl,
    required this.lastVerified,
    required this.verified,
    this.minPx,
    this.maxPx,
    this.headHeightMinPct,
    this.headHeightMaxPct,
    this.eyeLineMinPct,
    this.eyeLineMaxPct,
    this.maxFileSizeKb,
    this.notes,
  });

  factory PhotoSpec.fromJson(Map<String, dynamic> json) {
    final id = _requireString(json, 'id');
    try {
      return PhotoSpec(
        id: id,
        countryCode: _requireString(json, 'countryCode'),
        documentType: DocumentType.fromWireName(
          _requireString(json, 'documentType'),
        ),
        displayNameKey: _requireString(json, 'displayNameKey'),
        widthMm: _requireNum(json, 'widthMm').toDouble(),
        heightMm: _requireNum(json, 'heightMm').toDouble(),
        minPx: _optionalInt(json, 'minPx'),
        maxPx: _optionalInt(json, 'maxPx'),
        dpi: _requireNum(json, 'dpi').round(),
        backgroundHex: _requireString(json, 'backgroundHex'),
        headHeightMinPct: _optionalNum(json, 'headHeightMinPct')?.toDouble(),
        headHeightMaxPct: _optionalNum(json, 'headHeightMaxPct')?.toDouble(),
        eyeLineMinPct: _optionalNum(json, 'eyeLineMinPct')?.toDouble(),
        eyeLineMaxPct: _optionalNum(json, 'eyeLineMaxPct')?.toDouble(),
        maxFileSizeKb: _optionalInt(json, 'maxFileSizeKb'),
        fileFormats: (json['fileFormats'] as List<Object?>)
            .map((value) => value! as String)
            .toList(growable: false),
        glassesAllowed: json['glassesAllowed']! as bool,
        notes: json['notes'] as String?,
        sourceUrl: _requireString(json, 'sourceUrl'),
        lastVerified: _requireString(json, 'lastVerified'),
        verified: json['verified']! as bool,
      );
    } on TypeError catch (error) {
      throw FormatException('Spec "$id" has invalid field types: $error');
    }
  }

  /// Stable identifier, e.g. `us_passport`.
  final String id;

  /// ISO 3166-1 alpha-2 code.
  final String countryCode;

  final DocumentType documentType;

  /// Localization key for the human-readable spec name.
  final String displayNameKey;

  final double widthMm;
  final double heightMm;

  /// Optional pixel constraints (applies to width; height follows aspect).
  final int? minPx;
  final int? maxPx;

  final int dpi;

  /// Required background colour as `#RRGGBB`.
  final String backgroundHex;

  /// Head height as % of photo height (bottom of chin to top of hair).
  final double? headHeightMinPct;
  final double? headHeightMaxPct;

  /// Eye line height as % of photo height, measured from the bottom.
  ///
  /// Official sources usually give a range; store min/max rather than a
  /// single value when only a range is specified.
  final double? eyeLineMinPct;
  final double? eyeLineMaxPct;

  /// Optional target file size limit for online portals.
  final int? maxFileSizeKb;

  final List<String> fileFormats;
  final bool glassesAllowed;
  final String? notes;

  /// Official government source this spec was taken from.
  final String sourceUrl;

  /// ISO date (yyyy-MM-dd) of the last verification against [sourceUrl].
  final String lastVerified;

  /// Whether [sourceUrl] confirmed every value here. Unverified specs must
  /// show an in-app notice and must never be presented as authoritative.
  final bool verified;

  /// Exact export width in pixels at [dpi].
  int get widthPx => _mmToPx(widthMm, dpi);

  /// Exact export height in pixels at [dpi].
  int get heightPx => _mmToPx(heightMm, dpi);

  /// Photo frame aspect ratio (width / height).
  double get frameAspect => widthMm / heightMm;

  /// Target head height as a fraction of photo height — midpoint of the
  /// official range, or the documented UI fallback (0.6) when the spec is
  /// silent (e.g. Schengen visas).
  double get targetHeadFraction {
    final min = headHeightMinPct;
    final max = headHeightMaxPct;
    if (min == null || max == null) return 0.6;
    return (min + max) / 2 / 100;
  }

  /// Target eye-line height from the bottom as a fraction of photo height —
  /// midpoint of the official range, or derived from the head height
  /// (crown 5% below the top, eyes 45% up the head) when unspecified.
  double get targetEyeFromBottom {
    final min = eyeLineMinPct;
    final max = eyeLineMaxPct;
    if (min != null && max != null) return (min + max) / 2 / 100;
    return 1 - 0.05 - 0.55 * targetHeadFraction;
  }

  static int _mmToPx(double mm, int dpi) => (mm / 25.4 * dpi).round();

  static String _requireString(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value is! String || value.isEmpty) {
      throw FormatException('Missing or empty "$key"');
    }
    return value;
  }

  static num _requireNum(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value is! num) {
      throw FormatException('Missing "$key"');
    }
    return value;
  }

  static num? _optionalNum(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value == null) return null;
    if (value is! num) {
      throw FormatException('"$key" must be a number or null');
    }
    return value;
  }

  static int? _optionalInt(Map<String, dynamic> json, String key) {
    final value = _optionalNum(json, key);
    return value?.round();
  }

  static List<PhotoSpec> listFromJsonString(String source) {
    final dynamic decoded = jsonDecode(source);
    if (decoded is! Map<String, dynamic> || decoded['specs'] is! List) {
      throw const FormatException('Preset file must be an object with "specs"');
    }
    return (decoded['specs'] as List<Object?>)
        .map(
          (value) => PhotoSpec.fromJson(value! as Map<String, dynamic>),
        )
        .toList(growable: false);
  }

  static int schemaVersionFromJsonString(String source) {
    final dynamic decoded = jsonDecode(source);
    final version = (decoded as Map<String, dynamic>)['schemaVersion'];
    if (version is! int) {
      throw const FormatException('Preset file must declare "schemaVersion"');
    }
    return version;
  }
}

/// Document categories supported by the preset database.
enum DocumentType {
  passport('passport'),
  visa('visa'),
  idCard('id_card'),
  drivingLicence('driving_licence'),
  other('other');

  const DocumentType(this.wireName);

  /// Value used in the JSON preset file.
  final String wireName;

  static DocumentType fromWireName(String value) =>
      DocumentType.values.firstWhere(
        (type) => type.wireName == value,
        orElse: () =>
            throw FormatException('Unknown documentType "$value"'),
      );
}
