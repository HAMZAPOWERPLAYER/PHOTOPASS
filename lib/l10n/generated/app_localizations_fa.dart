// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get appTitle => 'PhotoPass';

  @override
  String get navHome => 'خانه';

  @override
  String get navHistory => 'تاریخچه';

  @override
  String get navSettings => 'تنظیمات';

  @override
  String get onboardingPrivacyTitle =>
      'عکس‌های شما هرگز گوشی‌تان را ترک نمی‌کنند';

  @override
  String get onboardingPrivacyBody =>
      'فوتوپس چهره‌ها را تشخیص می‌دهد، پس‌زمینه را حذف می‌کند و عکس شما را کاملاً روی دستگاه خودتان خروجی می‌دهد. بدون حساب، بدون بارگذاری ابری و بدون تحلیل روی تصاویر شما.';

  @override
  String get onboardingHowTitle => 'سه مرحله ساده';

  @override
  String get onboardingHowBody =>
      'کشور و نوع سند خود را انتخاب کنید، عکسی بگیرید یا از گالری انتخاب کنید و سپس یک عکس منطبق و آماده چاپ خروجی بگیرید.';

  @override
  String get onboardingLanguageTitle => 'زبان خود را انتخاب کنید';

  @override
  String get commonContinue => 'ادامه';

  @override
  String get commonSkip => 'رد کردن';

  @override
  String get commonStart => 'شروع';

  @override
  String get commonBack => 'بازگشت';

  @override
  String get commonCancel => 'انصراف';

  @override
  String get commonRetry => 'تلاش دوباره';

  @override
  String get commonClose => 'بستن';

  @override
  String get errorGenericTitle => 'مشکلی پیش آمد';

  @override
  String get errorGenericBody => 'لطفاً دوباره تلاش کنید.';

  @override
  String get placeholderBody => 'این صفحه در مرحله بعدی ساخت ارائه می‌شود.';

  @override
  String get homeSearchHint => 'جستجوی کشور یا سند';

  @override
  String get homePopularTitle => 'محبوب‌ها';

  @override
  String get homePassport => 'گذرنامه';

  @override
  String get homeVisa => 'ویزا';

  @override
  String get homeIdCard => 'کارت شناسایی';

  @override
  String get homeCustomSize => 'اندازه دلخواه';

  @override
  String get historyEmptyTitle => 'هنوز عکسی وجود ندارد';

  @override
  String get historyEmptyBody =>
      'عکس‌هایی که می‌سازید اینجا نمایش داده می‌شوند.';

  @override
  String get countrySelectTitle => 'کشور و سند';

  @override
  String get countrySearchHint => 'جستجوی کشور';

  @override
  String get countryNoResults => 'کشوری مطابق یافت نشد';

  @override
  String countryDocumentsCount(int count) {
    return '$count سند';
  }

  @override
  String get specSizeLabel => 'اندازه';

  @override
  String get specBackgroundLabel => 'پس‌زمینه';

  @override
  String get specDpiLabel => 'وضوح';

  @override
  String get specFormatsLabel => 'قالب‌ها';

  @override
  String get specHeadHeightLabel => 'ارتفاع سر';

  @override
  String get specEyeLineLabel => 'خط چشم از پایین';

  @override
  String get specGlassesAllowed => 'عینک مجاز است';

  @override
  String get specGlassesNotAllowed => 'عینک مجاز نیست';

  @override
  String get specMaxFileSizeLabel => 'حداکثر حجم پرونده';

  @override
  String get specVerifiedBadge => 'تأییدشده';

  @override
  String get specUnverifiedBadge => 'تأییدنشده';

  @override
  String get specUnverifiedNotice => 'لطفاً با منبع رسمی تأیید کنید.';

  @override
  String get specOfficialSource => 'منبع رسمی';

  @override
  String specLastVerified(String date) {
    return 'آخرین تأیید $date';
  }

  @override
  String get specUsePhoto => 'استفاده از این عکس';

  @override
  String get specNotSpecified => 'مشخص نشده';

  @override
  String get spec_us_passport => 'گذرنامه ایالات متحده';

  @override
  String get spec_gb_passport => 'گذرنامه بریتانیا';

  @override
  String get spec_ca_passport => 'گذرنامه کانادا';

  @override
  String get spec_cn_visa => 'ویزای چین';

  @override
  String get spec_de_schengen_visa => 'آلمان — ویزای شنگن';

  @override
  String get spec_fr_schengen_visa => 'فرانسه — ویزای شنگن';

  @override
  String get spec_it_schengen_visa => 'ایتالیا — ویزای شنگن';

  @override
  String get spec_es_schengen_visa => 'اسپانیا — ویزای شنگن';

  @override
  String get captureTitle => 'عکس گرفتن';

  @override
  String get captureRationaleTitle => 'دسترسی به دوربین لازم است';

  @override
  String get captureRationaleBody =>
      'PhotoPass از دوربین شما برای گرفتن عکس گذرنامه استفاده می‌کند. عکس روی گوشی شما می‌ماند و هرگز بارگذاری نمی‌شود.';

  @override
  String get captureRationaleDenied =>
      'دسترسی به دوربین غیرفعال است. برای عکس گرفتن آن را در تنظیمات سیستم فعال کنید یا عکسی از گالری انتخاب کنید.';

  @override
  String get captureRationaleAction => 'اجازه دوربین';

  @override
  String get captureOpenSettings => 'باز کردن تنظیمات';

  @override
  String get captureCameraError =>
      'راه‌اندازی دوربین ممکن نشد. همچنان می‌توانید عکسی از گالری انتخاب کنید.';

  @override
  String get captureHintFace => 'صورت خود را در بیضی قرار دهید';

  @override
  String get captureSwitchCamera => 'تعویض دوربین';

  @override
  String get captureGallery => 'انتخاب از گالری';

  @override
  String get editorTitle => 'ویرایش عکس';

  @override
  String get editorRotate => 'چرخش ۹۰ درجه';

  @override
  String get editorAutoFit => 'تنظیم خودکار با چهره';

  @override
  String get editorApply => 'برش عکس';

  @override
  String get retouchTitle => 'پس‌زمینه و تنظیمات';

  @override
  String get retouchBackground => 'پس‌زمینه';

  @override
  String get retouchRemoveBackground => 'جایگزینی پس‌زمینه';

  @override
  String get retouchRemoveBackgroundHint =>
      'پس‌زمینه ساده پشت شما را با یک رنگ تمیز پر می‌کند.';

  @override
  String retouchTolerance(int value) {
    return 'حد تحمل تشخیص: $value';
  }

  @override
  String get retouchBackgroundColor => 'رنگ جایگزین';

  @override
  String get retouchAdjustments => 'تنظیمات';

  @override
  String get retouchBrightness => 'روشنایی';

  @override
  String get retouchContrast => 'کنتراست';

  @override
  String get retouchSaturation => 'رنگ';

  @override
  String get retouchLocalNote => 'همه پردازش‌ها روی همین دستگاه انجام می‌شود.';

  @override
  String get retouchApply => 'ادامه';

  @override
  String get complianceTitle => 'بررسی انطباق';

  @override
  String get complianceIntro =>
      'این بررسی‌ها عکس شما را با الزامات رسمی مقایسه می‌کنند. این‌ها راهنما هستند و پذیرش را تضمین نمی‌کنند.';

  @override
  String get complianceContinue => 'ادامه به خروجی';

  @override
  String get complianceMeasured => 'اندازه‌گیری‌شده';

  @override
  String get complianceDimensions => 'اندازه عکس';

  @override
  String get complianceDimensionsDetail =>
      'عکس باید دقیقاً ابعاد پیکسلی موردنظر را داشته باشد.';

  @override
  String get complianceFace => 'یک چهره شناسایی شد';

  @override
  String get complianceFaceDetail => 'عکس باید دقیقاً یک نفر را شامل شود.';

  @override
  String get complianceHeadHeight => 'ارتفاع سر';

  @override
  String get complianceHeadHeightDetail =>
      'ارتفاع سر باید در محدوده رسمی باشد.';

  @override
  String get complianceEyeLine => 'محل خط چشم';

  @override
  String get complianceEyeLineDetail =>
      'چشم‌ها باید در ارتفاع رسمی از پایین قرار گیرند.';

  @override
  String get complianceBackground => 'رنگ و یکنواختی پس‌زمینه';

  @override
  String get complianceBackgroundDetail =>
      'پس‌زمینه باید ساده و مطابق با رنگ موردنظر باشد.';

  @override
  String get complianceGlasses => 'عینک';

  @override
  String get complianceGlassesAllowed => 'برای این سند عینک مجاز است.';

  @override
  String get complianceGlassesForbidden => 'برای این سند عینک مجاز نیست.';

  @override
  String get complianceFileSize => 'حجم پرونده';

  @override
  String get complianceFileSizeDetail =>
      'حجم پرونده باید کمتر از حد رسمی باشد.';

  @override
  String get exportTitle => 'خروجی';

  @override
  String exportSizeLabel(int width, int height) {
    return '$width × $height پیکسل';
  }

  @override
  String exportDetails(String mm, String dpi) {
    return '$mm میلی‌متر در $dpi DPI';
  }

  @override
  String get exportSavePhoto => 'ذخیره عکس';

  @override
  String get exportSavePhotoHint =>
      'عکس را با اندازه دقیق در گالری شما ذخیره می‌کند.';

  @override
  String get exportShare => 'اشتراک‌گذاری';

  @override
  String get exportShareHint => 'عکس نهایی را به برنامه دیگری ارسال می‌کند.';

  @override
  String get exportDoneShare => 'به اشتراک گذاشته شد.';

  @override
  String exportFileSizeLimit(int kb) {
    return 'حداکثر حجم پرونده: $kb KB';
  }

  @override
  String get exportPdf => 'PDF (آماده چاپ)';

  @override
  String get exportPdfHint => 'یک عکس در اندازه فیزیکی دقیق، آماده چاپ.';

  @override
  String get exportPrintSheetTitle => 'برگه‌های چاپ';

  @override
  String exportPrintSheet(String size) {
    return 'برگه چاپ — $size';
  }

  @override
  String get exportPrintSheetHint => 'چند عکس چیده‌شده روی یک برگه کاغذ عکس.';

  @override
  String get exportDoneSave => 'ذخیره شد.';

  @override
  String get exportDonePdf => 'PDF آماده اشتراک‌گذاری است.';

  @override
  String get exportDoneSheet => 'برگه چاپ آماده اشتراک‌گذاری است.';

  @override
  String get exportLocalNote =>
      'عکس‌ها روی همین دستگاه ساخته می‌شوند. هیچ چیزی بارگذاری نمی‌شود.';

  @override
  String get historyDelete => 'حذف';

  @override
  String get settingsPrivacy => 'حریم خصوصی';

  @override
  String get settingsClearHistoryHint =>
      'همه عکس‌های ذخیره‌شده را از این دستگاه حذف می‌کند.';

  @override
  String get settingsClearHistoryConfirm =>
      'این کار همه عکس‌های ذخیره‌شده در برنامه را برای همیشه حذف می‌کند. این کار قابل بازگشت نیست.';

  @override
  String get settingsClearHistoryAction => 'حذف همه';

  @override
  String get privacyPolicyBody =>
      'PhotoPass عکس‌های شما را کاملاً روی همین دستگاه پردازش می‌کند.\n\n• عکس‌ها هرگز به هیچ سروری بارگذاری نمی‌شوند.\n• برنامه هیچ آگهی، تحلیل یا ردیابی ندارد.\n• نیازی به حساب یا ورود نیست.\n• عکس‌های ذخیره‌شده فقط در فضای خصوصی برنامه نگهداری می‌شوند.\n• تنها دسترسی شبکه، باز کردن پیوندهای منابع رسمی دولتی در مرورگر شماست.\n• حذف برنامه همه داده‌های آن را از بین می‌برد.';

  @override
  String get settingsAppearance => 'ظاهر';

  @override
  String get settingsGeneral => 'عمومی';

  @override
  String get settingsLanguage => 'زبان';

  @override
  String get settingsThemeLight => 'روشن';

  @override
  String get settingsThemeDark => 'تیره';

  @override
  String get settingsThemeSystem => 'سیستم';

  @override
  String get settingsPrivacyPolicy => 'سیاست حریم خصوصی';

  @override
  String get settingsTerms => 'شرایط استفاده';

  @override
  String get settingsRateApp => 'امتیاز دادن به برنامه';

  @override
  String get settingsClearHistory => 'حذف همه عکس‌های ذخیره‌شده';

  @override
  String get settingsAbout => 'درباره';

  @override
  String settingsVersion(String version) {
    return 'نسخه $version';
  }

  @override
  String get disclaimer =>
      'الزامات ممکن است تغییر کنند. همیشه منبع رسمی را بررسی کنید. PhotoPass نمی‌تواند پذیرش را تضمین کند.';

  @override
  String get homeHeadline => 'عکس گذرنامه منطبق بسازید';

  @override
  String get homeCreatePhoto => 'عکس بسازید';

  @override
  String get homeRecentTitle => 'اخیر';

  @override
  String get homeFavoritesTitle => 'علاقه‌مندی‌ها';

  @override
  String get homeYourPhotosTitle => 'عکس‌های شما';

  @override
  String get homeYourPhotosEmpty =>
      'عکس‌هایی که می‌سازید اینجا نمایش داده می‌شوند.';

  @override
  String get specFavoriteAdd => 'افزودن به علاقه‌مندی‌ها';

  @override
  String get specFavoriteRemove => 'حذف از علاقه‌مندی‌ها';

  @override
  String get editorModeCrop => 'برش';

  @override
  String get editorModeBackground => 'پس‌زمینه';

  @override
  String get editorModeAdjust => 'تنظیم';

  @override
  String get editorReset => 'بازنشانی';

  @override
  String get editorDiscardTitle => 'تغییرات نادیده گرفته شود؟';

  @override
  String get editorDiscardBody => 'برش و تنظیمات شما از بین خواهد رفت.';

  @override
  String get editorDiscardConfirm => 'نادیده گرفتن';

  @override
  String get captureFlash => 'فلش';

  @override
  String get complianceActionRetake =>
      'عکس را با نورپردازی یکنواخت‌تر دوباره بگیرید.';

  @override
  String get complianceActionBackground =>
      'پس‌زمینه را عوض کنید یا جلوی دیواری ساده دوباره عکس بگیرید.';

  @override
  String get complianceActionCenter =>
      'صورت خود را وسط قرار دهید، از تنظیم خودکار استفاده کنید و سپس دوباره عکس بگیرید.';

  @override
  String get complianceActionDimensions =>
      'برای تولید اندازه دقیق موردنظر دوباره خروجی بگیرید.';

  @override
  String get complianceActionFilesize =>
      'برای ماندن زیر حد حجم، به‌صورت JPEG خروجی بگیرید.';

  @override
  String get exportAdvancedDetails => 'جزئیات';

  @override
  String get historyMissingPhoto => 'پرونده عکس موجود نیست';

  @override
  String get swatchRequired => 'الزامی';

  @override
  String get swatchSuggested => 'پیشنهادی';

  @override
  String get editorCropHint =>
      'برای جابه‌جایی بکشید و برای بزرگ‌نمایی دو انگشت بگذارید.';

  @override
  String get historyReopen => 'باز کردن';

  @override
  String get historyReopenHint => 'این عکس را در ویرایشگر باز می‌کند.';
}
