import '../../../l10n/generated/app_localizations.dart';
import 'photo_spec.dart';

/// Localised display-name lookup shared by every screen that shows a spec.
extension SpecDisplayName on PhotoSpec {
  /// The translated document name (falls back to the raw id for specs added
  /// without a translation key).
  String displayName(AppLocalizations l10n) => switch (displayNameKey) {
    'spec_us_passport' => l10n.spec_us_passport,
    'spec_gb_passport' => l10n.spec_gb_passport,
    'spec_ca_passport' => l10n.spec_ca_passport,
    'spec_cn_visa' => l10n.spec_cn_visa,
    'spec_de_schengen_visa' => l10n.spec_de_schengen_visa,
    'spec_fr_schengen_visa' => l10n.spec_fr_schengen_visa,
    'spec_it_schengen_visa' => l10n.spec_it_schengen_visa,
    'spec_es_schengen_visa' => l10n.spec_es_schengen_visa,
    _ => id,
  };
}
