// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'PhotoPass';

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navHistory => 'السجل';

  @override
  String get navSettings => 'الإعدادات';

  @override
  String get onboardingPrivacyTitle => 'لن تغادر صورك هاتفك أبدًا';

  @override
  String get onboardingPrivacyBody =>
      'يتولى فوتو باس اكتشاف الوجوه وإزالة الخلفية وتصدير الصورة بالكامل على جهازك. لا حساب، ولا رفع إلى السحابة، ولا تحليلات لصورك.';

  @override
  String get onboardingHowTitle => 'ثلاث خطوات بسيطة';

  @override
  String get onboardingHowBody =>
      'اختر بلدك ونوع المستند، ثم صوّر صورة أو اختر واحدة من معرضك، وبعد ذلك صدّر صورة متوافقة وجاهزة للطباعة.';

  @override
  String get onboardingLanguageTitle => 'اختر لغتك';

  @override
  String get commonContinue => 'متابعة';

  @override
  String get commonSkip => 'تخطٍ';

  @override
  String get commonStart => 'البدء';

  @override
  String get commonBack => 'رجوع';

  @override
  String get commonCancel => 'إلغاء';

  @override
  String get commonRetry => 'أعد المحاولة';

  @override
  String get commonClose => 'إغلاق';

  @override
  String get errorGenericTitle => 'حدث خطأ ما';

  @override
  String get errorGenericBody => 'يرجى المحاولة مرة أخرى.';

  @override
  String get placeholderBody => 'ستظهر هذه الشاشة في مرحلة بناء لاحقة.';

  @override
  String get homeSearchHint => 'ابحث عن بلد أو مستند';

  @override
  String get homePopularTitle => 'الشائع';

  @override
  String get homePassport => 'جواز السفر';

  @override
  String get homeVisa => 'التأشيرة';

  @override
  String get homeIdCard => 'بطاقة الهوية';

  @override
  String get homeCustomSize => 'مقاس مخصص';

  @override
  String get historyEmptyTitle => 'لا توجد صور بعد';

  @override
  String get historyEmptyBody => 'ستظهر الصور التي تنشئها هنا.';

  @override
  String get countrySelectTitle => 'البلد والمستند';

  @override
  String get countrySearchHint => 'ابحث عن بلد';

  @override
  String get countryNoResults => 'لا توجد بلدان مطابقة';

  @override
  String countryDocumentsCount(int count) {
    return '$count مستندات';
  }

  @override
  String get specSizeLabel => 'المقاس';

  @override
  String get specBackgroundLabel => 'الخلفية';

  @override
  String get specDpiLabel => 'الدقة';

  @override
  String get specFormatsLabel => 'الصيغ';

  @override
  String get specHeadHeightLabel => 'ارتفاع الرأس';

  @override
  String get specEyeLineLabel => 'ارتفاع العينين من الأسفل';

  @override
  String get specGlassesAllowed => 'النظارات مسموحة';

  @override
  String get specGlassesNotAllowed => 'النظارات غير مسموحة';

  @override
  String get specMaxFileSizeLabel => 'أقصى حجم للملف';

  @override
  String get specVerifiedBadge => 'موثّق';

  @override
  String get specUnverifiedBadge => 'غير موثّق';

  @override
  String get specUnverifiedNotice => 'يرجى التأكد من المصدر الرسمي.';

  @override
  String get specOfficialSource => 'المصدر الرسمي';

  @override
  String specLastVerified(String date) {
    return 'آخر تحقق $date';
  }

  @override
  String get specUsePhoto => 'استخدام هذه الصورة';

  @override
  String get specNotSpecified => 'غير محدد';

  @override
  String get spec_us_passport => 'جواز سفر الولايات المتحدة';

  @override
  String get spec_gb_passport => 'جواز سفر المملكة المتحدة';

  @override
  String get spec_ca_passport => 'جواز سفر كندا';

  @override
  String get spec_cn_visa => 'تأشيرة الصين';

  @override
  String get spec_de_schengen_visa => 'ألمانيا — تأشيرة شنغن';

  @override
  String get spec_fr_schengen_visa => 'فرنسا — تأشيرة شنغن';

  @override
  String get spec_it_schengen_visa => 'إيطاليا — تأشيرة شنغن';

  @override
  String get spec_es_schengen_visa => 'إسبانيا — تأشيرة شنغن';

  @override
  String get captureTitle => 'التقاط صورة';

  @override
  String get captureRationaleTitle => 'الوصول إلى الكاميرا مطلوب';

  @override
  String get captureRationaleBody =>
      'يستخدم PhotoPass الكاميرا لالتقاط صورة جواز السفر. تبقى الصورة على هاتفك ولا تُرفع أبدًا.';

  @override
  String get captureRationaleDenied =>
      'الوصول إلى الكاميرا معطّل. فعّله من إعدادات النظام لالتقاط صورة، أو اختر واحدة من معرض الصور.';

  @override
  String get captureRationaleAction => 'السماح بالكاميرا';

  @override
  String get captureOpenSettings => 'فتح الإعدادات';

  @override
  String get captureCameraError =>
      'تعذّر تشغيل الكاميرا. يمكنك الاختيار من معرض الصور.';

  @override
  String get captureHintFace => 'ضع وجهك داخل البيضاوي';

  @override
  String get captureSwitchCamera => 'تبديل الكاميرا';

  @override
  String get captureGallery => 'اختيار من المعرض';

  @override
  String get editorTitle => 'تحرير الصورة';

  @override
  String get editorRotate => 'تدوير 90°';

  @override
  String get editorAutoFit => 'ملاءمة تلقائية للوجه';

  @override
  String get editorApply => 'قص الصورة';

  @override
  String get retouchTitle => 'الخلفية والتعديلات';

  @override
  String get retouchBackground => 'الخلفية';

  @override
  String get retouchRemoveBackground => 'استبدال الخلفية';

  @override
  String get retouchRemoveBackgroundHint =>
      'يملأ الخلفية العادية خلفك بلون نظيف.';

  @override
  String retouchTolerance(int value) {
    return 'حد التحمّل في الكشف: $value';
  }

  @override
  String get retouchBackgroundColor => 'لون الاستبدال';

  @override
  String get retouchAdjustments => 'التعديلات';

  @override
  String get retouchBrightness => 'السطوع';

  @override
  String get retouchContrast => 'التباين';

  @override
  String get retouchSaturation => 'الألوان';

  @override
  String get retouchLocalNote => 'تتم جميع المعالجات على هذا الجهاز.';

  @override
  String get retouchApply => 'متابعة';

  @override
  String get complianceTitle => 'فحص المطابقة';

  @override
  String get complianceIntro =>
      'تقارن هذه الفحوصات صورتك بالمتطلبات الرسمية. إنها إرشادية ولا تضمن القبول.';

  @override
  String get complianceContinue => 'المتابعة إلى التصدير';

  @override
  String get complianceMeasured => 'تم القياس';

  @override
  String get complianceDimensions => 'مقاس الصورة';

  @override
  String get complianceDimensionsDetail =>
      'يجب أن يكون مقاس الصورة بالبكسل مطابقًا تمامًا للمطلوب.';

  @override
  String get complianceFace => 'تم اكتشاف وجه واحد';

  @override
  String get complianceFaceDetail => 'يجب أن تحتوي الصورة على شخص واحد بالضبط.';

  @override
  String get complianceHeadHeight => 'ارتفاع الرأس';

  @override
  String get complianceHeadHeightDetail =>
      'يجب أن يقع ارتفاع الرأس ضمن النطاق الرسمي.';

  @override
  String get complianceEyeLine => 'موضع خط العينين';

  @override
  String get complianceEyeLineDetail =>
      'يجب أن تكون العينان على الارتفاع الرسمي من الأسفل.';

  @override
  String get complianceBackground => 'لون الخلفية وتجانسها';

  @override
  String get complianceBackgroundDetail =>
      'يجب أن تكون الخلفية بلون واحد ومطابقة للون المطلوب.';

  @override
  String get complianceGlasses => 'النظارات';

  @override
  String get complianceGlassesAllowed => 'النظارات مسموحة لهذا المستند.';

  @override
  String get complianceGlassesForbidden => 'النظارات غير مسموحة لهذا المستند.';

  @override
  String get complianceFileSize => 'حجم الملف';

  @override
  String get complianceFileSizeDetail =>
      'يجب أن يبقى حجم الملف دون الحد الرسمي.';

  @override
  String get exportTitle => 'تصدير';

  @override
  String exportSizeLabel(int width, int height) {
    return '$width × $height بكسل';
  }

  @override
  String exportDetails(String mm, String dpi) {
    return '$mm مم عند $dpi DPI';
  }

  @override
  String get exportSavePhoto => 'حفظ الصورة';

  @override
  String get exportSavePhotoHint => 'يحفظ الصورة بالمقاس الدقيق في معرض الصور.';

  @override
  String get exportShare => 'مشاركة';

  @override
  String get exportShareHint => 'يُرسل الصورة الجاهزة إلى تطبيق آخر.';

  @override
  String get exportDoneShare => 'تمت المشاركة.';

  @override
  String exportFileSizeLimit(int kb) {
    return 'أقصى حجم للملف: $kb KB';
  }

  @override
  String get exportPdf => 'PDF (جاهز للطباعة)';

  @override
  String get exportPdfHint =>
      'صورة واحدة بالحجم الفيزيائي الدقيق، جاهزة للطباعة.';

  @override
  String get exportPrintSheetTitle => 'أوراق الطباعة';

  @override
  String exportPrintSheet(String size) {
    return 'ورقة طباعة — $size';
  }

  @override
  String get exportPrintSheetHint => 'عدة صور مرتبة على ورقة واحدة.';

  @override
  String get exportDoneSave => 'تم الحفظ.';

  @override
  String get exportDonePdf => 'ملف PDF جاهز للمشاركة.';

  @override
  String get exportDoneSheet => 'ورقة الطباعة جاهزة للمشاركة.';

  @override
  String get exportLocalNote => 'تُنشئ الصور على هذا الجهاز. لا يُرفع أي شيء.';

  @override
  String get historyDelete => 'حذف';

  @override
  String get settingsPrivacy => 'الخصوصية';

  @override
  String get settingsClearHistoryHint =>
      'يحذف جميع الصور المحفوظة من هذا الجهاز.';

  @override
  String get settingsClearHistoryConfirm =>
      'سيؤدي هذا إلى حذف كل صورة محفوظة في التطبيق نهائيًا. لا يمكن التراجع عن ذلك.';

  @override
  String get settingsClearHistoryAction => 'حذف الكل';

  @override
  String get privacyPolicyBody =>
      'PhotoPass تعالج صورك بالكامل على هذا الجهاز.\n\n• لا تُرفع الصور إلى أي خادم أبدًا.\n• لا يحتوي التطبيق على إعلانات أو تحليلات أو تتبّع.\n• لا حاجة إلى حساب أو تسجيل دخول.\n• تُخزَّن الصور المحفوظة في التخزين الخاص بالتطبيق فقط.\n• الوصول الوحيد إلى الشبكة هو فتح روابط المصادر الحكومية الرسمية في متصفحك.\n• حذف التطبيق يزيل جميع بياناته.';

  @override
  String get settingsAppearance => 'المظهر';

  @override
  String get settingsGeneral => 'عام';

  @override
  String get settingsLanguage => 'اللغة';

  @override
  String get settingsThemeLight => 'فاتح';

  @override
  String get settingsThemeDark => 'داكن';

  @override
  String get settingsThemeSystem => 'النظام';

  @override
  String get settingsPrivacyPolicy => 'سياسة الخصوصية';

  @override
  String get settingsTerms => 'شروط الاستخدام';

  @override
  String get settingsRateApp => 'قيّم التطبيق';

  @override
  String get settingsClearHistory => 'حذف جميع الصور المحفوظة';

  @override
  String get settingsAbout => 'حول';

  @override
  String settingsVersion(String version) {
    return 'الإصدار $version';
  }

  @override
  String get disclaimer =>
      'قد تتغير المتطلبات. تحقّق دائمًا من المصدر الرسمي. لا يمكن لـ PhotoPass ضمان القبول.';

  @override
  String get homeHeadline => 'أنشئ صورة جواز السفر المتوافقة مع المتطلبات';

  @override
  String get homeCreatePhoto => 'إنشاء صورة';

  @override
  String get homeRecentTitle => 'الأخيرة';

  @override
  String get homeFavoritesTitle => 'المفضلة';

  @override
  String get homeYourPhotosTitle => 'صورك';

  @override
  String get homeYourPhotosEmpty => 'ستظهر الصور التي تنشئها هنا.';

  @override
  String get specFavoriteAdd => 'إضافة إلى المفضلة';

  @override
  String get specFavoriteRemove => 'إزالة من المفضلة';

  @override
  String get editorModeCrop => 'قص';

  @override
  String get editorModeBackground => 'الخلفية';

  @override
  String get editorModeAdjust => 'تعديل';

  @override
  String get editorReset => 'إعادة تعيين';

  @override
  String get editorDiscardTitle => 'تجاهل التغييرات؟';

  @override
  String get editorDiscardBody => 'ستُفقد عملية القص والتعديلات التي أجريتها.';

  @override
  String get editorDiscardConfirm => 'تجاهل';

  @override
  String get captureFlash => 'الفلاش';

  @override
  String get complianceActionRetake => 'أعد التقاط الصورة بإضاءة أكثر تجانسًا.';

  @override
  String get complianceActionBackground =>
      'استبدل الخلفية أو أعد التقاط الصورة أمام جدار سادة.';

  @override
  String get complianceActionCenter =>
      'توسّط وجهك، واستخدم الملاءمة التلقائية، ثم أعد التقاط الصورة.';

  @override
  String get complianceActionDimensions =>
      'أعد التصدير لإنتاج المقاس المطلوب بدقة.';

  @override
  String get complianceActionFilesize =>
      'صدّر الصورة بصيغة JPEG ليبقى حجمها دون الحد الأقصى.';

  @override
  String get exportAdvancedDetails => 'التفاصيل';

  @override
  String get historyMissingPhoto => 'ملف الصورة مفقود';

  @override
  String get swatchRequired => 'مطلوب';

  @override
  String get swatchSuggested => 'مقترح';

  @override
  String get editorCropHint => 'اسحب للتحريك، وقرّب بإصبعين للتكبير.';

  @override
  String get historyReopen => 'فتح';

  @override
  String get historyReopenHint => 'يفتح هذه الصورة في المحرر.';
}
