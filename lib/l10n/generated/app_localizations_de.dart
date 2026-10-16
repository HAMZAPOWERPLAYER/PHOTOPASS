// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'PhotoPass';

  @override
  String get navHome => 'Start';

  @override
  String get navHistory => 'Verlauf';

  @override
  String get navSettings => 'Einstellungen';

  @override
  String get onboardingPrivacyTitle => 'Ihre Fotos verlassen Ihr Handy nie';

  @override
  String get onboardingPrivacyBody =>
      'PhotoPass erkennt Gesichter, entfernt den Hintergrund und exportiert Ihr Foto vollständig auf Ihrem Gerät. Kein Konto, kein Cloud-Upload und keine Analyse Ihrer Bilder.';

  @override
  String get onboardingHowTitle => 'Drei einfache Schritte';

  @override
  String get onboardingHowBody =>
      'Wählen Sie Ihr Land und den Dokumenttyp, nehmen Sie ein Foto auf oder wählen Sie eines aus und exportieren Sie dann ein konformes, druckfertiges Bild.';

  @override
  String get onboardingLanguageTitle => 'Sprache wählen';

  @override
  String get commonContinue => 'Weiter';

  @override
  String get commonSkip => 'Überspringen';

  @override
  String get commonStart => 'Loslegen';

  @override
  String get commonBack => 'Zurück';

  @override
  String get commonCancel => 'Abbrechen';

  @override
  String get commonRetry => 'Erneut versuchen';

  @override
  String get commonClose => 'Schließen';

  @override
  String get errorGenericTitle => 'Etwas ist schief gelaufen';

  @override
  String get errorGenericBody => 'Bitte versuchen Sie es erneut.';

  @override
  String get placeholderBody =>
      'Dieser Bildschirm folgt in einer späteren Build-Phase.';

  @override
  String get homeSearchHint => 'Land oder Dokument suchen';

  @override
  String get homePopularTitle => 'Beliebt';

  @override
  String get homePassport => 'Reisepass';

  @override
  String get homeVisa => 'Visum';

  @override
  String get homeIdCard => 'Ausweis';

  @override
  String get homeCustomSize => 'Benutzerdefinierte Größe';

  @override
  String get historyEmptyTitle => 'Noch keine Fotos';

  @override
  String get historyEmptyBody =>
      'Die Fotos, die Sie erstellen, erscheinen hier.';

  @override
  String get countrySelectTitle => 'Land und Dokument';

  @override
  String get countrySearchHint => 'Land suchen';

  @override
  String get countryNoResults => 'Keine passenden Länder';

  @override
  String countryDocumentsCount(int count) {
    return '$count Dokumente';
  }

  @override
  String get specSizeLabel => 'Größe';

  @override
  String get specBackgroundLabel => 'Hintergrund';

  @override
  String get specDpiLabel => 'Auflösung';

  @override
  String get specFormatsLabel => 'Formate';

  @override
  String get specHeadHeightLabel => 'Kopfhöhe';

  @override
  String get specEyeLineLabel => 'Augenhöhe vom unteren Rand';

  @override
  String get specGlassesAllowed => 'Brille erlaubt';

  @override
  String get specGlassesNotAllowed => 'Brille nicht erlaubt';

  @override
  String get specMaxFileSizeLabel => 'Maximale Dateigröße';

  @override
  String get specVerifiedBadge => 'Geprüft';

  @override
  String get specUnverifiedBadge => 'Nicht geprüft';

  @override
  String get specUnverifiedNotice =>
      'Bitte bestätigen Sie dies bei der offiziellen Quelle.';

  @override
  String get specOfficialSource => 'Offizielle Quelle';

  @override
  String specLastVerified(String date) {
    return 'Zuletzt geprüft: $date';
  }

  @override
  String get specUsePhoto => 'Dieses Foto verwenden';

  @override
  String get specNotSpecified => 'Nicht angegeben';

  @override
  String get spec_us_passport => 'US-amerikanischer Reisepass';

  @override
  String get spec_gb_passport => 'Reisepass des Vereinigten Königreichs';

  @override
  String get spec_ca_passport => 'Kanadischer Reisepass';

  @override
  String get spec_cn_visa => 'Chinesisches Visum';

  @override
  String get spec_de_schengen_visa => 'Deutschland — Schengen-Visum';

  @override
  String get spec_fr_schengen_visa => 'Frankreich — Schengen-Visum';

  @override
  String get spec_it_schengen_visa => 'Italien — Schengen-Visum';

  @override
  String get spec_es_schengen_visa => 'Spanien — Schengen-Visum';

  @override
  String get captureTitle => 'Foto aufnehmen';

  @override
  String get captureRationaleTitle => 'Kamerazugriff erforderlich';

  @override
  String get captureRationaleBody =>
      'PhotoPass verwendet Ihre Kamera, um ein Passfoto zu erstellen. Das Foto bleibt auf Ihrem Handy und wird nie hochgeladen.';

  @override
  String get captureRationaleDenied =>
      'Der Kamerazugriff ist deaktiviert. Aktivieren Sie ihn in den Systemeinstellungen, um ein Foto aufzunehmen, oder wählen Sie eines aus Ihrer Galerie aus.';

  @override
  String get captureRationaleAction => 'Kamera zulassen';

  @override
  String get captureOpenSettings => 'Einstellungen öffnen';

  @override
  String get captureCameraError =>
      'Die Kamera konnte nicht gestartet werden. Sie können weiterhin ein Foto aus Ihrer Galerie auswählen.';

  @override
  String get captureHintFace =>
      'Positionieren Sie Ihr Gesicht innerhalb des Ovals';

  @override
  String get captureSwitchCamera => 'Kamera wechseln';

  @override
  String get captureGallery => 'Aus Galerie auswählen';

  @override
  String get editorTitle => 'Foto bearbeiten';

  @override
  String get editorRotate => 'Um 90° drehen';

  @override
  String get editorAutoFit => 'Automatisch an Gesicht anpassen';

  @override
  String get editorApply => 'Foto zuschneiden';

  @override
  String get retouchTitle => 'Hintergrund und Anpassungen';

  @override
  String get retouchBackground => 'Hintergrund';

  @override
  String get retouchRemoveBackground => 'Hintergrund ersetzen';

  @override
  String get retouchRemoveBackgroundHint =>
      'Füllt den einfarbigen Hintergrund hinter Ihnen mit einer sauberen Farbe.';

  @override
  String retouchTolerance(int value) {
    return 'Erkennungstoleranz: $value';
  }

  @override
  String get retouchBackgroundColor => 'Ersatzfarbe';

  @override
  String get retouchAdjustments => 'Anpassungen';

  @override
  String get retouchBrightness => 'Helligkeit';

  @override
  String get retouchContrast => 'Kontrast';

  @override
  String get retouchSaturation => 'Sättigung';

  @override
  String get retouchLocalNote =>
      'Die gesamte Verarbeitung erfolgt auf diesem Gerät.';

  @override
  String get retouchApply => 'Weiter';

  @override
  String get complianceTitle => 'Konformitätsprüfung';

  @override
  String get complianceIntro =>
      'Diese Prüfungen vergleichen Ihr Foto mit den offiziellen Anforderungen. Sie dienen als Orientierung und sind keine Garantie für die Anerkennung.';

  @override
  String get complianceContinue => 'Weiter zum Export';

  @override
  String get complianceMeasured => 'Gemessen';

  @override
  String get complianceDimensions => 'Fotogröße';

  @override
  String get complianceDimensionsDetail =>
      'Das Foto muss exakt die erforderlichen Pixelmaße haben.';

  @override
  String get complianceFace => 'Ein Gesicht erkannt';

  @override
  String get complianceFaceDetail =>
      'Das Foto darf genau eine Person enthalten.';

  @override
  String get complianceHeadHeight => 'Kopfhöhe';

  @override
  String get complianceHeadHeightDetail =>
      'Die Kopfhöhe muss innerhalb des offiziellen Bereichs liegen.';

  @override
  String get complianceEyeLine => 'Position der Augenhöhe';

  @override
  String get complianceEyeLineDetail =>
      'Die Augen müssen sich auf der offiziellen Höhe über dem unteren Rand befinden.';

  @override
  String get complianceBackground => 'Hintergrundfarbe und Gleichmäßigkeit';

  @override
  String get complianceBackgroundDetail =>
      'Der Hintergrund muss einfarbig sein und der erforderlichen Farbe entsprechen.';

  @override
  String get complianceGlasses => 'Brille';

  @override
  String get complianceGlassesAllowed =>
      'Für dieses Dokument ist eine Brille erlaubt.';

  @override
  String get complianceGlassesForbidden =>
      'Für dieses Dokument ist keine Brille erlaubt.';

  @override
  String get complianceFileSize => 'Dateigröße';

  @override
  String get complianceFileSizeDetail =>
      'Die Datei muss unter der offiziellen Größenbeschränkung bleiben.';

  @override
  String get exportTitle => 'Exportieren';

  @override
  String exportSizeLabel(int width, int height) {
    return '$width × $height Pixel';
  }

  @override
  String exportDetails(String mm, String dpi) {
    return '$mm mm bei $dpi DPI';
  }

  @override
  String get exportSavePhoto => 'Foto speichern';

  @override
  String get exportSavePhotoHint =>
      'Speichert das Foto in exakter Größe in Ihrer Galerie.';

  @override
  String get exportShare => 'Teilen';

  @override
  String get exportShareHint => 'Sendet das fertige Foto an eine andere App.';

  @override
  String get exportDoneShare => 'Geteilt.';

  @override
  String exportFileSizeLimit(int kb) {
    return 'Maximale Dateigröße: $kb KB';
  }

  @override
  String get exportPdf => 'PDF (druckfertig)';

  @override
  String get exportPdfHint =>
      'Ein Foto in exakter physischer Größe, druckbereit.';

  @override
  String get exportPrintSheetTitle => 'Druckbögen';

  @override
  String exportPrintSheet(String size) {
    return 'Druckbogen — $size';
  }

  @override
  String get exportPrintSheetHint =>
      'Mehrere Fotos, angeordnet auf einem Blatt Fotopapier.';

  @override
  String get exportDoneSave => 'Gespeichert.';

  @override
  String get exportDonePdf => 'PDF bereit zum Teilen.';

  @override
  String get exportDoneSheet => 'Druckbogen bereit zum Teilen.';

  @override
  String get exportLocalNote =>
      'Die Fotos werden auf diesem Gerät erstellt. Nichts wird hochgeladen.';

  @override
  String get historyDelete => 'Löschen';

  @override
  String get settingsPrivacy => 'Datenschutz';

  @override
  String get settingsClearHistoryHint =>
      'Löscht alle gespeicherten Fotos von diesem Gerät.';

  @override
  String get settingsClearHistoryConfirm =>
      'Dies löscht dauerhaft alle in der App gespeicherten Fotos. Dies kann nicht rückgängig gemacht werden.';

  @override
  String get settingsClearHistoryAction => 'Alles löschen';

  @override
  String get privacyPolicyBody =>
      'PhotoPass verarbeitet Ihre Fotos vollständig auf diesem Gerät.\n\n• Fotos werden nie auf einen Server hochgeladen.\n• Die App enthält keine Werbung, keine Analyse und kein Tracking.\n• Es ist kein Konto und keine Anmeldung erforderlich.\n• Gespeicherte Fotos liegen ausschließlich im privaten Speicher der App.\n• Der einzige Netzzugriff besteht darin, Links zu offiziellen Regierungsquellen in Ihrem Browser zu öffnen.\n• Das Löschen der App entfernt alle Daten der App.';

  @override
  String get settingsAppearance => 'Erscheinungsbild';

  @override
  String get settingsGeneral => 'Allgemein';

  @override
  String get settingsLanguage => 'Sprache';

  @override
  String get settingsThemeLight => 'Hell';

  @override
  String get settingsThemeDark => 'Dunkel';

  @override
  String get settingsThemeSystem => 'System';

  @override
  String get settingsPrivacyPolicy => 'Datenschutzerklärung';

  @override
  String get settingsTerms => 'Nutzungsbedingungen';

  @override
  String get settingsRateApp => 'App bewerten';

  @override
  String get settingsClearHistory => 'Alle gespeicherten Fotos löschen';

  @override
  String get settingsAbout => 'Info';

  @override
  String settingsVersion(String version) {
    return 'Version $version';
  }

  @override
  String get disclaimer =>
      'Die Anforderungen können sich ändern. Prüfen Sie immer die offizielle Quelle. PhotoPass kann die Anerkennung nicht garantieren.';

  @override
  String get homeHeadline => 'Erstellen Sie ein konformes Passfoto';

  @override
  String get homeCreatePhoto => 'Foto erstellen';

  @override
  String get homeRecentTitle => 'Zuletzt';

  @override
  String get homeFavoritesTitle => 'Favoriten';

  @override
  String get homeYourPhotosTitle => 'Ihre Fotos';

  @override
  String get homeYourPhotosEmpty =>
      'Die Fotos, die Sie erstellen, erscheinen hier.';

  @override
  String get specFavoriteAdd => 'Zu Favoriten hinzufügen';

  @override
  String get specFavoriteRemove => 'Aus Favoriten entfernen';

  @override
  String get editorModeCrop => 'Zuschneiden';

  @override
  String get editorModeBackground => 'Hintergrund';

  @override
  String get editorModeAdjust => 'Anpassen';

  @override
  String get editorReset => 'Zurücksetzen';

  @override
  String get editorDiscardTitle => 'Änderungen verwerfen?';

  @override
  String get editorDiscardBody =>
      'Ihr Zuschnitt und Ihre Anpassungen gehen verloren.';

  @override
  String get editorDiscardConfirm => 'Verwerfen';

  @override
  String get captureFlash => 'Blitz';

  @override
  String get complianceActionRetake =>
      'Machen Sie das Foto mit gleichmäßigerem Licht erneut.';

  @override
  String get complianceActionBackground =>
      'Ersetzen Sie den Hintergrund oder machen Sie das Foto vor einer einfarbigen Wand erneut.';

  @override
  String get complianceActionCenter =>
      'Setzen Sie Ihr Gesicht in die Mitte, nutzen Sie die automatische Anpassung und nehmen Sie dann ein neues Foto auf.';

  @override
  String get complianceActionDimensions =>
      'Exportieren Sie das Foto erneut, um die exakt erforderliche Größe zu erzeugen.';

  @override
  String get complianceActionFilesize =>
      'Exportieren Sie als JPEG, um unter der Größenbeschränkung zu bleiben.';

  @override
  String get exportAdvancedDetails => 'Details';

  @override
  String get historyMissingPhoto => 'Fotodatei fehlt';

  @override
  String get swatchRequired => 'Erforderlich';

  @override
  String get swatchSuggested => 'Empfohlen';

  @override
  String get editorCropHint =>
      'Ziehen zum Verschieben, mit zwei Fingern zusammenziehen zum Zoomen.';

  @override
  String get historyReopen => 'Öffnen';

  @override
  String get historyReopenHint => 'Öffnet dieses Foto im Editor.';
}
