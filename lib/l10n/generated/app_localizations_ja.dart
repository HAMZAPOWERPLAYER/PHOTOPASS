// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'PhotoPass';

  @override
  String get navHome => 'ホーム';

  @override
  String get navHistory => '履歴';

  @override
  String get navSettings => '設定';

  @override
  String get onboardingPrivacyTitle => '写真がスマートフォンの外に出ることは決してありません';

  @override
  String get onboardingPrivacyBody =>
      'PhotoPassは顔検出・背景の削除・書き出しをすべてお使いの端末内で行います。アカウント不要、クラウドへのアップロードなし、画像の分析もありません。';

  @override
  String get onboardingHowTitle => '3つの簡単なステップ';

  @override
  String get onboardingHowBody =>
      '国と書類の種類を選択し、写真を撮影または選択して、規格に合った印刷用画像を書き出します。';

  @override
  String get onboardingLanguageTitle => '言語を選択';

  @override
  String get commonContinue => '次へ';

  @override
  String get commonSkip => 'スキップ';

  @override
  String get commonStart => 'はじめる';

  @override
  String get commonBack => '戻る';

  @override
  String get commonCancel => 'キャンセル';

  @override
  String get commonRetry => 'もう一度試す';

  @override
  String get commonClose => '閉じる';

  @override
  String get errorGenericTitle => 'エラーが発生しました';

  @override
  String get errorGenericBody => 'もう一度お試しください。';

  @override
  String get placeholderBody => 'この画面は今後のビルド段階で追加されます。';

  @override
  String get homeSearchHint => '国または書類を検索';

  @override
  String get homePopularTitle => '人気';

  @override
  String get homePassport => 'パスポート';

  @override
  String get homeVisa => 'ビザ';

  @override
  String get homeIdCard => '身分証明書';

  @override
  String get homeCustomSize => 'カスタムサイズ';

  @override
  String get historyEmptyTitle => 'まだ写真がありません';

  @override
  String get historyEmptyBody => '作成した写真がここに表示されます。';

  @override
  String get countrySelectTitle => '国と書類';

  @override
  String get countrySearchHint => '国を検索';

  @override
  String get countryNoResults => '該当する国がありません';

  @override
  String countryDocumentsCount(int count) {
    return '$count件の書類';
  }

  @override
  String get specSizeLabel => 'サイズ';

  @override
  String get specBackgroundLabel => '背景';

  @override
  String get specDpiLabel => '解像度';

  @override
  String get specFormatsLabel => '形式';

  @override
  String get specHeadHeightLabel => '頭の高さ';

  @override
  String get specEyeLineLabel => '下端から目の高さまで';

  @override
  String get specGlassesAllowed => 'メガネの使用可';

  @override
  String get specGlassesNotAllowed => 'メガネの使用不可';

  @override
  String get specMaxFileSizeLabel => '最大ファイルサイズ';

  @override
  String get specVerifiedBadge => '確認済み';

  @override
  String get specUnverifiedBadge => '未確認';

  @override
  String get specUnverifiedNotice => '公式な情報源でご確認ください。';

  @override
  String get specOfficialSource => '公式情報源';

  @override
  String specLastVerified(String date) {
    return '最終確認日 $date';
  }

  @override
  String get specUsePhoto => 'この写真を使用';

  @override
  String get specNotSpecified => '指定なし';

  @override
  String get spec_us_passport => 'アメリカ合衆国 パスポート';

  @override
  String get spec_gb_passport => 'イギリス パスポート';

  @override
  String get spec_ca_passport => 'カナダ パスポート';

  @override
  String get spec_cn_visa => '中国 ビザ';

  @override
  String get spec_de_schengen_visa => 'ドイツ — シェンゲンビザ';

  @override
  String get spec_fr_schengen_visa => 'フランス — シェンゲンビザ';

  @override
  String get spec_it_schengen_visa => 'イタリア — シェンゲンビザ';

  @override
  String get spec_es_schengen_visa => 'スペイン — シェンゲンビザ';

  @override
  String get captureTitle => '写真を撮る';

  @override
  String get captureRationaleTitle => 'カメラへのアクセスが必要です';

  @override
  String get captureRationaleBody =>
      'PhotoPassはパスポート用写真を撮影するためにカメラを使用します。写真はスマートフォンに留まり、アップロードされることはありません。';

  @override
  String get captureRationaleDenied =>
      'カメラへのアクセスがオフになっています。写真を撮影するにはシステム設定で有効にするか、ギャラリーから選択してください。';

  @override
  String get captureRationaleAction => 'カメラを許可';

  @override
  String get captureOpenSettings => '設定を開く';

  @override
  String get captureCameraError => 'カメラを起動できませんでした。ギャラリーから写真を選択することもできます。';

  @override
  String get captureHintFace => '顔を楕円の中に収めてください';

  @override
  String get captureSwitchCamera => 'カメラを切り替え';

  @override
  String get captureGallery => 'ギャラリーから選択';

  @override
  String get editorTitle => '写真を編集';

  @override
  String get editorRotate => '90°回転';

  @override
  String get editorAutoFit => '顔に自動合わせ';

  @override
  String get editorApply => '写真を切り抜く';

  @override
  String get retouchTitle => '背景と調整';

  @override
  String get retouchBackground => '背景';

  @override
  String get retouchRemoveBackground => '背景を変更';

  @override
  String get retouchRemoveBackgroundHint => '背後の単色背景をきれいな色で塗り替えます。';

  @override
  String retouchTolerance(int value) {
    return '検出の許容度: $value';
  }

  @override
  String get retouchBackgroundColor => '置換カラー';

  @override
  String get retouchAdjustments => '調整';

  @override
  String get retouchBrightness => '明るさ';

  @override
  String get retouchContrast => 'コントラスト';

  @override
  String get retouchSaturation => '彩度';

  @override
  String get retouchLocalNote => 'すべての処理はこの端末内で行われます。';

  @override
  String get retouchApply => '次へ';

  @override
  String get complianceTitle => '規格チェック';

  @override
  String get complianceIntro =>
      'これらのチェックは写真を公式要件と照合します。受理を保証するものではなく、あくまで参考としてご利用ください。';

  @override
  String get complianceContinue => '書き出しに進む';

  @override
  String get complianceMeasured => '計測結果';

  @override
  String get complianceDimensions => '写真サイズ';

  @override
  String get complianceDimensionsDetail => '写真は指定されたピクセル寸法と完全に一致している必要があります。';

  @override
  String get complianceFace => '顔が1つ検出されました';

  @override
  String get complianceFaceDetail => '写真には人物がちょうど1人写っている必要があります。';

  @override
  String get complianceHeadHeight => '頭の高さ';

  @override
  String get complianceHeadHeightDetail => '頭の高さは公式の範囲内である必要があります。';

  @override
  String get complianceEyeLine => '目の高さの位置';

  @override
  String get complianceEyeLineDetail => '目は下端からの公式の高さにある必要があります。';

  @override
  String get complianceBackground => '背景色と均一性';

  @override
  String get complianceBackgroundDetail => '背景は単色で、指定された色に一致している必要があります。';

  @override
  String get complianceGlasses => 'メガネ';

  @override
  String get complianceGlassesAllowed => 'この書類ではメガネの使用が許可されています。';

  @override
  String get complianceGlassesForbidden => 'この書類ではメガネの使用が許可されていません。';

  @override
  String get complianceFileSize => 'ファイルサイズ';

  @override
  String get complianceFileSizeDetail => 'ファイルは公式のサイズ制限内に収まる必要があります。';

  @override
  String get exportTitle => '書き出し';

  @override
  String exportSizeLabel(int width, int height) {
    return '$width × $height ピクセル';
  }

  @override
  String exportDetails(String mm, String dpi) {
    return '$mm mm、$dpi DPI';
  }

  @override
  String get exportSavePhoto => '写真を保存';

  @override
  String get exportSavePhotoHint => '正確なサイズの写真をギャラリーに保存します。';

  @override
  String get exportShare => '共有';

  @override
  String get exportShareHint => '完成した写真を他のアプリに送信します。';

  @override
  String get exportDoneShare => '共有しました。';

  @override
  String exportFileSizeLimit(int kb) {
    return '最大ファイルサイズ: $kb KB';
  }

  @override
  String get exportPdf => 'PDF（印刷対応）';

  @override
  String get exportPdfHint => '正確な実寸で印刷できる写真を1枚収録します。';

  @override
  String get exportPrintSheetTitle => '印刷シート';

  @override
  String exportPrintSheet(String size) {
    return '印刷シート — $size';
  }

  @override
  String get exportPrintSheetHint => '写真用紙1枚に複数の写真を配置します。';

  @override
  String get exportDoneSave => '保存しました。';

  @override
  String get exportDonePdf => 'PDFを共有できます。';

  @override
  String get exportDoneSheet => '印刷シートを共有できます。';

  @override
  String get exportLocalNote => '写真はこの端末内で作成されます。アップロードは一切行われません。';

  @override
  String get historyDelete => '削除';

  @override
  String get settingsPrivacy => 'プライバシー';

  @override
  String get settingsClearHistoryHint => 'この端末から保存されたすべての写真を削除します。';

  @override
  String get settingsClearHistoryConfirm =>
      'アプリに保存されたすべての写真を完全に削除します。この操作は取り消せません。';

  @override
  String get settingsClearHistoryAction => 'すべて削除';

  @override
  String get privacyPolicyBody =>
      'PhotoPassは写真をすべてこの端末内で処理します。\n\n• 写真がサーバーにアップロードされることはありません。\n• アプリに広告、アクセス解析、トラッキングは含まれません。\n• アカウントやログインは必要ありません。\n• 保存された写真はアプリのプライベートな保存領域にのみ保持されます。\n• ネットワークアクセスは、ブラウザで公式の政府情報源のリンクを開くことだけです。\n• アプリを削除すると、そのすべてのデータも削除されます。';

  @override
  String get settingsAppearance => '外観';

  @override
  String get settingsGeneral => '一般';

  @override
  String get settingsLanguage => '言語';

  @override
  String get settingsThemeLight => 'ライト';

  @override
  String get settingsThemeDark => 'ダーク';

  @override
  String get settingsThemeSystem => 'システム';

  @override
  String get settingsPrivacyPolicy => 'プライバシーポリシー';

  @override
  String get settingsTerms => '利用規約';

  @override
  String get settingsRateApp => 'アプリを評価';

  @override
  String get settingsClearHistory => '保存された写真をすべて削除';

  @override
  String get settingsAbout => '情報';

  @override
  String settingsVersion(String version) {
    return 'バージョン $version';
  }

  @override
  String get disclaimer =>
      '要件は変更される場合があります。必ず公式の情報源をご確認ください。PhotoPassは受理を保証することはできません。';

  @override
  String get homeHeadline => '規格に合ったパスポート用写真を作成';

  @override
  String get homeCreatePhoto => '写真を作成';

  @override
  String get homeRecentTitle => '最近';

  @override
  String get homeFavoritesTitle => 'お気に入り';

  @override
  String get homeYourPhotosTitle => 'あなたの写真';

  @override
  String get homeYourPhotosEmpty => '作成した写真がここに表示されます。';

  @override
  String get specFavoriteAdd => 'お気に入りに追加';

  @override
  String get specFavoriteRemove => 'お気に入りから削除';

  @override
  String get editorModeCrop => '切り抜き';

  @override
  String get editorModeBackground => '背景';

  @override
  String get editorModeAdjust => '調整';

  @override
  String get editorReset => 'リセット';

  @override
  String get editorDiscardTitle => '変更を破棄しますか？';

  @override
  String get editorDiscardBody => '切り抜きと調整内容が失われます。';

  @override
  String get editorDiscardConfirm => '破棄';

  @override
  String get captureFlash => 'フラッシュ';

  @override
  String get complianceActionRetake => '光をより均一にして撮り直してください。';

  @override
  String get complianceActionBackground => '背景を変更するか、無地の壁を背景に撮り直してください。';

  @override
  String get complianceActionCenter => '顔を中央に配置し、自動合わせを使用してから撮り直してください。';

  @override
  String get complianceActionDimensions => '指定された正確なサイズになるよう、再度書き出してください。';

  @override
  String get complianceActionFilesize => 'サイズ制限内に収めるため、JPEGとして書き出してください。';

  @override
  String get exportAdvancedDetails => '詳細';

  @override
  String get historyMissingPhoto => '写真ファイルが見つかりません';

  @override
  String get swatchRequired => '必須';

  @override
  String get swatchSuggested => '推奨';

  @override
  String get editorCropHint => 'ドラッグで移動し、ピンチで拡大縮小します。';

  @override
  String get historyReopen => '開く';

  @override
  String get historyReopenHint => 'この写真をエディターで開きます。';
}
