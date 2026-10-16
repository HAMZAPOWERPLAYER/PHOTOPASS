// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Urdu (`ur`).
class AppLocalizationsUr extends AppLocalizations {
  AppLocalizationsUr([String locale = 'ur']) : super(locale);

  @override
  String get appTitle => 'PhotoPass';

  @override
  String get navHome => 'ہوم';

  @override
  String get navHistory => 'تاریخچہ';

  @override
  String get navSettings => 'ترتیبات';

  @override
  String get onboardingPrivacyTitle =>
      'آپ کی تصاویر کبھی آپ کے فون سے باہر نہیں جاتیں';

  @override
  String get onboardingPrivacyBody =>
      'فوٹوپاس چہرے کی نشاندہی، پس منظر کی تبدیلی اور تصویر کی ایکسپورٹ بالکل آپ کے ہی ڈیوائس پر کرتا ہے۔ کوئی اکاؤنٹ نہیں، کوئی کلاؤڈ اپ لوڈ نہیں، اور آپ کی تصاویر پر کوئی اینالیٹکس نہیں۔';

  @override
  String get onboardingHowTitle => 'تین آسان مراحل';

  @override
  String get onboardingHowBody =>
      'اپنے ملک اور دستاویز کی قسم منتخب کریں، تصویر لیں یا گیلری سے منتخب کریں، پھر مطابقت پذیر اور چھپائی کے لیے تیار تصویر باہر نکالیں۔';

  @override
  String get onboardingLanguageTitle => 'اپنی زبان منتخب کریں';

  @override
  String get commonContinue => 'جاری رکھیں';

  @override
  String get commonSkip => 'چھوڑیں';

  @override
  String get commonStart => 'شروع کریں';

  @override
  String get commonBack => 'واپس';

  @override
  String get commonCancel => 'منسوخ';

  @override
  String get commonRetry => 'دوبارہ کوشش کریں';

  @override
  String get commonClose => 'بند کریں';

  @override
  String get errorGenericTitle => 'کچھ غلط ہو گیا';

  @override
  String get errorGenericBody => 'براہِ کرم دوبارہ کوشش کریں۔';

  @override
  String get placeholderBody => 'یہ اسکرین اگلے بلڈ مرحلے میں شامل ہوگی۔';

  @override
  String get homeSearchHint => 'ملک یا دستاویز تلاش کریں';

  @override
  String get homePopularTitle => 'مقبول';

  @override
  String get homePassport => 'پاسپورٹ';

  @override
  String get homeVisa => 'ویزا';

  @override
  String get homeIdCard => 'شناختی کارڈ';

  @override
  String get homeCustomSize => 'حسبِ ضرورت سائز';

  @override
  String get historyEmptyTitle => 'ابھی کوئی تصاویر نہیں';

  @override
  String get historyEmptyBody => 'آپ کی بنائی گئی تصاویر یہاں نظر آئیں گی۔';

  @override
  String get countrySelectTitle => 'ملک اور دستاویز';

  @override
  String get countrySearchHint => 'ملک تلاش کریں';

  @override
  String get countryNoResults => 'کوئی متعلقہ ملک نہیں ملا';

  @override
  String countryDocumentsCount(int count) {
    return '$count دستاویزات';
  }

  @override
  String get specSizeLabel => 'سائز';

  @override
  String get specBackgroundLabel => 'پس منظر';

  @override
  String get specDpiLabel => 'رزلوشن';

  @override
  String get specFormatsLabel => 'فارمیٹس';

  @override
  String get specHeadHeightLabel => 'سر کی اونچائی';

  @override
  String get specEyeLineLabel => 'آنکھوں کی لکیر نیچے سے';

  @override
  String get specGlassesAllowed => 'عینک جائز ہے';

  @override
  String get specGlassesNotAllowed => 'عینک جائز نہیں';

  @override
  String get specMaxFileSizeLabel => 'زیادہ سے زیادہ فائل کا حجم';

  @override
  String get specVerifiedBadge => 'تصدیق شدہ';

  @override
  String get specUnverifiedBadge => 'غیر تصدیق شدہ';

  @override
  String get specUnverifiedNotice => 'براہِ کرم سرکاری ماخذ سے تصدیق کریں۔';

  @override
  String get specOfficialSource => 'سرکاری ماخذ';

  @override
  String specLastVerified(String date) {
    return 'آخری تصدیق $date';
  }

