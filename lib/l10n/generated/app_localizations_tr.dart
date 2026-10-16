// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'PhotoPass';

  @override
  String get navHome => 'Ana Sayfa';

  @override
  String get navHistory => 'Geçmiş';

  @override
  String get navSettings => 'Ayarlar';

  @override
  String get onboardingPrivacyTitle =>
      'Fotoğraflarınız asla telefonunuzdan çıkmaz';

  @override
  String get onboardingPrivacyBody =>
      'PhotoPass yüzleri algılar, arka planı kaldırır ve fotoğrafınızı tamamen cihazınızda dışa aktarır. Hesap yok, buluta yükleme yok, görüntüleriniz için analitik yok.';

  @override
  String get onboardingHowTitle => 'Üç basit adım';

  @override
  String get onboardingHowBody =>
      'Ülkenizi ve belge türünü seçin, bir fotoğraf çekin veya seçin, ardından uygun ve baskıya hazır bir görüntüyü dışa aktarın.';

  @override
  String get onboardingLanguageTitle => 'Dilinizi seçin';

  @override
  String get commonContinue => 'Devam';

  @override
  String get commonSkip => 'Atla';

  @override
  String get commonStart => 'Başlayın';

  @override
  String get commonBack => 'Geri';

  @override
  String get commonCancel => 'İptal';

  @override
  String get commonRetry => 'Tekrar deneyin';

  @override
  String get commonClose => 'Kapat';

  @override
  String get errorGenericTitle => 'Bir şeyler ters gitti';

  @override
  String get errorGenericBody => 'Lütfen tekrar deneyin.';

  @override
  String get placeholderBody =>
      'Bu ekran daha sonraki bir derleme aşamasında gelecek.';

  @override
  String get homeSearchHint => 'Ülke veya belge ara';

  @override
  String get homePopularTitle => 'Popüler';

  @override
  String get homePassport => 'Pasaport';

  @override
  String get homeVisa => 'Vize';

  @override
  String get homeIdCard => 'Kimlik kartı';

  @override
  String get homeCustomSize => 'Özel boyut';

  @override
  String get historyEmptyTitle => 'Henüz fotoğraf yok';

  @override
  String get historyEmptyBody => 'Oluşturduğunuz fotoğraflar burada görünecek.';

  @override
  String get countrySelectTitle => 'Ülke ve belge';

  @override
  String get countrySearchHint => 'Ülke ara';

  @override
  String get countryNoResults => 'Eşleşen ülke yok';

  @override
  String countryDocumentsCount(int count) {
    return '$count belge';
  }

  @override
  String get specSizeLabel => 'Boyut';

  @override
  String get specBackgroundLabel => 'Arka plan';

  @override
  String get specDpiLabel => 'Çözünürlük';

  @override
  String get specFormatsLabel => 'Biçimler';

  @override
  String get specHeadHeightLabel => 'Baş yüksekliği';

  @override
  String get specEyeLineLabel => 'Alttan göz hattı';

  @override
  String get specGlassesAllowed => 'Gözlük izinli';

  @override
  String get specGlassesNotAllowed => 'Gözlük izinli değil';

  @override
  String get specMaxFileSizeLabel => 'Azami dosya boyutu';

  @override
  String get specVerifiedBadge => 'Doğrulandı';

  @override
  String get specUnverifiedBadge => 'Doğrulanmadı';

  @override
  String get specUnverifiedNotice => 'Lütfen resmi kaynaktan teyit edin.';

  @override
  String get specOfficialSource => 'Resmi kaynak';

  @override
  String specLastVerified(String date) {
    return 'Son doğrulama $date';
  }

  @override
  String get specUsePhoto => 'Bu fotoğrafı kullan';

  @override
  String get specNotSpecified => 'Belirtilmemiş';

  @override
  String get spec_us_passport => 'Amerika Birleşik Devletleri pasaportu';

  @override
  String get spec_gb_passport => 'Birleşik Krallık pasaportu';

  @override
  String get spec_ca_passport => 'Kanada pasaportu';

  @override
  String get spec_cn_visa => 'Çin vizesi';

  @override
  String get spec_de_schengen_visa => 'Almanya — Schengen vizesi';

  @override
  String get spec_fr_schengen_visa => 'Fransa — Schengen vizesi';

  @override
  String get spec_it_schengen_visa => 'İtalya — Schengen vizesi';

  @override
  String get spec_es_schengen_visa => 'İspanya — Schengen vizesi';

  @override
  String get captureTitle => 'Fotoğraf çekin';

  @override
  String get captureRationaleTitle => 'Kamera erişimi gerekli';

  @override
  String get captureRationaleBody =>
      'PhotoPass, pasaport fotoğrafı çekmek için kameranızı kullanır. Fotoğraf telefonunuzda kalır ve asla yüklenmez.';

  @override
  String get captureRationaleDenied =>
      'Kamera erişimi kapalı. Fotoğraf çekmek için sistem ayarlarından etkinleştirin veya galerinizden bir tane seçin.';

  @override
  String get captureRationaleAction => 'Kameraya izin ver';

  @override
  String get captureOpenSettings => 'Ayarları aç';

  @override
  String get captureCameraError =>
      'Kamera başlatılamadı. Galerinizden bir fotoğraf seçmeye devam edebilirsiniz.';

  @override
  String get captureHintFace => 'Yüzünüzü ovalin içine yerleştirin';

  @override
  String get captureSwitchCamera => 'Kamerayı değiştir';

  @override
  String get captureGallery => 'Galeriden seç';

  @override
  String get editorTitle => 'Fotoğrafı düzenle';

  @override
  String get editorRotate => '90° döndür';

  @override
  String get editorAutoFit => 'Yüze otomatik sığdır';

  @override
  String get editorApply => 'Fotoğrafı kırp';

  @override
  String get retouchTitle => 'Arka plan ve ayarlamalar';

  @override
  String get retouchBackground => 'Arka plan';

  @override
  String get retouchRemoveBackground => 'Arka planı değiştir';

  @override
  String get retouchRemoveBackgroundHint =>
      'Arkanızdaki düz arka planı temiz bir renkle doldurur.';

  @override
  String retouchTolerance(int value) {
    return 'Algılama toleransı: $value';
  }

  @override
  String get retouchBackgroundColor => 'Değiştirme rengi';

  @override
  String get retouchAdjustments => 'Ayarlamalar';

  @override
  String get retouchBrightness => 'Parlaklık';

  @override
  String get retouchContrast => 'Kontrast';

  @override
  String get retouchSaturation => 'Renk';

  @override
  String get retouchLocalNote => 'Tüm işlem bu cihazda gerçekleştirilir.';

  @override
  String get retouchApply => 'Devam';

  @override
  String get complianceTitle => 'Uygunluk denetimi';

  @override
  String get complianceIntro =>
      'Bu denetimler fotoğrafınızı resmi gerekliliklerle karşılaştırır. Bunlar rehber niteliğindedir; kabul garantisi değildir.';

  @override
  String get complianceContinue => 'Dışa aktarmaya devam et';

  @override
  String get complianceMeasured => 'Ölçüldü';

  @override
  String get complianceDimensions => 'Fotoğraf boyutu';

  @override
  String get complianceDimensionsDetail =>
      'Fotoğraf, tam olarak gereken piksel boyutlarında olmalıdır.';

  @override
  String get complianceFace => 'Bir yüz algılandı';

  @override
  String get complianceFaceDetail =>
      'Fotoğraf tam olarak bir kişi içermelidir.';

  @override
  String get complianceHeadHeight => 'Baş yüksekliği';

  @override
  String get complianceHeadHeightDetail =>
      'Baş yüksekliği resmi aralıkta olmalıdır.';

  @override
  String get complianceEyeLine => 'Göz hattı konumu';

  @override
  String get complianceEyeLineDetail =>
      'Gözler, alttan resmi yükseklikte olmalıdır.';

  @override
  String get complianceBackground => 'Arka plan rengi ve bütünlüğü';

  @override
  String get complianceBackgroundDetail =>
      'Arka plan düz olmalı ve gereken renk ile uyumlu olmalıdır.';

  @override
  String get complianceGlasses => 'Gözlük';

  @override
  String get complianceGlassesAllowed => 'Bu belge için gözlük izinlidir.';

  @override
  String get complianceGlassesForbidden =>
      'Bu belge için gözlük izinli değildir.';

  @override
  String get complianceFileSize => 'Dosya boyutu';

  @override
  String get complianceFileSizeDetail =>
      'Dosya, resmi boyut sınırının altında kalmalıdır.';

  @override
  String get exportTitle => 'Dışa aktar';

  @override
  String exportSizeLabel(int width, int height) {
    return '$width × $height piksel';
  }

  @override
  String exportDetails(String mm, String dpi) {
    return '$mm mm, $dpi DPI';
  }

  @override
  String get exportSavePhoto => 'Fotoğrafı kaydet';

  @override
  String get exportSavePhotoHint =>
      'Tam boyutlu fotoğrafı galerinize kaydeder.';

  @override
  String get exportShare => 'Paylaş';

  @override
  String get exportShareHint =>
      'Hazır fotoğrafı başka bir uygulamaya gönderir.';

  @override
  String get exportDoneShare => 'Paylaşıldı.';

  @override
  String exportFileSizeLimit(int kb) {
    return 'Azami dosya boyutu: $kb KB';
  }

  @override
  String get exportPdf => 'PDF (baskıya hazır)';

  @override
  String get exportPdfHint =>
      'Tam fiziksel boyutta bir fotoğraf, baskıya hazır.';

  @override
  String get exportPrintSheetTitle => 'Baskı sayfaları';

  @override
  String exportPrintSheet(String size) {
    return 'Baskı sayfası — $size';
  }

  @override
  String get exportPrintSheetHint =>
      'Tek bir fotoğraf kâğıdına yerleştirilmiş birkaç fotoğraf.';

  @override
  String get exportDoneSave => 'Kaydedildi.';

  @override
  String get exportDonePdf => 'PDF paylaşmaya hazır.';

  @override
  String get exportDoneSheet => 'Baskı sayfası paylaşmaya hazır.';

  @override
  String get exportLocalNote =>
      'Fotoğraflar bu cihazda oluşturulur. Hiçbir şey yüklenmez.';

  @override
  String get historyDelete => 'Sil';

  @override
  String get settingsPrivacy => 'Gizlilik';

  @override
  String get settingsClearHistoryHint =>
      'Bu cihazdaki tüm kayıtlı fotoğrafları siler.';

  @override
  String get settingsClearHistoryConfirm =>
      'Bu işlem, uygulamadaki tüm kayıtlı fotoğrafları kalıcı olarak siler. Bu geri alınamaz.';

  @override
  String get settingsClearHistoryAction => 'Tümünü sil';

  @override
  String get privacyPolicyBody =>
      'PhotoPass, fotoğraflarınızı tamamen bu cihazda işler.\n\n• Fotoğraflar hiçbir zaman hiçbir sunucuya yüklenmez.\n• Uygulamada reklam, analitik veya izleme yoktur.\n• Hesap veya oturum açma gerekmez.\n• Kayıtlı fotoğraflar yalnızca uygulamanın özel deposunda tutulur.\n• Tek ağ erişimi, resmi hükümet kaynaklarını tarayıcınızda açmaktır.\n• Uygulamayı silmek, tüm verilerini de siler.';

  @override
  String get settingsAppearance => 'Görünüm';

  @override
  String get settingsGeneral => 'Genel';

  @override
  String get settingsLanguage => 'Dil';

  @override
  String get settingsThemeLight => 'Açık';

  @override
  String get settingsThemeDark => 'Koyu';

  @override
  String get settingsThemeSystem => 'Sistem';

  @override
  String get settingsPrivacyPolicy => 'Gizlilik politikası';

  @override
  String get settingsTerms => 'Kullanım koşulları';

  @override
  String get settingsRateApp => 'Uygulamayı puanlayın';

  @override
  String get settingsClearHistory => 'Tüm kayıtlı fotoğrafları sil';

  @override
  String get settingsAbout => 'Hakkında';

  @override
  String settingsVersion(String version) {
    return 'Sürüm $version';
  }

  @override
  String get disclaimer =>
      'Gereklilikler değişebilir. Her zaman resmi kaynağı kontrol edin. PhotoPass, kabulü garanti edemez.';

  @override
  String get homeHeadline => 'Uygun pasaport fotoğrafı oluşturun';

  @override
  String get homeCreatePhoto => 'Fotoğraf oluştur';

  @override
  String get homeRecentTitle => 'Son eklenenler';

  @override
  String get homeFavoritesTitle => 'Favoriler';

  @override
  String get homeYourPhotosTitle => 'Fotoğraflarınız';

  @override
  String get homeYourPhotosEmpty =>
      'Oluşturduğunuz fotoğraflar burada görünecek.';

  @override
  String get specFavoriteAdd => 'Favorilere ekle';

  @override
  String get specFavoriteRemove => 'Favorilerden kaldır';

  @override
  String get editorModeCrop => 'Kırpma';

  @override
  String get editorModeBackground => 'Arka plan';

  @override
  String get editorModeAdjust => 'Ayarlamalar';

  @override
  String get editorReset => 'Sıfırla';

  @override
  String get editorDiscardTitle => 'Değişiklikler iptal edilsin mi?';

  @override
  String get editorDiscardBody => 'Kırpmanız ve ayarlamalarınız kaybolacak.';

  @override
  String get editorDiscardConfirm => 'İptal et';

  @override
  String get captureFlash => 'Flaş';

  @override
  String get complianceActionRetake =>
      'Fotoğrafı daha dengeli ışıkla yeniden çekin.';

  @override
  String get complianceActionBackground =>
      'Arka planı değiştirin veya düz bir duvar önünde yeniden çekin.';

  @override
  String get complianceActionCenter =>
      'Yüzünüzü ortala, otomatik sığdırma özelliğini kullanın, ardından yeniden çekin.';

  @override
  String get complianceActionDimensions =>
      'Tam olarak gereken boyutu elde etmek için yeniden dışa aktarın.';

  @override
  String get complianceActionFilesize =>
      'Boyut sınırının altında kalmak için JPEG olarak dışa aktarın.';

  @override
  String get exportAdvancedDetails => 'Ayrıntılar';

  @override
  String get historyMissingPhoto => 'Fotoğraf dosyası bulunamadı';

  @override
  String get swatchRequired => 'Zorunlu';

  @override
  String get swatchSuggested => 'Önerilen';

  @override
  String get editorCropHint =>
      'Taşımak için sürükleyin, yakınlaştırmak için sıkıştırın.';

  @override
  String get historyReopen => 'Aç';

  @override
  String get historyReopenHint => 'Bu fotoğrafı düzenleyicide açar.';
}
