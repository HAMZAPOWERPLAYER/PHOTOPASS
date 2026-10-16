// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get appTitle => 'PhotoPass';

  @override
  String get navHome => 'হোম';

  @override
  String get navHistory => 'ইতিহাস';

  @override
  String get navSettings => 'সেটিংস';

  @override
  String get onboardingPrivacyTitle => 'আপনার ছবি কখনো আপনার ফোন ছেড়ে যায় না';

  @override
  String get onboardingPrivacyBody =>
      'ফটোপাস মুখ শনাক্ত করে, ব্যাকগ্রাউন্ড সরিয়ে দেয় এবং আপনার ছবি সম্পূর্ণভাবে আপনার ডিভাইসে এক্সপোর্ট করে। কোনো অ্যাকাউন্ট নেই, ক্লাউড আপলোড নেই এবং আপনার ছবির কোনো অ্যানালিটিক্স নেই।';

  @override
  String get onboardingHowTitle => 'তিনটি সহজ ধাপ';

  @override
  String get onboardingHowBody =>
      'আপনার দেশ ও ডকুমেন্টের ধরন বেছে নিন, ছবি তুলুন বা বেছে নিন, তারপর নিয়মানুগ, প্রিন্টের জন্য প্রস্তুত ছবি এক্সপোর্ট করুন।';

  @override
  String get onboardingLanguageTitle => 'আপনার ভাষা বেছে নিন';

  @override
  String get commonContinue => 'চালিয়ে যান';

  @override
  String get commonSkip => 'বাদ দিন';

  @override
  String get commonStart => 'শুরু করুন';

  @override
  String get commonBack => 'পিছনে';

  @override
  String get commonCancel => 'বাতিল';

  @override
  String get commonRetry => 'আবার চেষ্টা করুন';

  @override
  String get commonClose => 'বন্ধ করুন';

  @override
  String get errorGenericTitle => 'কিছু একটা সমস্যা হয়েছে';

  @override
  String get errorGenericBody => 'অনুগ্রহ করে আবার চেষ্টা করুন।';

  @override
  String get placeholderBody => 'এই স্ক্রিনটি পরবর্তী বিল্ড পর্বে আসবে।';

  @override
  String get homeSearchHint => 'দেশ বা ডকুমেন্ট খুঁজুন';

  @override
  String get homePopularTitle => 'জনপ্রিয়';

  @override
  String get homePassport => 'পাসপোর্ট';

  @override
  String get homeVisa => 'ভিসা';

  @override
  String get homeIdCard => 'পরিচয়পত্র';

  @override
  String get homeCustomSize => 'কাস্টম আকার';

  @override
  String get historyEmptyTitle => 'এখনো কোনো ছবি নেই';

  @override
  String get historyEmptyBody => 'আপনার তৈরি করা ছবি এখানে দেখা যাবে।';

  @override
  String get countrySelectTitle => 'দেশ ও ডকুমেন্ট';

  @override
  String get countrySearchHint => 'দেশ খুঁজুন';

  @override
  String get countryNoResults => 'মিলে যাওয়া কোনো দেশ নেই';

  @override
  String countryDocumentsCount(int count) {
    return 'ডকুমেন্ট: $count';
  }

  @override
  String get specSizeLabel => 'আকার';

  @override
  String get specBackgroundLabel => 'ব্যাকগ্রাউন্ড';

  @override
  String get specDpiLabel => 'রিজল্যুশন';

  @override
  String get specFormatsLabel => 'ফরম্যাট';

  @override
  String get specHeadHeightLabel => 'মাথার উচ্চতা';

  @override
  String get specEyeLineLabel => 'নিচ থেকে চোখের লাইন';

  @override
  String get specGlassesAllowed => 'চশমা অনুমোদিত';

  @override
  String get specGlassesNotAllowed => 'চশমা অনুমোদিত নয়';

  @override
  String get specMaxFileSizeLabel => 'সর্বোচ্চ ফাইল আকার';

  @override
  String get specVerifiedBadge => 'যাচাইকৃত';

  @override
  String get specUnverifiedBadge => 'অযাচাইকৃত';

  @override
  String get specUnverifiedNotice =>
      'অনুগ্রহ করে আনুষ্ঠানিক উৎস থেকে নিশ্চিত করুন।';

  @override
  String get specOfficialSource => 'আনুষ্ঠানিক উৎস';

  @override
  String specLastVerified(String date) {
    return 'সর্বশেষ যাচাই $date';
  }

  @override
  String get specUsePhoto => 'এই ছবি ব্যবহার করুন';

  @override
  String get specNotSpecified => 'উল্লেখ করা নেই';

  @override
  String get spec_us_passport => 'মার্কিন যুক্তরাষ্ট্রের পাসপোর্ট';

  @override
  String get spec_gb_passport => 'যুক্তরাজ্যের পাসপোর্ট';

  @override
  String get spec_ca_passport => 'কানাডার পাসপোর্ট';

  @override
  String get spec_cn_visa => 'চীনের ভিসা';

  @override
  String get spec_de_schengen_visa => 'জার্মানি — শেনগেন ভিসা';

  @override
  String get spec_fr_schengen_visa => 'ফ্রান্স — শেনগেন ভিসা';

  @override
  String get spec_it_schengen_visa => 'ইতালি — শেনগেন ভিসা';

  @override
  String get spec_es_schengen_visa => 'স্পেন — শেনগেন ভিসা';

  @override
  String get captureTitle => 'ছবি তুলুন';

  @override
  String get captureRationaleTitle => 'ক্যামেরার অনুমতি প্রয়োজন';

  @override
  String get captureRationaleBody =>
      'PhotoPass পাসপোর্ট ছবি তোলার জন্য আপনার ক্যামেরা ব্যবহার করে। ছবি আপনার ফোনেই থাকে এবং কখনো আপলোড করা হয় না।';

  @override
  String get captureRationaleDenied =>
      'ক্যামেরার অনুমতি বন্ধ আছে। ছবি তুলতে সিস্টেম সেটিংসে এটি চালু করুন, অথবা গ্যালারি থেকে কোনো ছবি বেছে নিন।';

  @override
  String get captureRationaleAction => 'ক্যামেরার অনুমতি দিন';

  @override
  String get captureOpenSettings => 'সেটিংস খুলুন';

  @override
  String get captureCameraError =>
      'ক্যামেরা চালু করা যায়নি। তবুও আপনি গ্যালারি থেকে ছবি বেছে নিতে পারেন।';

  @override
  String get captureHintFace => 'মুখটি উপবৃত্তের ভেতরে রাখুন';

  @override
  String get captureSwitchCamera => 'ক্যামেরা পরিবর্তন করুন';

  @override
  String get captureGallery => 'গ্যালারি থেকে বেছে নিন';

  @override
  String get editorTitle => 'ছবি সম্পাদনা করুন';

  @override
  String get editorRotate => '৯০° ঘোরান';

  @override
  String get editorAutoFit => 'মুখ অনুযায়ী স্বয়ংক্রিয় ফিট';

  @override
  String get editorApply => 'ছবি কাটুন';

  @override
  String get retouchTitle => 'ব্যাকগ্রাউন্ড ও সমন্বয়';

  @override
  String get retouchBackground => 'ব্যাকগ্রাউন্ড';

  @override
  String get retouchRemoveBackground => 'ব্যাকগ্রাউন্ড পরিবর্তন করুন';

  @override
  String get retouchRemoveBackgroundHint =>
      'আপনার পেছনের একঘেয়ে ব্যাকগ্রাউন্ডকে পরিষ্কার রং দিয়ে ভরে দেয়।';

  @override
  String retouchTolerance(int value) {
    return 'সনাক্তকরণ সহনশীলতা: $value';
  }

  @override
  String get retouchBackgroundColor => 'প্রতিস্থাপন রং';

  @override
  String get retouchAdjustments => 'সমন্বয়';

  @override
  String get retouchBrightness => 'উজ্জ্বলতা';

  @override
  String get retouchContrast => 'কনট্রাস্ট';

  @override
  String get retouchSaturation => 'রঙের সম্পৃক্ততা';

  @override
  String get retouchLocalNote => 'সব প্রসেসিং এই ডিভাইসেই হয়।';

  @override
  String get retouchApply => 'চালিয়ে যান';

  @override
  String get complianceTitle => 'সম্মতি পরীক্ষা';

  @override
  String get complianceIntro =>
      'এই পরীক্ষাগুলো আপনার ছবির তুলনা আনুষ্ঠানিক প্রয়োজনীয়তার সঙ্গে করে। এগুলো শুধু নির্দেশনা, গ্রহণের নিশ্চয়তা নয়।';

  @override
  String get complianceContinue => 'এক্সপোর্টে যান';

  @override
  String get complianceMeasured => 'পরিমাপকৃত';

  @override
  String get complianceDimensions => 'ছবির আকার';

  @override
  String get complianceDimensionsDetail =>
      'ছবির পিক্সেলের মাপ ঠিক প্রয়োজনীয় অনুযায়ী হতে হবে।';

  @override
  String get complianceFace => 'একটি মুখ শনাক্ত হয়েছে';

  @override
  String get complianceFaceDetail => 'ছবিতে ঠিক একজন ব্যক্তি থাকতে হবে।';

  @override
  String get complianceHeadHeight => 'মাথার উচ্চতা';

  @override
  String get complianceHeadHeightDetail =>
      'মাথার উচ্চতা আনুষ্ঠানিক সীমার মধ্যে হতে হবে।';

  @override
  String get complianceEyeLine => 'চোখের লাইনের অবস্থান';

  @override
  String get complianceEyeLineDetail =>
      'চোখ নিচের প্রান্ত থেকে আনুষ্ঠানিক উচ্চতায় থাকতে হবে।';

  @override
  String get complianceBackground => 'ব্যাকগ্রাউন্ডের রং ও সমতা';

  @override
  String get complianceBackgroundDetail =>
      'ব্যাকগ্রাউন্ড একসমান হতে হবে এবং প্রয়োজনীয় রংযের সঙ্গে মিলতে হবে।';

  @override
  String get complianceGlasses => 'চশমা';

  @override
  String get complianceGlassesAllowed => 'এই ডকুমেন্টের জন্য চশমা অনুমোদিত।';

  @override
  String get complianceGlassesForbidden =>
      'এই ডকুমেন্টের জন্য চশমা অনুমোদিত নয়।';

  @override
  String get complianceFileSize => 'ফাইলের আকার';

  @override
  String get complianceFileSizeDetail =>
      'ফাইলটি আনুষ্ঠানিক সীমার নিচে থাকতে হবে।';

  @override
  String get exportTitle => 'এক্সপোর্ট';

  @override
  String exportSizeLabel(int width, int height) {
    return '$width × $height পিক্সেল';
  }

  @override
  String exportDetails(String mm, String dpi) {
    return '$dpi DPI-তে $mm মিমি';
  }

  @override
  String get exportSavePhoto => 'ছবি সংরক্ষণ করুন';

  @override
  String get exportSavePhotoHint =>
      'সঠিক আকারের ছবি আপনার গ্যালারিতে সংরক্ষণ করে।';

  @override
  String get exportShare => 'শেয়ার করুন';

  @override
  String get exportShareHint => 'সম্পন্ন ছবিটি অন্য অ্যাপে পাঠায়।';

  @override
  String get exportDoneShare => 'শেয়ার করা হয়েছে।';

  @override
  String exportFileSizeLimit(int kb) {
    return 'সর্বোচ্চ ফাইল আকার: $kb KB';
  }

  @override
  String get exportPdf => 'PDF (প্রিন্টের জন্য প্রস্তুত)';

  @override
  String get exportPdfHint =>
      'সঠিক বাস্তব আকারে একটি ছবি, প্রিন্টের জন্য প্রস্তুত।';

  @override
  String get exportPrintSheetTitle => 'প্রিন্ট শিট';

  @override
  String exportPrintSheet(String size) {
    return 'প্রিন্ট শিট — $size';
  }

  @override
  String get exportPrintSheetHint => 'একটি ফটো কাগজে সাজানো কয়েকটি ছবি।';

  @override
  String get exportDoneSave => 'সংরক্ষিত হয়েছে।';

  @override
  String get exportDonePdf => 'PDF শেয়ার করার জন্য প্রস্তুত।';

  @override
  String get exportDoneSheet => 'প্রিন্ট শিট শেয়ার করার জন্য প্রস্তুত।';

  @override
  String get exportLocalNote =>
      'ছবি এই ডিভাইসেই তৈরি হয়। কিছুই আপলোড করা হয় না।';

  @override
  String get historyDelete => 'মুছে ফেলুন';

  @override
  String get settingsPrivacy => 'গোপনীয়তা';

  @override
  String get settingsClearHistoryHint =>
      'এই ডিভাইস থেকে সংরক্ষিত সব ছবি মুছে ফেলে।';

  @override
  String get settingsClearHistoryConfirm =>
      'এটি অ্যাপে সংরক্ষিত প্রতিটি ছবি স্থায়ীভাবে মুছে ফেলবে। এটি ফিরিয়ে আনা যাবে না।';

  @override
  String get settingsClearHistoryAction => 'সবকিছু মুছে ফেলুন';

  @override
  String get privacyPolicyBody =>
      'PhotoPass আপনার ছবি সম্পূর্ণভাবে এই ডিভাইসেই প্রসেস করে।\n\n• ছবি কখনো কোনো সার্ভারে আপলোড করা হয় না।\n• অ্যাপে কোনো বিজ্ঞাপন, অ্যানালিটিক্স বা ট্র্যাকিং নেই।\n• কোনো অ্যাকাউন্ট বা লগইনের প্রয়োজন নেই।\n• সংরক্ষিত ছবি শুধু অ্যাপের ব্যক্তিগত স্টোরেজে থাকে।\n• একমাত্র নেটওয়ার্ক অ্যাক্সেস হলো আপনার ব্রাউজারে আনুষ্ঠানিক সরকারি উৎসের লিংক খোলা।\n• অ্যাপ মুছে ফেললে তার সব ডেটাও মুছে যায়।';

  @override
  String get settingsAppearance => 'থিম';

  @override
  String get settingsGeneral => 'সাধারণ';

  @override
  String get settingsLanguage => 'ভাষা';

  @override
  String get settingsThemeLight => 'হালকা';

  @override
  String get settingsThemeDark => 'গাঢ়';

  @override
  String get settingsThemeSystem => 'সিস্টেম';

  @override
  String get settingsPrivacyPolicy => 'গোপনীয়তা নীতি';

  @override
  String get settingsTerms => 'ব্যবহারের শর্তাবলী';

  @override
  String get settingsRateApp => 'অ্যাপকে রেটিং দিন';

  @override
  String get settingsClearHistory => 'সংরক্ষিত সব ছবি মুছে ফেলুন';

  @override
  String get settingsAbout => 'অ্যাপ সম্পর্কে';

  @override
  String settingsVersion(String version) {
    return 'সংস্করণ $version';
  }

  @override
  String get disclaimer =>
      'প্রয়োজনীয়তা পরিবর্তিত হতে পারে। সর্বদা আনুষ্ঠানিক উৎস যাচাই করুন। PhotoPass গ্রহণযোগ্যতার নিশ্চয়তা দিতে পারে না।';

  @override
  String get homeHeadline => 'নিয়মানুগ পাসপোর্ট ছবি তৈরি করুন';

  @override
  String get homeCreatePhoto => 'ছবি তৈরি করুন';

  @override
  String get homeRecentTitle => 'সাম্প্রতিক';

  @override
  String get homeFavoritesTitle => 'প্রিয়তম';

  @override
  String get homeYourPhotosTitle => 'আপনার ছবি';

  @override
  String get homeYourPhotosEmpty => 'আপনার তৈরি করা ছবি এখানে দেখা যাবে।';

  @override
  String get specFavoriteAdd => 'প্রিয়তমে যোগ করুন';

  @override
  String get specFavoriteRemove => 'প্রিয়তম থেকে সরান';

  @override
  String get editorModeCrop => 'কাটা';

  @override
  String get editorModeBackground => 'ব্যাকগ্রাউন্ড';

  @override
  String get editorModeAdjust => 'সমন্বয়';

  @override
  String get editorReset => 'রিসেট করুন';

  @override
  String get editorDiscardTitle => 'পরিবর্তনগুলো বাতিল করবেন?';

  @override
  String get editorDiscardBody => 'আপনার কাটা ও সমন্বয় হারিয়ে যাবে।';

  @override
  String get editorDiscardConfirm => 'বাতিল করুন';

  @override
  String get captureFlash => 'ফ্ল্যাশ';

  @override
  String get complianceActionRetake => 'আরও সমান আলোতে ছবিটি আবার তুলুন।';

  @override
  String get complianceActionBackground =>
      'ব্যাকগ্রাউন্ড পরিবর্তন করুন বা সমতল দেয়ালের সামনে আবার তুলুন।';

  @override
  String get complianceActionCenter =>
      'মুখটি কেন্দ্রে রাখুন, স্বয়ংক্রিয় ফিট ব্যবহার করুন, তারপর আবার তুলুন।';

  @override
  String get complianceActionDimensions =>
      'প্রয়োজনীয় সঠিক আকার পেতে আবার এক্সপোর্ট করুন।';

  @override
  String get complianceActionFilesize =>
      'আকারের সীমার মধ্যে থাকতে JPEG হিসেবে এক্সপোর্ট করুন।';

  @override
  String get exportAdvancedDetails => 'বিবরণ';

  @override
  String get historyMissingPhoto => 'ছবির ফাইল পাওয়া যায়নি';

  @override
  String get swatchRequired => 'আবশ্যক';

  @override
  String get swatchSuggested => 'প্রস্তাবিত';

  @override
  String get editorCropHint => 'সরাতে টেনে নিন, জুম করতে দু আঙুলে চাপুন।';

  @override
  String get historyReopen => 'খুলুন';

  @override
  String get historyReopenHint => 'এই ছবিটি এডিটরে খোলে।';
}