  @override
  String get specUsePhoto => 'یہ تصویر استعمال کریں';

  @override
  String get specNotSpecified => 'مذکورہ نہیں';

  @override
  String get spec_us_passport => 'امریکی پاسپورٹ';

  @override
  String get spec_gb_passport => 'برطانوی پاسپورٹ';

  @override
  String get spec_ca_passport => 'کینیڈین پاسپورٹ';

  @override
  String get spec_cn_visa => 'چینی ویزا';

  @override
  String get spec_de_schengen_visa => 'جرمنی — شینگن ویزا';

  @override
  String get spec_fr_schengen_visa => 'فرانس — شینگن ویزا';

  @override
  String get spec_it_schengen_visa => 'اٹلی — شینگن ویزا';

  @override
  String get spec_es_schengen_visa => 'اسپین — شینگن ویزا';

  @override
  String get captureTitle => 'تصویر لیں';

  @override
  String get captureRationaleTitle => 'کیمرے کی اجازت درکار ہے';

  @override
  String get captureRationaleBody =>
      'PhotoPass پاسپورٹ کی تصویر لینے کے لیے آپ کا کیمرا استعمال کرتا ہے۔ تصویر آپ کے فون پر ہی رہتی ہے اور کبھی اپ لوڈ نہیں ہوتی۔';

  @override
  String get captureRationaleDenied =>
      'کیمرے کی اجازت بند ہے۔ تصویر لینے کے لیے سسٹم ترتیبات میں اسے فعال کریں، یا گیلری سے تصویر منتخب کریں۔';

  @override
  String get captureRationaleAction => 'کیمرے کی اجازت دیں';

  @override
  String get captureOpenSettings => 'ترتیبات کھولیں';

  @override
  String get captureCameraError =>
      'کیمرا شروع نہیں ہو سکا۔ آپ گیلری سے تصویر منتخب کر سکتے ہیں۔';

  @override
  String get captureHintFace => 'اپنے چہرے کو بیضے کے اندر رکھیں';

  @override
  String get captureSwitchCamera => 'کیمرا تبدیل کریں';

  @override
  String get captureGallery => 'گیلری سے منتخب کریں';

  @override
  String get editorTitle => 'تصویر میں ترمیم';

  @override
  String get editorRotate => '90° گھمائیں';

  @override
  String get editorAutoFit => 'چہرے کے مطابق خودکار ترتیب';

  @override
  String get editorApply => 'تصویر کاٹیں';

  @override
  String get retouchTitle => 'پس منظر اور ترمیمات';

  @override
  String get retouchBackground => 'پس منظر';

  @override
  String get retouchRemoveBackground => 'پس منظر تبدیل کریں';

  @override
  String get retouchRemoveBackgroundHint =>
      'آپ کے پیچھے کے سادہ پس منظر کو صاف رنگ سے بھر دیتا ہے۔';

  @override
  String retouchTolerance(int value) {
    return 'پہچان کی گنجائش: $value';
  }

  @override
  String get retouchBackgroundColor => 'تبدیلی کا رنگ';

  @override
  String get retouchAdjustments => 'ترمیمات';

  @override
  String get retouchBrightness => 'چمک';

  @override
  String get retouchContrast => 'کانٹراسٹ';

  @override
  String get retouchSaturation => 'رنگ';

  @override
  String get retouchLocalNote => 'تمام پروسیسنگ اسی ڈیوائس پر ہوتی ہے۔';

  @override
  String get retouchApply => 'جاری رکھیں';

  @override
  String get complianceTitle => 'مطابقت کی جانچ';

  @override
  String get complianceIntro =>
      'یہ جانچیں آپ کی تصویر کا موازنہ سرکاری شرائط سے کرتی ہیں۔ یہ رہنمائی ہیں، قبولیت کی ضمانت نہیں۔';

  @override
  String get complianceContinue => 'ایکسپورٹ کی طرف جاری رکھیں';

  @override
  String get complianceMeasured => 'پیمائش شدہ';

  @override
  String get complianceDimensions => 'تصویر کا سائز';

  @override
  String get complianceDimensionsDetail =>
      'تصویر کے پکسل کے پیمانے بالکل مطابق ہونے چاہئیں۔';

  @override
  String get complianceFace => 'ایک چہرہ دریافت ہوا';

