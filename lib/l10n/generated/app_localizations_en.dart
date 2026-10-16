// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'PhotoPass';

  @override
  String get navHome => 'Home';

  @override
  String get navHistory => 'History';

  @override
  String get navSettings => 'Settings';

  @override
  String get onboardingPrivacyTitle => 'Your photos never leave your phone';

  @override
  String get onboardingPrivacyBody =>
      'PhotoPass detects faces, removes backgrounds and exports your photo entirely on your device. There is no account, no cloud upload and no analytics on your images.';

  @override
  String get onboardingHowTitle => 'Three simple steps';

  @override
  String get onboardingHowBody =>
      'Pick your country and document type, take or choose a photo, then export a compliant, print-ready image.';

  @override
  String get onboardingLanguageTitle => 'Choose your language';

  @override
  String get commonContinue => 'Continue';

  @override
  String get commonSkip => 'Skip';

  @override
  String get commonStart => 'Get started';

  @override
  String get commonBack => 'Back';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonRetry => 'Try again';

  @override
  String get commonClose => 'Close';

  @override
  String get errorGenericTitle => 'Something went wrong';

  @override
  String get errorGenericBody => 'Please try again.';

  @override
  String get placeholderBody => 'This screen arrives in a later build phase.';

  @override
  String get homeSearchHint => 'Search country or document';

  @override
  String get homePopularTitle => 'Popular';

  @override
  String get homePassport => 'Passport';

  @override
  String get homeVisa => 'Visa';

  @override
  String get homeIdCard => 'ID card';

  @override
  String get homeCustomSize => 'Custom size';

  @override
  String get historyEmptyTitle => 'No photos yet';

  @override
  String get historyEmptyBody => 'Photos you create will appear here.';

  @override
  String get countrySelectTitle => 'Country & document';

  @override
  String get countrySearchHint => 'Search country';

  @override
  String get countryNoResults => 'No matching countries';

  @override
  String countryDocumentsCount(int count) {
    return '$count documents';
  }

  @override
  String get specSizeLabel => 'Size';

  @override
  String get specBackgroundLabel => 'Background';

  @override
  String get specDpiLabel => 'Resolution';

  @override
  String get specFormatsLabel => 'Formats';

  @override
  String get specHeadHeightLabel => 'Head height';

  @override
  String get specEyeLineLabel => 'Eye line from bottom';

  @override
  String get specGlassesAllowed => 'Glasses allowed';

  @override
  String get specGlassesNotAllowed => 'Glasses not allowed';

  @override
  String get specMaxFileSizeLabel => 'Max file size';

  @override
  String get specVerifiedBadge => 'Verified';

  @override
  String get specUnverifiedBadge => 'Unverified';

  @override
  String get specUnverifiedNotice => 'Please confirm with the official source.';

  @override
  String get specOfficialSource => 'Official source';

  @override
  String specLastVerified(String date) {
    return 'Last verified $date';
  }

  @override
  String get specUsePhoto => 'Use this photo';

  @override
  String get specNotSpecified => 'Not specified';

  @override
  String get spec_us_passport => 'United States passport';

  @override
  String get spec_gb_passport => 'United Kingdom passport';

  @override
  String get spec_ca_passport => 'Canada passport';

  @override
  String get spec_cn_visa => 'China visa';

  @override
  String get spec_de_schengen_visa => 'Germany — Schengen visa';

  @override
  String get spec_fr_schengen_visa => 'France — Schengen visa';

  @override
  String get spec_it_schengen_visa => 'Italy — Schengen visa';

  @override
  String get spec_es_schengen_visa => 'Spain — Schengen visa';

  @override
  String get captureTitle => 'Take a photo';

  @override
  String get captureRationaleTitle => 'Camera access needed';

  @override
  String get captureRationaleBody =>
      'PhotoPass uses your camera to take a passport photo. The photo stays on your phone and is never uploaded.';

  @override
  String get captureRationaleDenied =>
      'Camera access is turned off. Enable it in system settings to take a photo, or choose one from your gallery.';

  @override
  String get captureRationaleAction => 'Allow camera';

  @override
  String get captureOpenSettings => 'Open settings';

  @override
  String get captureCameraError =>
      'Couldn\'t start the camera. You can still choose a photo from your gallery.';

  @override
  String get captureHintFace => 'Position your face inside the oval';

  @override
  String get captureSwitchCamera => 'Switch camera';

  @override
  String get captureGallery => 'Choose from gallery';

  @override
  String get editorTitle => 'Edit photo';

  @override
  String get editorRotate => 'Rotate 90°';

  @override
  String get editorAutoFit => 'Auto-fit to face';

  @override
  String get editorApply => 'Crop photo';

  @override
  String get retouchTitle => 'Background & adjustments';

  @override
  String get retouchBackground => 'Background';

  @override
  String get retouchRemoveBackground => 'Replace background';

  @override
  String get retouchRemoveBackgroundHint =>
      'Fills the plain background behind you with a clean colour.';

  @override
  String retouchTolerance(int value) {
    return 'Detection tolerance: $value';
  }

  @override
  String get retouchBackgroundColor => 'Replacement colour';

  @override
  String get retouchAdjustments => 'Adjustments';

  @override
  String get retouchBrightness => 'Brightness';

  @override
  String get retouchContrast => 'Contrast';

  @override
  String get retouchSaturation => 'Colour';

  @override
  String get retouchLocalNote => 'All processing happens on this device.';

  @override
  String get retouchApply => 'Continue';

  @override
  String get complianceTitle => 'Compliance check';

  @override
  String get complianceIntro =>
      'These checks compare your photo with the official requirements. They are guidance, not a guarantee of acceptance.';

  @override
  String get complianceContinue => 'Continue to export';

  @override
  String get complianceMeasured => 'Measured';

  @override
  String get complianceDimensions => 'Photo size';

  @override
  String get complianceDimensionsDetail =>
      'The photo must have exactly the required pixel dimensions.';

  @override
  String get complianceFace => 'One face detected';

  @override
  String get complianceFaceDetail =>
      'The photo must contain exactly one person.';

  @override
  String get complianceHeadHeight => 'Head height';

  @override
  String get complianceHeadHeightDetail =>
      'Head height must fall within the official range.';

  @override
  String get complianceEyeLine => 'Eye line position';

  @override
  String get complianceEyeLineDetail =>
      'Eyes must sit at the official height from the bottom.';

  @override
  String get complianceBackground => 'Background colour & uniformity';

  @override
  String get complianceBackgroundDetail =>
      'The background must be plain and match the required colour.';

  @override
  String get complianceGlasses => 'Glasses';

  @override
  String get complianceGlassesAllowed =>
      'Glasses are allowed for this document.';

  @override
  String get complianceGlassesForbidden =>
      'Glasses are not allowed for this document.';

  @override
  String get complianceFileSize => 'File size';

  @override
  String get complianceFileSizeDetail =>
      'The file must stay under the official size limit.';

  @override
  String get exportTitle => 'Export';

  @override
  String exportSizeLabel(int width, int height) {
    return '$width × $height pixels';
  }

  @override
  String exportDetails(String mm, String dpi) {
    return '$mm mm at $dpi DPI';
  }

  @override
  String get exportSavePhoto => 'Save photo';

  @override
  String get exportSavePhotoHint =>
      'Saves the exact-size photo to your gallery.';

  @override
  String get exportShare => 'Share';

  @override
  String get exportShareHint => 'Sends the finished photo to another app.';

  @override
  String get exportDoneShare => 'Shared.';

  @override
  String exportFileSizeLimit(int kb) {
    return 'Maximum file size: $kb KB';
  }

  @override
  String get exportPdf => 'PDF (print ready)';

  @override
  String get exportPdfHint =>
      'One photo at the exact physical size, ready to print.';

  @override
  String get exportPrintSheetTitle => 'Print sheets';

  @override
  String exportPrintSheet(String size) {
    return 'Print sheet — $size';
  }

  @override
  String get exportPrintSheetHint =>
      'Several photos arranged on one sheet of photo paper.';

  @override
  String get exportDoneSave => 'Saved.';

  @override
  String get exportDonePdf => 'PDF ready to share.';

  @override
  String get exportDoneSheet => 'Print sheet ready to share.';

  @override
  String get exportLocalNote =>
      'Photos are created on this device. Nothing is uploaded.';

  @override
  String get historyDelete => 'Delete';

  @override
  String get settingsPrivacy => 'Privacy';

  @override
  String get settingsClearHistoryHint =>
      'Deletes all saved photos from this device.';

  @override
  String get settingsClearHistoryConfirm =>
      'This permanently deletes every photo saved in the app. This cannot be undone.';

  @override
  String get settingsClearHistoryAction => 'Delete everything';

  @override
  String get privacyPolicyBody =>
      'PhotoPass processes your photos entirely on this device.\n\n• Photos are never uploaded to any server.\n• The app contains no ads, analytics or tracking.\n• No account or login is required.\n• Saved photos live only in the app\'s private storage.\n• The only network access is opening official government source links in your browser.\n• Deleting the app removes all of its data.';

  @override
  String get settingsAppearance => 'Appearance';

  @override
  String get settingsGeneral => 'General';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsThemeLight => 'Light';

  @override
  String get settingsThemeDark => 'Dark';

  @override
  String get settingsThemeSystem => 'System';

  @override
  String get settingsPrivacyPolicy => 'Privacy policy';

  @override
  String get settingsTerms => 'Terms of use';

  @override
  String get settingsRateApp => 'Rate the app';

  @override
  String get settingsClearHistory => 'Delete all saved photos';

  @override
  String get settingsAbout => 'About';

  @override
  String settingsVersion(String version) {
    return 'Version $version';
  }

  @override
  String get disclaimer =>
      'Requirements can change. Always check the official source. PhotoPass cannot guarantee acceptance.';

  @override
  String get homeHeadline => 'Create a compliant passport photo';

  @override
  String get homeCreatePhoto => 'Create a photo';

  @override
  String get homeRecentTitle => 'Recent';

  @override
  String get homeFavoritesTitle => 'Favourites';

  @override
  String get homeYourPhotosTitle => 'Your photos';

  @override
  String get homeYourPhotosEmpty => 'Photos you create will appear here.';

  @override
  String get specFavoriteAdd => 'Add to favourites';

  @override
  String get specFavoriteRemove => 'Remove from favourites';

  @override
  String get editorModeCrop => 'Crop';

  @override
  String get editorModeBackground => 'Background';

  @override
  String get editorModeAdjust => 'Adjust';

  @override
  String get editorReset => 'Reset';

  @override
  String get editorDiscardTitle => 'Discard changes?';

  @override
  String get editorDiscardBody => 'Your crop and adjustments will be lost.';

  @override
  String get editorDiscardConfirm => 'Discard';

  @override
  String get captureFlash => 'Flash';

  @override
  String get complianceActionRetake =>
      'Retake the photo with more even lighting.';

  @override
  String get complianceActionBackground =>
      'Replace the background or retake against a plain wall.';

  @override
  String get complianceActionCenter =>
      'Centre your face, use auto-fit, then retake.';

  @override
  String get complianceActionDimensions =>
      'Export again to produce the exact required size.';

  @override
  String get complianceActionFilesize =>
      'Export as JPEG to stay under the size limit.';

  @override
  String get exportAdvancedDetails => 'Details';

  @override
  String get historyMissingPhoto => 'Photo file missing';

  @override
  String get swatchRequired => 'Required';

  @override
  String get swatchSuggested => 'Suggested';

  @override
  String get editorCropHint => 'Drag to move, pinch to zoom.';

  @override
  String get historyReopen => 'Open';

  @override
  String get historyReopenHint => 'Opens this photo in the editor.';
}
