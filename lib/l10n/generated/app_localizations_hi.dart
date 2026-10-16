// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'PhotoPass';

  @override
  String get navHome => 'होम';

  @override
  String get navHistory => 'इतिहास';

  @override
  String get navSettings => 'सेटिंग्स';

  @override
  String get onboardingPrivacyTitle =>
      'आपकी फ़ोटो आपके फ़ोन से कभी बाहर नहीं जातीं';

  @override
  String get onboardingPrivacyBody =>
      'फ़ोटोपास चेहरा पहचानना, बैकग्राउंड हटाना और फ़ोटो एक्सपोर्ट पूरी तरह आपके ही डिवाइस पर करता है। कोई खाता नहीं, कोई क्लाउड अपलोड नहीं, और आपकी फ़ोटो पर कोई एनालिटिक्स नहीं।';

  @override
  String get onboardingHowTitle => 'तीन आसान चरण';

  @override
  String get onboardingHowBody =>
      'अपना देश और दस्तावेज़ का प्रकार चुनें, फ़ोटो खींचें या चुनें, फिर मानक-अनुरूप, प्रिंट के लिए तैयार छवि एक्सपोर्ट करें।';

  @override
  String get onboardingLanguageTitle => 'अपनी भाषा चुनें';

  @override
  String get commonContinue => 'जारी रखें';

  @override
  String get commonSkip => 'छोड़ें';

  @override
  String get commonStart => 'आरंभ करें';

  @override
  String get commonBack => 'वापस';

  @override
  String get commonCancel => 'रद्द करें';

  @override
  String get commonRetry => 'फिर से कोशिश करें';

  @override
  String get commonClose => 'बंद करें';

  @override
  String get errorGenericTitle => 'कुछ गलत हो गया';

  @override
  String get errorGenericBody => 'कृपया फिर से कोशिश करें।';

  @override
  String get placeholderBody => 'यह स्क्रीन अगले बिल्ड चरण में आएगी।';

  @override
  String get homeSearchHint => 'देश या दस्तावेज़ खोजें';

  @override
  String get homePopularTitle => 'लोकप्रिय';

  @override
  String get homePassport => 'पासपोर्ट';

  @override
  String get homeVisa => 'वीज़ा';

  @override
  String get homeIdCard => 'पहचान पत्र';

  @override
  String get homeCustomSize => 'कस्टम आकार';

  @override
  String get historyEmptyTitle => 'अभी कोई फ़ोटो नहीं';

  @override
  String get historyEmptyBody => 'आपके बनाए फ़ोटो यहाँ दिखाई देंगे।';

  @override
  String get countrySelectTitle => 'देश और दस्तावेज़';

  @override
  String get countrySearchHint => 'देश खोजें';

  @override
  String get countryNoResults => 'कोई मेल खाता देश नहीं';

  @override
  String countryDocumentsCount(int count) {
    return 'दस्तावेज़: $count';
  }

  @override
  String get specSizeLabel => 'आकार';

  @override
  String get specBackgroundLabel => 'बैकग्राउंड';

  @override
  String get specDpiLabel => 'रिज़ॉल्यूशन';

  @override
  String get specFormatsLabel => 'फ़ॉर्मैट';

  @override
  String get specHeadHeightLabel => 'सिर की ऊँचाई';

  @override
  String get specEyeLineLabel => 'नीचे से आँखों की रेखा';

  @override
  String get specGlassesAllowed => 'चश्मा अनुमत है';

  @override
  String get specGlassesNotAllowed => 'चश्मा अनुमत नहीं है';

  @override
  String get specMaxFileSizeLabel => 'अधिकतम फ़ाइल आकार';

  @override
  String get specVerifiedBadge => 'सत्यापित';

  @override
  String get specUnverifiedBadge => 'असत्यापित';

  @override
  String get specUnverifiedNotice => 'कृपया आधिकारिक स्रोत से पुष्टि करें।';

  @override
  String get specOfficialSource => 'आधिकारिक स्रोत';

  @override
  String specLastVerified(String date) {
    return 'अंतिम सत्यापन $date';
  }

  @override
  String get specUsePhoto => 'इस फ़ोटो का उपयोग करें';

  @override
  String get specNotSpecified => 'निर्दिष्ट नहीं';

  @override
  String get spec_us_passport => 'संयुक्त राज्य अमेरिका का पासपोर्ट';

  @override
  String get spec_gb_passport => 'ब्रिटेन का पासपोर्ट';

  @override
  String get spec_ca_passport => 'कनाडा का पासपोर्ट';

  @override
  String get spec_cn_visa => 'चीन का वीज़ा';

  @override
  String get spec_de_schengen_visa => 'जर्मनी — शेंगेन वीज़ा';

  @override
  String get spec_fr_schengen_visa => 'फ्रांस — शेंगेन वीज़ा';

  @override
  String get spec_it_schengen_visa => 'इटली — शेंगेन वीज़ा';

  @override
  String get spec_es_schengen_visa => 'स्पेन — शेंगेन वीज़ा';

  @override
  String get captureTitle => 'फ़ोटो खींचें';

  @override
  String get captureRationaleTitle => 'कैमरा एक्सेस आवश्यक';

  @override
  String get captureRationaleBody =>
      'PhotoPass पासपोर्ट फ़ोटो खींचने के लिए आपके कैमरे का उपयोग करता है। फ़ोटो आपके फ़ोन पर ही रहती है और उसे कभी अपलोड नहीं किया जाता।';

  @override
  String get captureRationaleDenied =>
      'कैमरा एक्सेस बंद है। फ़ोटो खींचने के लिए सिस्टम सेटिंग्स में इसे चालू करें, या अपनी गैलरी से कोई फ़ोटो चुनें।';

  @override
  String get captureRationaleAction => 'कैमरे की अनुमति दें';

  @override
  String get captureOpenSettings => 'सेटिंग्स खोलें';

  @override
  String get captureCameraError =>
      'कैमरा शुरू नहीं हो सका। आप फिर भी अपनी गैलरी से फ़ोटो चुन सकते हैं।';

  @override
  String get captureHintFace => 'अपने चेहरे को अंडाकार के भीतर रखें';

  @override
  String get captureSwitchCamera => 'कैमरा बदलें';

  @override
  String get captureGallery => 'गैलरी से चुनें';

  @override
  String get editorTitle => 'फ़ोटो संपादित करें';

  @override
  String get editorRotate => '90° घुमाएँ';

  @override
  String get editorAutoFit => 'चेहरे के अनुसार स्वतः फ़िट';

  @override
  String get editorApply => 'फ़ोटो क्रॉप करें';

  @override
  String get retouchTitle => 'बैकग्राउंड और समायोजन';

  @override
  String get retouchBackground => 'बैकग्राउंड';

  @override
  String get retouchRemoveBackground => 'बैकग्राउंड बदलें';

  @override
  String get retouchRemoveBackgroundHint =>
      'आपके पीछे के सपाट बैकग्राउंड को साफ़ रंग से भर देता है।';

  @override
  String retouchTolerance(int value) {
    return 'पहचान सहनशीलता: $value';
  }

  @override
  String get retouchBackgroundColor => 'प्रतिस्थापन रंग';

  @override
  String get retouchAdjustments => 'समायोजन';

  @override
  String get retouchBrightness => 'चमक';

  @override
  String get retouchContrast => 'कॉन्ट्रास्ट';

  @override
  String get retouchSaturation => 'संतृप्ति';

  @override
  String get retouchLocalNote => 'सभी प्रोसेसिंग इसी डिवाइस पर होती है।';

  @override
  String get retouchApply => 'जारी रखें';

  @override
  String get complianceTitle => 'अनुरूपता जाँच';

  @override
  String get complianceIntro =>
      'ये जाँच आपके फ़ोटो की तुलना आधिकारिक आवश्यकताओं से करती हैं। ये केवल मार्गदर्शन हैं, स्वीकृति की गारंटी नहीं।';

  @override
  String get complianceContinue => 'एक्सपोर्ट पर जाएँ';

  @override
  String get complianceMeasured => 'मापा गया';

  @override
  String get complianceDimensions => 'फ़ोटो का आकार';

  @override
  String get complianceDimensionsDetail =>
      'फ़ोटो का पिक्सल आयाम बिल्कुल आवश्यक माप के अनुसार होना चाहिए।';

  @override
  String get complianceFace => 'एक चेहरा मिला';

  @override
  String get complianceFaceDetail => 'फ़ोटो में ठीक एक ही व्यक्ति होना चाहिए।';

  @override
  String get complianceHeadHeight => 'सिर की ऊँचाई';

  @override
  String get complianceHeadHeightDetail =>
      'सिर की ऊँचाई आधिकारिक सीमा के भीतर होनी चाहिए।';

  @override
  String get complianceEyeLine => 'आँखों की रेखा की स्थिति';

  @override
  String get complianceEyeLineDetail =>
      'आँखें नीचे के किनारे से आधिकारिक ऊँचाई पर होनी चाहिएं।';

  @override
  String get complianceBackground => 'बैकग्राउंड का रंग और समानता';

  @override
  String get complianceBackgroundDetail =>
      'बैकग्राउंड सपाट होना चाहिए और आवश्यक रंग से मेल खाना चाहिए।';

  @override
  String get complianceGlasses => 'चश्मा';

  @override
  String get complianceGlassesAllowed => 'इस दस्तावेज़ के लिए चश्मा अनुमत हैं।';

  @override
  String get complianceGlassesForbidden =>
      'इस दस्तावेज़ के लिए चश्मा अनुमत नहीं हैं।';

  @override
  String get complianceFileSize => 'फ़ाइल का आकार';

  @override
  String get complianceFileSizeDetail =>
      'फ़ाइल आधिकारिक सीमा से कम होनी चाहिए।';

  @override
  String get exportTitle => 'एक्सपोर्ट';

  @override
  String exportSizeLabel(int width, int height) {
    return '$width × $height पिक्सल';
  }

  @override
  String exportDetails(String mm, String dpi) {
    return '$dpi DPI पर $mm मिमी';
  }

  @override
  String get exportSavePhoto => 'फ़ोटो सहेजें';

  @override
  String get exportSavePhotoHint =>
      'सटीक आकार की फ़ोटो आपकी गैलरी में सहेजता है।';

  @override
  String get exportShare => 'साझा करें';

  @override
  String get exportShareHint =>
      'तैयार की गई फ़ोटो को किसी अन्य ऐप पर भेजता है।';

  @override
  String get exportDoneShare => 'साझा किया गया।';

  @override
  String exportFileSizeLimit(int kb) {
    return 'अधिकतम फ़ाइल आकार: $kb KB';
  }

  @override
  String get exportPdf => 'PDF (प्रिंट के लिए तैयार)';

  @override
  String get exportPdfHint =>
      'सटीक भौतिक आकार में एक फ़ोटो, प्रिंट के लिए तैयार।';

  @override
  String get exportPrintSheetTitle => 'प्रिंट शीट';

  @override
  String exportPrintSheet(String size) {
    return 'प्रिंट शीट — $size';
  }

  @override
  String get exportPrintSheetHint => 'एक फ़ोटो पेपर शीट पर व्यवस्थित कई फ़ोटो।';

  @override
  String get exportDoneSave => 'सहेजा गया।';

  @override
  String get exportDonePdf => 'PDF साझा करने के लिए तैयार है।';

  @override
  String get exportDoneSheet => 'प्रिंट शीट साझा करने के लिए तैयार है।';

  @override
  String get exportLocalNote =>
      'फ़ोटो इसी डिवाइस पर बनती हैं। कुछ भी अपलोड नहीं होता।';

  @override
  String get historyDelete => 'हटाएँ';

  @override
  String get settingsPrivacy => 'गोपनीयता';

  @override
  String get settingsClearHistoryHint =>
      'इस डिवाइस से सभी सहेजी गई फ़ोटो हटाता है।';

  @override
  String get settingsClearHistoryConfirm =>
      'यह ऐप में सहेजी गई हर फ़ोटो को स्थायी रूप से हटा देता है। इसे पूर्ववत नहीं किया जा सकता।';

  @override
  String get settingsClearHistoryAction => 'सब कुछ हटाएँ';

  @override
  String get privacyPolicyBody =>
      'PhotoPass आपकी फ़ोटो का प्रोसेसिंग पूरी तरह इसी डिवाइस पर करता है।\n\n• फ़ोटो कभी भी किसी सर्वर पर अपलोड नहीं की जातीं।\n• ऐप में कोई विज्ञापन, एनालिटिक्स या ट्रैकिंग नहीं है।\n• किसी खाते या लॉगिन की आवश्यकता नहीं है।\n• सहेजी गई फ़ोटो केवल ऐप के निजी स्टोरेज में रहती हैं।\n• एकमात्र नेटवर्क एक्सेस आपके ब्राउज़र में आधिकारिक सरकारी स्रोत लिंक खोलना है।\n• ऐप हटाने से उसका सारा डेटा हट जाता है।';

  @override
  String get settingsAppearance => 'थीम';

  @override
  String get settingsGeneral => 'सामान्य';

  @override
  String get settingsLanguage => 'भाषा';

  @override
  String get settingsThemeLight => 'लाइट';

  @override
  String get settingsThemeDark => 'डार्क';

  @override
  String get settingsThemeSystem => 'सिस्टम';

  @override
  String get settingsPrivacyPolicy => 'गोपनीयता नीति';

  @override
  String get settingsTerms => 'उपयोग की शर्तें';

  @override
  String get settingsRateApp => 'ऐप को रेटिंग दें';

  @override
  String get settingsClearHistory => 'सभी सहेजी गई फ़ोटो हटाएँ';

  @override
  String get settingsAbout => 'ऐप के बारे में';

  @override
  String settingsVersion(String version) {
    return 'संस्करण $version';
  }

  @override
  String get disclaimer =>
      'आवश्यकताएँ बदल सकती हैं। हमेशा आधिकारिक स्रोत की जाँच करें। PhotoPass स्वीकृति की गारंटी नहीं दे सकता।';

  @override
  String get homeHeadline => 'मानक-अनुरूप पासपोर्ट फ़ोटो बनाएँ';

  @override
  String get homeCreatePhoto => 'फ़ोटो बनाएँ';

  @override
  String get homeRecentTitle => 'हाल की';

  @override
  String get homeFavoritesTitle => 'पसंदीदा';

  @override
  String get homeYourPhotosTitle => 'आपकी फ़ोटो';

  @override
  String get homeYourPhotosEmpty => 'आपके बनाए फ़ोटो यहाँ दिखाई देंगे।';

  @override
  String get specFavoriteAdd => 'पसंदीदा में जोड़ें';

  @override
  String get specFavoriteRemove => 'पसंदीदा से हटाएँ';

  @override
  String get editorModeCrop => 'क्रॉप';

  @override
  String get editorModeBackground => 'बैकग्राउंड';

  @override
  String get editorModeAdjust => 'समायोजन';

  @override
  String get editorReset => 'रीसेट करें';

  @override
  String get editorDiscardTitle => 'परिवर्तन रद्द करें?';

  @override
  String get editorDiscardBody => 'आपकी क्रॉप और समायोजन खो जाएँगे।';

  @override
  String get editorDiscardConfirm => 'रद्द करें';

  @override
  String get captureFlash => 'फ़्लैश';

  @override
  String get complianceActionRetake =>
      'अधिक समान रोशनी के साथ फ़ोटो फिर से खींचें।';

  @override
  String get complianceActionBackground =>
      'बैकग्राउंड बदलें या सपाट दीवार के सामने फ़ोटो फिर से खींचें।';

  @override
  String get complianceActionCenter =>
      'अपने चेहरे को बीच में रखें, स्वतः फ़िट का उपयोग करें, फिर फ़ोटो फिर से खींचें।';

  @override
  String get complianceActionDimensions =>
      'सटीक आवश्यक आकार बनाने के लिए फिर से एक्सपोर्ट करें।';

  @override
  String get complianceActionFilesize =>
      'आकार सीमा के भीतर रहने के लिए JPEG के रूप में एक्सपोर्ट करें।';

  @override
  String get exportAdvancedDetails => 'विवरण';

  @override
  String get historyMissingPhoto => 'फ़ोटो फ़ाइल उपलब्ध नहीं';

  @override
  String get swatchRequired => 'आवश्यक';

  @override
  String get swatchSuggested => 'सुझाया गया';

  @override
  String get editorCropHint =>
      'स्थानांतरित करने के लिए खींचें, ज़ूम करने के लिए पिंच करें।';

  @override
  String get historyReopen => 'खोलें';

  @override
  String get historyReopenHint => 'यह फ़ोटो संपादक में खोलता है।';
}