  @override
  String get complianceFaceDetail => 'تصویر میں بالکل ایک شخص ہونا چاہیے۔';

  @override
  String get complianceHeadHeight => 'سر کی اونچائی';

  @override
  String get complianceHeadHeightDetail =>
      'سر کی اونچائی سرکاری حد میں ہونی چاہیے۔';

  @override
  String get complianceEyeLine => 'آنکھوں کی لکیر کی جگہ';

  @override
  String get complianceEyeLineDetail =>
      'آنکھیں نیچے سے سرکاری اونچائی پر ہونی چاہئیں۔';

  @override
  String get complianceBackground => 'پس منظر کا رنگ اور یکساں پن';

  @override
  String get complianceBackgroundDetail =>
      'پس منظر سادہ ہونا چاہیے اور مطلوبہ رنگ سے مماثل ہونا چاہیے۔';

  @override
  String get complianceGlasses => 'عینک';

  @override
  String get complianceGlassesAllowed => 'اس دستاویز کے لیے عینک جائز ہے۔';

  @override
  String get complianceGlassesForbidden => 'اس دستاویز کے لیے عینک جائز نہیں۔';

  @override
  String get complianceFileSize => 'فائل کا حجم';

  @override
  String get complianceFileSizeDetail => 'فائل سرکاری حد سے کم ہونی چاہیے۔';

  @override
  String get exportTitle => 'ایکسپورٹ';

  @override
  String exportSizeLabel(int width, int height) {
    return '$width × $height پکسلز';
  }

  @override
  String exportDetails(String mm, String dpi) {
    return '$mm ملی میٹر، $dpi DPI';
  }

  @override
  String get exportSavePhoto => 'تصویر محفوظ کریں';

  @override
  String get exportSavePhotoHint =>
      'بالکل درست سائز کی تصویر آپ کی گیلری میں محفوظ کرتا ہے۔';

  @override
  String get exportShare => 'شیئر کریں';

  @override
  String get exportShareHint => 'تیار شدہ تصویر کسی دوسری ایپ کو بھیج دیتی ہے۔';

  @override
  String get exportDoneShare => 'شیئر ہو گیا۔';

  @override
  String exportFileSizeLimit(int kb) {
    return 'زیادہ سے زیادہ فائل کا حجم: $kb KB';
  }

  @override
  String get exportPdf => 'PDF (چھپائی کے لیے تیار)';

  @override
  String get exportPdfHint =>
      'ایک تصویر بالکل درست جسامت میں، چھپائی کے لیے تیار۔';

  @override
  String get exportPrintSheetTitle => 'پرنٹ شیٹس';

  @override
  String exportPrintSheet(String size) {
    return 'پرنٹ شیٹ — $size';
  }

  @override
  String get exportPrintSheetHint => 'ایک فوٹو پیپر کی شیٹ پر متعدد تصاویر۔';

  @override
  String get exportDoneSave => 'محفوظ ہو گیا۔';

  @override
  String get exportDonePdf => 'PDF شیئر کے لیے تیار ہے۔';

  @override
  String get exportDoneSheet => 'پرنٹ شیٹ شیئر کے لیے تیار ہے۔';

  @override
  String get exportLocalNote =>
      'تصاویر اسی ڈیوائس پر بنائی جاتی ہیں۔ کچھ بھی اپ لوڈ نہیں ہوتا۔';

  @override
  String get historyDelete => 'حذف کریں';

  @override
  String get settingsPrivacy => 'رازداری';

  @override
  String get settingsClearHistoryHint =>
      'اس ڈیوائس سے تمام محفوظ تصاویر حذف کر دیتا ہے۔';

  @override
  String get settingsClearHistoryConfirm =>
      'یہ ایپ میں محفوظ ہر تصویر مستقل طور پر حذف کر دیتا ہے۔ اسے واپس نہیں کیا جا سکتا۔';

  @override
  String get settingsClearHistoryAction => 'سب کچھ حذف کریں';

  @override
  String get privacyPolicyBody =>
      'PhotoPass آپ کی تصاویر کی پروسیسنگ بالکل اسی ڈیوائس پر کرتا ہے۔\n\n• تصاویر کبھی کسی سرور پر اپ لوڈ نہیں ہوتیں۔\n• ایپ میں کوئی اشتہار، اینالیٹکس یا ٹریکنگ نہیں ہے۔\n• کسی اکاؤنٹ یا لاگ اِن کی ضرورت نہیں۔\n• محفوظ تصاویر صرف ایپ کی نجی اسٹوریج میں رہتی ہیں۔\n• واحد نیٹ ورک رسائی آپ کے براؤزر میں سرکاری حکومتی ماخذ کے لنکس کھولنا ہے۔\n• ایپ کو حذف کرنے سے اس کا تمام ڈیٹا ختم ہو جاتا ہے۔';

