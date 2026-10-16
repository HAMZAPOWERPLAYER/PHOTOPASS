// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appTitle => 'PhotoPass';

  @override
  String get navHome => 'Beranda';

  @override
  String get navHistory => 'Riwayat';

  @override
  String get navSettings => 'Pengaturan';

  @override
  String get onboardingPrivacyTitle =>
      'Foto Anda tidak pernah meninggalkan ponsel Anda';

  @override
  String get onboardingPrivacyBody =>
      'PhotoPass mendeteksi wajah, menghapus latar belakang, dan mengekspor foto sepenuhnya di perangkat Anda. Tanpa akun, tanpa unggahan cloud, dan tanpa analitik pada gambar Anda.';

  @override
  String get onboardingHowTitle => 'Tiga langkah sederhana';

  @override
  String get onboardingHowBody =>
      'Pilih negara dan jenis dokumen, ambil atau pilih foto, lalu ekspor gambar yang sesuai standar dan siap cetak.';

  @override
  String get onboardingLanguageTitle => 'Pilih bahasa Anda';

  @override
  String get commonContinue => 'Lanjutkan';

  @override
  String get commonSkip => 'Lewati';

  @override
  String get commonStart => 'Mulai';

  @override
  String get commonBack => 'Kembali';

  @override
  String get commonCancel => 'Batal';

  @override
  String get commonRetry => 'Coba lagi';

  @override
  String get commonClose => 'Tutup';

  @override
  String get errorGenericTitle => 'Terjadi kesalahan';

  @override
  String get errorGenericBody => 'Silakan coba lagi.';

  @override
  String get placeholderBody =>
      'Layar ini akan hadir pada tahap pembangunan berikutnya.';

  @override
  String get homeSearchHint => 'Cari negara atau dokumen';

  @override
  String get homePopularTitle => 'Populer';

  @override
  String get homePassport => 'Paspor';

  @override
  String get homeVisa => 'Visa';

  @override
  String get homeIdCard => 'Kartu identitas';

  @override
  String get homeCustomSize => 'Ukuran kustom';

  @override
  String get historyEmptyTitle => 'Belum ada foto';

  @override
  String get historyEmptyBody => 'Foto yang Anda buat akan muncul di sini.';

  @override
  String get countrySelectTitle => 'Negara & dokumen';

  @override
  String get countrySearchHint => 'Cari negara';

  @override
  String get countryNoResults => 'Tidak ada negara yang cocok';

  @override
  String countryDocumentsCount(int count) {
    return '$count dokumen';
  }

  @override
  String get specSizeLabel => 'Ukuran';

  @override
  String get specBackgroundLabel => 'Latar belakang';

  @override
  String get specDpiLabel => 'Resolusi';

  @override
  String get specFormatsLabel => 'Format';

  @override
  String get specHeadHeightLabel => 'Tinggi kepala';

  @override
  String get specEyeLineLabel => 'Garis mata dari dasar';

  @override
  String get specGlassesAllowed => 'Kacamata diizinkan';

  @override
  String get specGlassesNotAllowed => 'Kacamata tidak diizinkan';

  @override
  String get specMaxFileSizeLabel => 'Ukuran berkas maksimum';

  @override
  String get specVerifiedBadge => 'Terverifikasi';

  @override
  String get specUnverifiedBadge => 'Belum terverifikasi';

  @override
  String get specUnverifiedNotice => 'Harap konfirmasikan ke sumber resmi.';

  @override
  String get specOfficialSource => 'Sumber resmi';

  @override
  String specLastVerified(String date) {
    return 'Terakhir diverifikasi $date';
  }

  @override
  String get specUsePhoto => 'Gunakan foto ini';

  @override
  String get specNotSpecified => 'Tidak ditentukan';

  @override
  String get spec_us_passport => 'Paspor Amerika Serikat';

  @override
  String get spec_gb_passport => 'Paspor Britania Raya';

  @override
  String get spec_ca_passport => 'Paspor Kanada';

  @override
  String get spec_cn_visa => 'Visa Tiongkok';

  @override
  String get spec_de_schengen_visa => 'Jerman — visa Schengen';

  @override
  String get spec_fr_schengen_visa => 'Prancis — visa Schengen';

  @override
  String get spec_it_schengen_visa => 'Italia — visa Schengen';

  @override
  String get spec_es_schengen_visa => 'Spanyol — visa Schengen';

  @override
  String get captureTitle => 'Ambil foto';

  @override
  String get captureRationaleTitle => 'Akses kamera diperlukan';

  @override
  String get captureRationaleBody =>
      'PhotoPass menggunakan kamera Anda untuk mengambil foto paspor. Foto tetap di ponsel Anda dan tidak pernah diunggah.';

  @override
  String get captureRationaleDenied =>
      'Akses kamera dinonaktifkan. Aktifkan di pengaturan sistem untuk mengambil foto, atau pilih foto dari galeri Anda.';

  @override
  String get captureRationaleAction => 'Izinkan kamera';

  @override
  String get captureOpenSettings => 'Buka pengaturan';

  @override
  String get captureCameraError =>
      'Tidak dapat memulai kamera. Anda tetap dapat memilih foto dari galeri Anda.';

  @override
  String get captureHintFace => 'Posisikan wajah Anda di dalam oval';

  @override
  String get captureSwitchCamera => 'Ganti kamera';

  @override
  String get captureGallery => 'Pilih dari galeri';

  @override
  String get editorTitle => 'Edit foto';

  @override
  String get editorRotate => 'Putar 90°';

  @override
  String get editorAutoFit => 'Sesuaikan otomatis ke wajah';

  @override
  String get editorApply => 'Pangkas foto';

  @override
  String get retouchTitle => 'Latar belakang & penyesuaian';

  @override
  String get retouchBackground => 'Latar belakang';

  @override
  String get retouchRemoveBackground => 'Ganti latar belakang';

  @override
  String get retouchRemoveBackgroundHint =>
      'Mengisi latar belakang polos di belakang Anda dengan warna yang bersih.';

  @override
  String retouchTolerance(int value) {
    return 'Toleransi deteksi: $value';
  }

  @override
  String get retouchBackgroundColor => 'Warna pengganti';

  @override
  String get retouchAdjustments => 'Penyesuaian';

  @override
  String get retouchBrightness => 'Kecerahan';

  @override
  String get retouchContrast => 'Kontras';

  @override
  String get retouchSaturation => 'Warna';

  @override
  String get retouchLocalNote => 'Semua pemrosesan terjadi di perangkat ini.';

  @override
  String get retouchApply => 'Lanjutkan';

  @override
  String get complianceTitle => 'Pemeriksaan kepatuhan';

  @override
  String get complianceIntro =>
      'Pemeriksaan ini membandingkan foto Anda dengan persyaratan resmi. Ini adalah panduan, bukan jaminan diterima.';

  @override
  String get complianceContinue => 'Lanjutkan ke ekspor';

  @override
  String get complianceMeasured => 'Terkukur';

  @override
  String get complianceDimensions => 'Ukuran foto';

  @override
  String get complianceDimensionsDetail =>
      'Foto harus memiliki dimensi piksel yang persis sesuai ketentuan.';

  @override
  String get complianceFace => 'Satu wajah terdeteksi';

  @override
  String get complianceFaceDetail => 'Foto harus berisi tepat satu orang.';

  @override
  String get complianceHeadHeight => 'Tinggi kepala';

  @override
  String get complianceHeadHeightDetail =>
      'Tinggi kepala harus berada dalam rentang resmi.';

  @override
  String get complianceEyeLine => 'Posisi garis mata';

  @override
  String get complianceEyeLineDetail =>
      'Mata harus berada pada tinggi resmi dari dasar.';

  @override
  String get complianceBackground => 'Warna & keseragaman latar belakang';

  @override
  String get complianceBackgroundDetail =>
      'Latar belakang harus polos dan sesuai dengan warna yang dipersyaratkan.';

  @override
  String get complianceGlasses => 'Kacamata';

  @override
  String get complianceGlassesAllowed =>
      'Kacamata diizinkan untuk dokumen ini.';

  @override
  String get complianceGlassesForbidden =>
      'Kacamata tidak diizinkan untuk dokumen ini.';

  @override
  String get complianceFileSize => 'Ukuran berkas';

  @override
  String get complianceFileSizeDetail =>
      'Berkas harus tetap di bawah batas ukuran resmi.';

  @override
  String get exportTitle => 'Ekspor';

  @override
  String exportSizeLabel(int width, int height) {
    return '$width × $height piksel';
  }

  @override
  String exportDetails(String mm, String dpi) {
    return '$mm mm pada $dpi DPI';
  }

  @override
  String get exportSavePhoto => 'Simpan foto';

  @override
  String get exportSavePhotoHint =>
      'Menyimpan foto berukuran persis ke galeri Anda.';

  @override
  String get exportShare => 'Bagikan';

  @override
  String get exportShareHint => 'Mengirim foto yang selesai ke aplikasi lain.';

  @override
  String get exportDoneShare => 'Dibagikan.';

  @override
  String exportFileSizeLimit(int kb) {
    return 'Ukuran berkas maksimum: $kb KB';
  }

  @override
  String get exportPdf => 'PDF (siap cetak)';

  @override
  String get exportPdfHint =>
      'Satu foto dengan ukuran fisik persis, siap dicetak.';

  @override
  String get exportPrintSheetTitle => 'Lembar cetak';

  @override
  String exportPrintSheet(String size) {
    return 'Lembar cetak — $size';
  }

  @override
  String get exportPrintSheetHint =>
      'Beberapa foto disusun di atas satu lembar kertas foto.';

  @override
  String get exportDoneSave => 'Tersimpan.';

  @override
  String get exportDonePdf => 'PDF siap dibagikan.';

  @override
  String get exportDoneSheet => 'Lembar cetak siap dibagikan.';

  @override
  String get exportLocalNote =>
      'Foto dibuat di perangkat ini. Tidak ada yang diunggah.';

  @override
  String get historyDelete => 'Hapus';

  @override
  String get settingsPrivacy => 'Privasi';

  @override
  String get settingsClearHistoryHint =>
      'Menghapus semua foto tersimpan dari perangkat ini.';

  @override
  String get settingsClearHistoryConfirm =>
      'Tindakan ini menghapus permanen setiap foto yang disimpan di aplikasi. Tindakan ini tidak dapat dibatalkan.';

  @override
  String get settingsClearHistoryAction => 'Hapus semuanya';

  @override
  String get privacyPolicyBody =>
      'PhotoPass memproses foto Anda sepenuhnya di perangkat ini.\n\n• Foto tidak pernah diunggah ke server mana pun.\n• Aplikasi ini tidak berisi iklan, analitik, atau pelacakan.\n• Tidak diperlukan akun atau login.\n• Foto tersimpan hanya berada di penyimpanan pribadi aplikasi.\n• Satu-satunya akses jaringan adalah membuka tautan sumber resmi pemerintah di browser Anda.\n• Menghapus aplikasi menghapus semua datanya.';

  @override
  String get settingsAppearance => 'Tampilan';

  @override
  String get settingsGeneral => 'Umum';

  @override
  String get settingsLanguage => 'Bahasa';

  @override
  String get settingsThemeLight => 'Terang';

  @override
  String get settingsThemeDark => 'Gelap';

  @override
  String get settingsThemeSystem => 'Sistem';

  @override
  String get settingsPrivacyPolicy => 'Kebijakan privasi';

  @override
  String get settingsTerms => 'Ketentuan penggunaan';

  @override
  String get settingsRateApp => 'Beri rating aplikasi';

  @override
  String get settingsClearHistory => 'Hapus semua foto tersimpan';

  @override
  String get settingsAbout => 'Tentang';

  @override
  String settingsVersion(String version) {
    return 'Versi $version';
  }

  @override
  String get disclaimer =>
      'Persyaratan dapat berubah. Selalu periksa sumber resmi. PhotoPass tidak dapat menjamin penerimaan.';

  @override
  String get homeHeadline => 'Buat foto paspor yang sesuai standar';

  @override
  String get homeCreatePhoto => 'Buat foto';

  @override
  String get homeRecentTitle => 'Terbaru';

  @override
  String get homeFavoritesTitle => 'Favorit';

  @override
  String get homeYourPhotosTitle => 'Foto Anda';

  @override
  String get homeYourPhotosEmpty => 'Foto yang Anda buat akan muncul di sini.';

  @override
  String get specFavoriteAdd => 'Tambahkan ke favorit';

  @override
  String get specFavoriteRemove => 'Hapus dari favorit';

  @override
  String get editorModeCrop => 'Pangkas';

  @override
  String get editorModeBackground => 'Latar belakang';

  @override
  String get editorModeAdjust => 'Sesuaikan';

  @override
  String get editorReset => 'Atur ulang';

  @override
  String get editorDiscardTitle => 'Buang perubahan?';

  @override
  String get editorDiscardBody => 'Pangkasan dan penyesuaian Anda akan hilang.';

  @override
  String get editorDiscardConfirm => 'Buang';

  @override
  String get captureFlash => 'Lampu kilat';

  @override
  String get complianceActionRetake =>
      'Ambil ulang foto dengan pencahayaan yang lebih merata.';

  @override
  String get complianceActionBackground =>
      'Ganti latar belakang atau ambil ulang di depan dinding polos.';

  @override
  String get complianceActionCenter =>
      'Pusatkan wajah Anda, gunakan penyesuaian otomatis, lalu ambil ulang.';

  @override
  String get complianceActionDimensions =>
      'Ekspor ulang untuk menghasilkan ukuran yang persis sesuai ketentuan.';

  @override
  String get complianceActionFilesize =>
      'Ekspor sebagai JPEG agar tetap di bawah batas ukuran.';

  @override
  String get exportAdvancedDetails => 'Detail';

  @override
  String get historyMissingPhoto => 'Berkas foto tidak ditemukan';

  @override
  String get swatchRequired => 'Wajib';

  @override
  String get swatchSuggested => 'Disarankan';

  @override
  String get editorCropHint =>
      'Seret untuk menggeser, cubit untuk memperbesar.';

  @override
  String get historyReopen => 'Buka';

  @override
  String get historyReopenHint => 'Membuka foto ini di penyunting.';
}
