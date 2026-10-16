import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_bn.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fa.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_id.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_ur.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('bn'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fa'),
    Locale('fr'),
    Locale('hi'),
    Locale('id'),
    Locale('ja'),
    Locale('pt'),
    Locale('ru'),
    Locale('tr'),
    Locale('ur'),
    Locale('zh'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'PhotoPass'**
  String get appTitle;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get navHistory;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @onboardingPrivacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Your photos never leave your phone'**
  String get onboardingPrivacyTitle;

  /// No description provided for @onboardingPrivacyBody.
  ///
  /// In en, this message translates to:
  /// **'PhotoPass detects faces, removes backgrounds and exports your photo entirely on your device. There is no account, no cloud upload and no analytics on your images.'**
  String get onboardingPrivacyBody;

  /// No description provided for @onboardingHowTitle.
  ///
  /// In en, this message translates to:
  /// **'Three simple steps'**
  String get onboardingHowTitle;

  /// No description provided for @onboardingHowBody.
  ///
  /// In en, this message translates to:
  /// **'Pick your country and document type, take or choose a photo, then export a compliant, print-ready image.'**
  String get onboardingHowBody;

  /// No description provided for @onboardingLanguageTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your language'**
  String get onboardingLanguageTitle;

  /// No description provided for @commonContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get commonContinue;

  /// No description provided for @commonSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get commonSkip;

  /// No description provided for @commonStart.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get commonStart;

  /// No description provided for @commonBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get commonBack;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonRetry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get commonRetry;

  /// No description provided for @commonClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get commonClose;

  /// No description provided for @errorGenericTitle.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get errorGenericTitle;

  /// No description provided for @errorGenericBody.
  ///
  /// In en, this message translates to:
  /// **'Please try again.'**
  String get errorGenericBody;

  /// No description provided for @placeholderBody.
  ///
  /// In en, this message translates to:
  /// **'This screen arrives in a later build phase.'**
  String get placeholderBody;

  /// No description provided for @homeSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search country or document'**
  String get homeSearchHint;

  /// No description provided for @homePopularTitle.
  ///
  /// In en, this message translates to:
  /// **'Popular'**
  String get homePopularTitle;

  /// No description provided for @homePassport.
  ///
  /// In en, this message translates to:
  /// **'Passport'**
  String get homePassport;

  /// No description provided for @homeVisa.
  ///
  /// In en, this message translates to:
  /// **'Visa'**
  String get homeVisa;

  /// No description provided for @homeIdCard.
  ///
  /// In en, this message translates to:
  /// **'ID card'**
  String get homeIdCard;

  /// No description provided for @homeCustomSize.
  ///
  /// In en, this message translates to:
  /// **'Custom size'**
  String get homeCustomSize;

  /// No description provided for @historyEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No photos yet'**
  String get historyEmptyTitle;

  /// No description provided for @historyEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Photos you create will appear here.'**
  String get historyEmptyBody;

  /// No description provided for @countrySelectTitle.
  ///
  /// In en, this message translates to:
  /// **'Country & document'**
  String get countrySelectTitle;

  /// No description provided for @countrySearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search country'**
  String get countrySearchHint;

  /// No description provided for @countryNoResults.
  ///
  /// In en, this message translates to:
  /// **'No matching countries'**
  String get countryNoResults;

  /// No description provided for @countryDocumentsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} documents'**
  String countryDocumentsCount(int count);

  /// No description provided for @specSizeLabel.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get specSizeLabel;

  /// No description provided for @specBackgroundLabel.
  ///
  /// In en, this message translates to:
  /// **'Background'**
  String get specBackgroundLabel;

  /// No description provided for @specDpiLabel.
  ///
  /// In en, this message translates to:
  /// **'Resolution'**
  String get specDpiLabel;

  /// No description provided for @specFormatsLabel.
  ///
  /// In en, this message translates to:
  /// **'Formats'**
  String get specFormatsLabel;

  /// No description provided for @specHeadHeightLabel.
  ///
  /// In en, this message translates to:
  /// **'Head height'**
  String get specHeadHeightLabel;

  /// No description provided for @specEyeLineLabel.
  ///
  /// In en, this message translates to:
  /// **'Eye line from bottom'**
  String get specEyeLineLabel;

  /// No description provided for @specGlassesAllowed.
  ///
  /// In en, this message translates to:
  /// **'Glasses allowed'**
  String get specGlassesAllowed;

  /// No description provided for @specGlassesNotAllowed.
  ///
  /// In en, this message translates to:
  /// **'Glasses not allowed'**
  String get specGlassesNotAllowed;

  /// No description provided for @specMaxFileSizeLabel.
  ///
  /// In en, this message translates to:
  /// **'Max file size'**
  String get specMaxFileSizeLabel;

  /// No description provided for @specVerifiedBadge.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get specVerifiedBadge;

  /// No description provided for @specUnverifiedBadge.
  ///
  /// In en, this message translates to:
  /// **'Unverified'**
  String get specUnverifiedBadge;

  /// No description provided for @specUnverifiedNotice.
  ///
  /// In en, this message translates to:
  /// **'Please confirm with the official source.'**
  String get specUnverifiedNotice;

  /// No description provided for @specOfficialSource.
  ///
  /// In en, this message translates to:
  /// **'Official source'**
  String get specOfficialSource;

  /// No description provided for @specLastVerified.
  ///
  /// In en, this message translates to:
  /// **'Last verified {date}'**
  String specLastVerified(String date);

  /// No description provided for @specUsePhoto.
  ///
  /// In en, this message translates to:
  /// **'Use this photo'**
  String get specUsePhoto;

  /// No description provided for @specNotSpecified.
  ///
  /// In en, this message translates to:
  /// **'Not specified'**
  String get specNotSpecified;

  /// No description provided for @spec_us_passport.
  ///
  /// In en, this message translates to:
  /// **'United States passport'**
  String get spec_us_passport;

  /// No description provided for @spec_gb_passport.
  ///
  /// In en, this message translates to:
  /// **'United Kingdom passport'**
  String get spec_gb_passport;

  /// No description provided for @spec_ca_passport.
  ///
  /// In en, this message translates to:
  /// **'Canada passport'**
  String get spec_ca_passport;

  /// No description provided for @spec_cn_visa.
  ///
  /// In en, this message translates to:
  /// **'China visa'**
  String get spec_cn_visa;

  /// No description provided for @spec_de_schengen_visa.
  ///
  /// In en, this message translates to:
  /// **'Germany — Schengen visa'**
  String get spec_de_schengen_visa;

  /// No description provided for @spec_fr_schengen_visa.
  ///
  /// In en, this message translates to:
  /// **'France — Schengen visa'**
  String get spec_fr_schengen_visa;

  /// No description provided for @spec_it_schengen_visa.
  ///
  /// In en, this message translates to:
  /// **'Italy — Schengen visa'**
  String get spec_it_schengen_visa;

  /// No description provided for @spec_es_schengen_visa.
  ///
  /// In en, this message translates to:
  /// **'Spain — Schengen visa'**
  String get spec_es_schengen_visa;

  /// No description provided for @captureTitle.
  ///
  /// In en, this message translates to:
  /// **'Take a photo'**
  String get captureTitle;

  /// No description provided for @captureRationaleTitle.
  ///
  /// In en, this message translates to:
  /// **'Camera access needed'**
  String get captureRationaleTitle;

  /// No description provided for @captureRationaleBody.
  ///
  /// In en, this message translates to:
  /// **'PhotoPass uses your camera to take a passport photo. The photo stays on your phone and is never uploaded.'**
  String get captureRationaleBody;

  /// No description provided for @captureRationaleDenied.
  ///
  /// In en, this message translates to:
  /// **'Camera access is turned off. Enable it in system settings to take a photo, or choose one from your gallery.'**
  String get captureRationaleDenied;

  /// No description provided for @captureRationaleAction.
  ///
  /// In en, this message translates to:
  /// **'Allow camera'**
  String get captureRationaleAction;

  /// No description provided for @captureOpenSettings.
  ///
  /// In en, this message translates to:
  /// **'Open settings'**
  String get captureOpenSettings;

  /// No description provided for @captureCameraError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t start the camera. You can still choose a photo from your gallery.'**
  String get captureCameraError;

  /// No description provided for @captureHintFace.
  ///
  /// In en, this message translates to:
  /// **'Position your face inside the oval'**
  String get captureHintFace;

  /// No description provided for @captureSwitchCamera.
  ///
  /// In en, this message translates to:
  /// **'Switch camera'**
  String get captureSwitchCamera;

  /// No description provided for @captureGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from gallery'**
  String get captureGallery;

  /// No description provided for @editorTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit photo'**
  String get editorTitle;

  /// No description provided for @editorRotate.
  ///
  /// In en, this message translates to:
  /// **'Rotate 90°'**
  String get editorRotate;

  /// No description provided for @editorAutoFit.
  ///
  /// In en, this message translates to:
  /// **'Auto-fit to face'**
  String get editorAutoFit;

  /// No description provided for @editorApply.
  ///
  /// In en, this message translates to:
  /// **'Crop photo'**
  String get editorApply;

  /// No description provided for @retouchTitle.
  ///
  /// In en, this message translates to:
  /// **'Background & adjustments'**
  String get retouchTitle;

  /// No description provided for @retouchBackground.
  ///
  /// In en, this message translates to:
  /// **'Background'**
  String get retouchBackground;

  /// No description provided for @retouchRemoveBackground.
  ///
  /// In en, this message translates to:
  /// **'Replace background'**
  String get retouchRemoveBackground;

  /// No description provided for @retouchRemoveBackgroundHint.
  ///
  /// In en, this message translates to:
  /// **'Fills the plain background behind you with a clean colour.'**
  String get retouchRemoveBackgroundHint;

  /// No description provided for @retouchTolerance.
  ///
  /// In en, this message translates to:
  /// **'Detection tolerance: {value}'**
  String retouchTolerance(int value);

  /// No description provided for @retouchBackgroundColor.
  ///
  /// In en, this message translates to:
  /// **'Replacement colour'**
  String get retouchBackgroundColor;

  /// No description provided for @retouchAdjustments.
  ///
  /// In en, this message translates to:
  /// **'Adjustments'**
  String get retouchAdjustments;

  /// No description provided for @retouchBrightness.
  ///
  /// In en, this message translates to:
  /// **'Brightness'**
  String get retouchBrightness;

  /// No description provided for @retouchContrast.
  ///
  /// In en, this message translates to:
  /// **'Contrast'**
  String get retouchContrast;

  /// No description provided for @retouchSaturation.
  ///
  /// In en, this message translates to:
  /// **'Colour'**
  String get retouchSaturation;

  /// No description provided for @retouchLocalNote.
  ///
  /// In en, this message translates to:
  /// **'All processing happens on this device.'**
  String get retouchLocalNote;

  /// No description provided for @retouchApply.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get retouchApply;

  /// No description provided for @complianceTitle.
  ///
  /// In en, this message translates to:
  /// **'Compliance check'**
  String get complianceTitle;

  /// No description provided for @complianceIntro.
  ///
  /// In en, this message translates to:
  /// **'These checks compare your photo with the official requirements. They are guidance, not a guarantee of acceptance.'**
  String get complianceIntro;

  /// No description provided for @complianceContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue to export'**
  String get complianceContinue;

  /// No description provided for @complianceMeasured.
  ///
  /// In en, this message translates to:
  /// **'Measured'**
  String get complianceMeasured;

  /// No description provided for @complianceDimensions.
  ///
  /// In en, this message translates to:
  /// **'Photo size'**
  String get complianceDimensions;

  /// No description provided for @complianceDimensionsDetail.
  ///
  /// In en, this message translates to:
  /// **'The photo must have exactly the required pixel dimensions.'**
  String get complianceDimensionsDetail;

  /// No description provided for @complianceFace.
  ///
  /// In en, this message translates to:
  /// **'One face detected'**
  String get complianceFace;

  /// No description provided for @complianceFaceDetail.
  ///
  /// In en, this message translates to:
  /// **'The photo must contain exactly one person.'**
  String get complianceFaceDetail;

  /// No description provided for @complianceHeadHeight.
  ///
  /// In en, this message translates to:
  /// **'Head height'**
  String get complianceHeadHeight;

  /// No description provided for @complianceHeadHeightDetail.
  ///
  /// In en, this message translates to:
  /// **'Head height must fall within the official range.'**
  String get complianceHeadHeightDetail;

  /// No description provided for @complianceEyeLine.
  ///
  /// In en, this message translates to:
  /// **'Eye line position'**
  String get complianceEyeLine;

  /// No description provided for @complianceEyeLineDetail.
  ///
  /// In en, this message translates to:
  /// **'Eyes must sit at the official height from the bottom.'**
  String get complianceEyeLineDetail;

  /// No description provided for @complianceBackground.
  ///
  /// In en, this message translates to:
  /// **'Background colour & uniformity'**
  String get complianceBackground;

  /// No description provided for @complianceBackgroundDetail.
  ///
  /// In en, this message translates to:
  /// **'The background must be plain and match the required colour.'**
  String get complianceBackgroundDetail;

  /// No description provided for @complianceGlasses.
  ///
  /// In en, this message translates to:
  /// **'Glasses'**
  String get complianceGlasses;

  /// No description provided for @complianceGlassesAllowed.
  ///
  /// In en, this message translates to:
  /// **'Glasses are allowed for this document.'**
  String get complianceGlassesAllowed;

  /// No description provided for @complianceGlassesForbidden.
  ///
  /// In en, this message translates to:
  /// **'Glasses are not allowed for this document.'**
  String get complianceGlassesForbidden;

  /// No description provided for @complianceFileSize.
  ///
  /// In en, this message translates to:
  /// **'File size'**
  String get complianceFileSize;

  /// No description provided for @complianceFileSizeDetail.
  ///
  /// In en, this message translates to:
  /// **'The file must stay under the official size limit.'**
  String get complianceFileSizeDetail;

  /// No description provided for @exportTitle.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get exportTitle;

  /// No description provided for @exportSizeLabel.
  ///
  /// In en, this message translates to:
  /// **'{width} × {height} pixels'**
  String exportSizeLabel(int width, int height);

  /// No description provided for @exportDetails.
  ///
  /// In en, this message translates to:
  /// **'{mm} mm at {dpi} DPI'**
  String exportDetails(String mm, String dpi);

  /// No description provided for @exportSavePhoto.
  ///
  /// In en, this message translates to:
  /// **'Save photo'**
  String get exportSavePhoto;

  /// No description provided for @exportSavePhotoHint.
  ///
  /// In en, this message translates to:
  /// **'Saves the exact-size photo to your gallery.'**
  String get exportSavePhotoHint;

  /// No description provided for @exportShare.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get exportShare;

  /// No description provided for @exportShareHint.
  ///
  /// In en, this message translates to:
  /// **'Sends the finished photo to another app.'**
  String get exportShareHint;

  /// No description provided for @exportDoneShare.
  ///
  /// In en, this message translates to:
  /// **'Shared.'**
  String get exportDoneShare;

  /// No description provided for @exportFileSizeLimit.
  ///
  /// In en, this message translates to:
  /// **'Maximum file size: {kb} KB'**
  String exportFileSizeLimit(int kb);

  /// No description provided for @exportPdf.
  ///
  /// In en, this message translates to:
  /// **'PDF (print ready)'**
  String get exportPdf;

  /// No description provided for @exportPdfHint.
  ///
  /// In en, this message translates to:
  /// **'One photo at the exact physical size, ready to print.'**
  String get exportPdfHint;

  /// No description provided for @exportPrintSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Print sheets'**
  String get exportPrintSheetTitle;

  /// No description provided for @exportPrintSheet.
  ///
  /// In en, this message translates to:
  /// **'Print sheet — {size}'**
  String exportPrintSheet(String size);

  /// No description provided for @exportPrintSheetHint.
  ///
  /// In en, this message translates to:
  /// **'Several photos arranged on one sheet of photo paper.'**
  String get exportPrintSheetHint;

  /// No description provided for @exportDoneSave.
  ///
  /// In en, this message translates to:
  /// **'Saved.'**
  String get exportDoneSave;

  /// No description provided for @exportDonePdf.
  ///
  /// In en, this message translates to:
  /// **'PDF ready to share.'**
  String get exportDonePdf;

  /// No description provided for @exportDoneSheet.
  ///
  /// In en, this message translates to:
  /// **'Print sheet ready to share.'**
  String get exportDoneSheet;

  /// No description provided for @exportLocalNote.
  ///
  /// In en, this message translates to:
  /// **'Photos are created on this device. Nothing is uploaded.'**
  String get exportLocalNote;

  /// No description provided for @historyDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get historyDelete;

  /// No description provided for @settingsPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get settingsPrivacy;

  /// No description provided for @settingsClearHistoryHint.
  ///
  /// In en, this message translates to:
  /// **'Deletes all saved photos from this device.'**
  String get settingsClearHistoryHint;

  /// No description provided for @settingsClearHistoryConfirm.
  ///
  /// In en, this message translates to:
  /// **'This permanently deletes every photo saved in the app. This cannot be undone.'**
  String get settingsClearHistoryConfirm;

  /// No description provided for @settingsClearHistoryAction.
  ///
  /// In en, this message translates to:
  /// **'Delete everything'**
  String get settingsClearHistoryAction;

  /// No description provided for @privacyPolicyBody.
  ///
  /// In en, this message translates to:
  /// **'PhotoPass processes your photos entirely on this device.\n\n• Photos are never uploaded to any server.\n• The app contains no ads, analytics or tracking.\n• No account or login is required.\n• Saved photos live only in the app\'s private storage.\n• The only network access is opening official government source links in your browser.\n• Deleting the app removes all of its data.'**
  String get privacyPolicyBody;

  /// No description provided for @settingsAppearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settingsAppearance;

  /// No description provided for @settingsGeneral.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get settingsGeneral;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsThemeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settingsThemeLight;

  /// No description provided for @settingsThemeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settingsThemeDark;

  /// No description provided for @settingsThemeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get settingsThemeSystem;

  /// No description provided for @settingsPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get settingsPrivacyPolicy;

  /// No description provided for @settingsTerms.
  ///
  /// In en, this message translates to:
  /// **'Terms of use'**
  String get settingsTerms;

  /// No description provided for @settingsRateApp.
  ///
  /// In en, this message translates to:
  /// **'Rate the app'**
  String get settingsRateApp;

  /// No description provided for @settingsClearHistory.
  ///
  /// In en, this message translates to:
  /// **'Delete all saved photos'**
  String get settingsClearHistory;

  /// No description provided for @settingsAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settingsAbout;

  /// No description provided for @settingsVersion.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String settingsVersion(String version);

  /// No description provided for @disclaimer.
  ///
  /// In en, this message translates to:
  /// **'Requirements can change. Always check the official source. PhotoPass cannot guarantee acceptance.'**
  String get disclaimer;

  /// No description provided for @homeHeadline.
  ///
  /// In en, this message translates to:
  /// **'Create a compliant passport photo'**
  String get homeHeadline;

  /// No description provided for @homeCreatePhoto.
  ///
  /// In en, this message translates to:
  /// **'Create a photo'**
  String get homeCreatePhoto;

  /// No description provided for @homeRecentTitle.
  ///
  /// In en, this message translates to:
  /// **'Recent'**
  String get homeRecentTitle;

  /// No description provided for @homeFavoritesTitle.
  ///
  /// In en, this message translates to:
  /// **'Favourites'**
  String get homeFavoritesTitle;

  /// No description provided for @homeYourPhotosTitle.
  ///
  /// In en, this message translates to:
  /// **'Your photos'**
  String get homeYourPhotosTitle;

  /// No description provided for @homeYourPhotosEmpty.
  ///
  /// In en, this message translates to:
  /// **'Photos you create will appear here.'**
  String get homeYourPhotosEmpty;

  /// No description provided for @specFavoriteAdd.
  ///
  /// In en, this message translates to:
  /// **'Add to favourites'**
  String get specFavoriteAdd;

  /// No description provided for @specFavoriteRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove from favourites'**
  String get specFavoriteRemove;

  /// No description provided for @editorModeCrop.
  ///
  /// In en, this message translates to:
  /// **'Crop'**
  String get editorModeCrop;

  /// No description provided for @editorModeBackground.
  ///
  /// In en, this message translates to:
  /// **'Background'**
  String get editorModeBackground;

  /// No description provided for @editorModeAdjust.
  ///
  /// In en, this message translates to:
  /// **'Adjust'**
  String get editorModeAdjust;

  /// No description provided for @editorReset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get editorReset;

  /// No description provided for @editorDiscardTitle.
  ///
  /// In en, this message translates to:
  /// **'Discard changes?'**
  String get editorDiscardTitle;

  /// No description provided for @editorDiscardBody.
  ///
  /// In en, this message translates to:
  /// **'Your crop and adjustments will be lost.'**
  String get editorDiscardBody;

  /// No description provided for @editorDiscardConfirm.
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get editorDiscardConfirm;

  /// No description provided for @captureFlash.
  ///
  /// In en, this message translates to:
  /// **'Flash'**
  String get captureFlash;

  /// No description provided for @complianceActionRetake.
  ///
  /// In en, this message translates to:
  /// **'Retake the photo with more even lighting.'**
  String get complianceActionRetake;

  /// No description provided for @complianceActionBackground.
  ///
  /// In en, this message translates to:
  /// **'Replace the background or retake against a plain wall.'**
  String get complianceActionBackground;

  /// No description provided for @complianceActionCenter.
  ///
  /// In en, this message translates to:
  /// **'Centre your face, use auto-fit, then retake.'**
  String get complianceActionCenter;

  /// No description provided for @complianceActionDimensions.
  ///
  /// In en, this message translates to:
  /// **'Export again to produce the exact required size.'**
  String get complianceActionDimensions;

  /// No description provided for @complianceActionFilesize.
  ///
  /// In en, this message translates to:
  /// **'Export as JPEG to stay under the size limit.'**
  String get complianceActionFilesize;

  /// No description provided for @exportAdvancedDetails.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get exportAdvancedDetails;

  /// No description provided for @historyMissingPhoto.
  ///
  /// In en, this message translates to:
  /// **'Photo file missing'**
  String get historyMissingPhoto;

  /// No description provided for @swatchRequired.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get swatchRequired;

  /// No description provided for @swatchSuggested.
  ///
  /// In en, this message translates to:
  /// **'Suggested'**
  String get swatchSuggested;

  /// No description provided for @editorCropHint.
  ///
  /// In en, this message translates to:
  /// **'Drag to move, pinch to zoom.'**
  String get editorCropHint;

  /// No description provided for @historyReopen.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get historyReopen;

  /// No description provided for @historyReopenHint.
  ///
  /// In en, this message translates to:
  /// **'Opens this photo in the editor.'**
  String get historyReopenHint;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'bn',
    'de',
    'en',
    'es',
    'fa',
    'fr',
    'hi',
    'id',
    'ja',
    'pt',
    'ru',
    'tr',
    'ur',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'bn':
      return AppLocalizationsBn();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fa':
      return AppLocalizationsFa();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'id':
      return AppLocalizationsId();
    case 'ja':
      return AppLocalizationsJa();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'tr':
      return AppLocalizationsTr();
    case 'ur':
      return AppLocalizationsUr();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