  @override
  String get settingsAppearance => 'ظاہری شکل';

  @override
  String get settingsGeneral => 'عمومی';

  @override
  String get settingsLanguage => 'زبان';

  @override
  String get settingsThemeLight => 'روشن';

  @override
  String get settingsThemeDark => 'گہرا';

  @override
  String get settingsThemeSystem => 'سسٹم';

  @override
  String get settingsPrivacyPolicy => 'رازداری کی پالیسی';

  @override
  String get settingsTerms => 'استعمال کی شرائط';

  @override
  String get settingsRateApp => 'ایپ کو درجہ بندی کریں';

  @override
  String get settingsClearHistory => 'تمام محفوظ تصاویر حذف کریں';

  @override
  String get settingsAbout => 'بارے میں';

  @override
  String settingsVersion(String version) {
    return 'ورژن $version';
  }

  @override
  String get disclaimer =>
      'شرائط تبدیل ہو سکتی ہیں۔ ہمیشہ سرکاری ماخذ چیک کریں۔ PhotoPass قبولیت کی ضمانت نہیں دے سکتا۔';

  @override
  String get homeHeadline => 'مطابقت پذیر پاسپورٹ کی تصویر بنائیں';

  @override
  String get homeCreatePhoto => 'تصویر بنائیں';

  @override
  String get homeRecentTitle => 'حالیہ';

  @override
  String get homeFavoritesTitle => 'پسندیدہ';

  @override
  String get homeYourPhotosTitle => 'آپ کی تصاویر';

  @override
  String get homeYourPhotosEmpty => 'آپ کی بنائی گئی تصاویر یہاں نظر آئیں گی۔';

  @override
  String get specFavoriteAdd => 'پسندیدہ میں شامل کریں';

  @override
  String get specFavoriteRemove => 'پسندیدہ سے ہٹائیں';

  @override
  String get editorModeCrop => 'کاٹیں';

  @override
  String get editorModeBackground => 'پس منظر';

  @override
  String get editorModeAdjust => 'ترمیم';

  @override
  String get editorReset => 'ری سیٹ';

  @override
  String get editorDiscardTitle => 'تبدیلیاں مسترد کر دیں؟';

  @override
  String get editorDiscardBody => 'آپ کی کٹنگ اور ترمیمات ضائع ہو جائیں گی۔';

  @override
  String get editorDiscardConfirm => 'مسترد کریں';

  @override
  String get captureFlash => 'فلیش';

  @override
  String get complianceActionRetake =>
      'مزید یکساں روشنی کے ساتھ تصویر دوبارہ لیں۔';

  @override
  String get complianceActionBackground =>
      'پس منظر تبدیل کریں یا سادہ دیوار کے سامنے دوبارہ تصویر لیں۔';

  @override
  String get complianceActionCenter =>
      'اپنے چہرے کو درمیان میں رکھیں، خودکار ترتیب استعمال کریں، پھر دوبارہ تصویر لیں۔';

  @override
  String get complianceActionDimensions =>
      'بالکل درست مطلوبہ سائز حاصل کرنے کے لیے دوبارہ ایکسپورٹ کریں۔';

  @override
  String get complianceActionFilesize =>
      'حجم کی حد سے کم رہنے کے لیے JPEG کے طور پر ایکسپورٹ کریں۔';

  @override
  String get exportAdvancedDetails => 'تفصیلات';

  @override
  String get historyMissingPhoto => 'تصویر کی فائل موجود نہیں';

  @override
  String get swatchRequired => 'ضروری';

  @override
  String get swatchSuggested => 'تجویز کردہ';

  @override
  String get editorCropHint =>
      'منتقل کرنے کے لیے کھینچیں، زوم کے لیے انگلیوں سے پھیلائیں۔';

  @override
  String get historyReopen => 'کھولیں';

  @override
  String get historyReopenHint => 'یہ تصویر کو ایڈیٹر میں کھول دیتا ہے۔';
}
