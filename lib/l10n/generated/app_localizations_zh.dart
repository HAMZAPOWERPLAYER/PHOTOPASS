// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'PhotoPass';

  @override
  String get navHome => '首页';

  @override
  String get navHistory => '历史';

  @override
  String get navSettings => '设置';

  @override
  String get onboardingPrivacyTitle => '您的照片绝不会离开您的手机';

  @override
  String get onboardingPrivacyBody =>
      'PhotoPass 在您的设备上完成人脸检测、背景移除和照片导出。无需账号，不上传云端，也不会对您的图片进行任何分析。';

  @override
  String get onboardingHowTitle => '三个简单步骤';

  @override
  String get onboardingHowBody => '选择您的国家和证件类型，拍摄或选择一张照片，然后导出符合要求、可直接打印的图像。';

  @override
  String get onboardingLanguageTitle => '选择语言';

  @override
  String get commonContinue => '继续';

  @override
  String get commonSkip => '跳过';

  @override
  String get commonStart => '开始使用';

  @override
  String get commonBack => '返回';

  @override
  String get commonCancel => '取消';

  @override
  String get commonRetry => '重试';

  @override
  String get commonClose => '关闭';

  @override
  String get errorGenericTitle => '出了点问题';

  @override
  String get errorGenericBody => '请重试。';

  @override
  String get placeholderBody => '此屏幕将在后续构建阶段推出。';

  @override
  String get homeSearchHint => '搜索国家或证件';

  @override
  String get homePopularTitle => '热门';

  @override
  String get homePassport => '护照';

  @override
  String get homeVisa => '签证';

  @override
  String get homeIdCard => '身份证';

  @override
  String get homeCustomSize => '自定义尺寸';

  @override
  String get historyEmptyTitle => '还没有照片';

  @override
  String get historyEmptyBody => '您创建的照片将显示在这里。';

  @override
  String get countrySelectTitle => '国家与证件';

  @override
  String get countrySearchHint => '搜索国家';

  @override
  String get countryNoResults => '没有匹配的国家';

  @override
  String countryDocumentsCount(int count) {
    return '$count 种证件';
  }

  @override
  String get specSizeLabel => '尺寸';

  @override
  String get specBackgroundLabel => '背景';

  @override
  String get specDpiLabel => '分辨率';

  @override
  String get specFormatsLabel => '格式';

  @override
  String get specHeadHeightLabel => '头部高度';

  @override
  String get specEyeLineLabel => '眼睛距底部的高度';

  @override
  String get specGlassesAllowed => '允许戴眼镜';

  @override
  String get specGlassesNotAllowed => '不允许戴眼镜';

  @override
  String get specMaxFileSizeLabel => '最大文件大小';

  @override
  String get specVerifiedBadge => '已核实';

  @override
  String get specUnverifiedBadge => '未核实';

  @override
  String get specUnverifiedNotice => '请向官方来源确认。';

  @override
  String get specOfficialSource => '官方来源';

  @override
  String specLastVerified(String date) {
    return '最后核实于 $date';
  }

  @override
  String get specUsePhoto => '使用此照片';

  @override
  String get specNotSpecified => '未注明';

  @override
  String get spec_us_passport => '美国护照';

  @override
  String get spec_gb_passport => '英国护照';

  @override
  String get spec_ca_passport => '加拿大护照';

  @override
  String get spec_cn_visa => '中国签证';

  @override
  String get spec_de_schengen_visa => '德国 — 申根签证';

  @override
  String get spec_fr_schengen_visa => '法国 — 申根签证';

  @override
  String get spec_it_schengen_visa => '意大利 — 申根签证';

  @override
  String get spec_es_schengen_visa => '西班牙 — 申根签证';

  @override
  String get captureTitle => '拍摄照片';

  @override
  String get captureRationaleTitle => '需要相机权限';

  @override
  String get captureRationaleBody =>
      'PhotoPass 使用您的相机拍摄护照照片。照片始终保存在您的手机上，绝不会被上传。';

  @override
  String get captureRationaleDenied => '相机权限已被关闭。请在系统设置中启用它以便拍摄照片，或从相册中选择一张。';

  @override
  String get captureRationaleAction => '允许使用相机';

  @override
  String get captureOpenSettings => '打开设置';

  @override
  String get captureCameraError => '无法启动相机。您仍然可以从相册中选择照片。';

  @override
  String get captureHintFace => '将面部置于椭圆框内';

  @override
  String get captureSwitchCamera => '切换相机';

  @override
  String get captureGallery => '从相册选择';

  @override
  String get editorTitle => '编辑照片';

  @override
  String get editorRotate => '旋转 90°';

  @override
  String get editorAutoFit => '自动对齐面部';

  @override
  String get editorApply => '裁剪照片';

  @override
  String get retouchTitle => '背景与调整';

  @override
  String get retouchBackground => '背景';

  @override
  String get retouchRemoveBackground => '更换背景';

  @override
  String get retouchRemoveBackgroundHint => '将您身后的纯色背景替换为干净的颜色。';

  @override
  String retouchTolerance(int value) {
    return '检测容差：$value';
  }

  @override
  String get retouchBackgroundColor => '替换颜色';

  @override
  String get retouchAdjustments => '调整';

  @override
  String get retouchBrightness => '亮度';

  @override
  String get retouchContrast => '对比度';

  @override
  String get retouchSaturation => '饱和度';

  @override
  String get retouchLocalNote => '所有处理均在此设备上完成。';

  @override
  String get retouchApply => '继续';

  @override
  String get complianceTitle => '合规检查';

  @override
  String get complianceIntro => '这些检查会将您的照片与官方要求进行比对。它们仅供参考，并不能保证被受理。';

  @override
  String get complianceContinue => '继续导出';

  @override
  String get complianceMeasured => '测量结果';

  @override
  String get complianceDimensions => '照片尺寸';

  @override
  String get complianceDimensionsDetail => '照片必须与要求的像素尺寸完全一致。';

  @override
  String get complianceFace => '检测到一张面孔';

  @override
  String get complianceFaceDetail => '照片中必须恰好有一个人。';

  @override
  String get complianceHeadHeight => '头部高度';

  @override
  String get complianceHeadHeightDetail => '头部高度必须在官方规定的范围内。';

  @override
  String get complianceEyeLine => '眼睛位置';

  @override
  String get complianceEyeLineDetail => '眼睛必须位于距底部官方规定高度的位置。';

  @override
  String get complianceBackground => '背景颜色与均匀度';

  @override
  String get complianceBackgroundDetail => '背景必须为纯色，并与要求的颜色一致。';

  @override
  String get complianceGlasses => '眼镜';

  @override
  String get complianceGlassesAllowed => '此证件允许佩戴眼镜。';

  @override
  String get complianceGlassesForbidden => '此证件不允许佩戴眼镜。';

  @override
  String get complianceFileSize => '文件大小';

  @override
  String get complianceFileSizeDetail => '文件大小必须在官方限制范围内。';

  @override
  String get exportTitle => '导出';

  @override
  String exportSizeLabel(int width, int height) {
    return '$width × $height 像素';
  }

  @override
  String exportDetails(String mm, String dpi) {
    return '$mm 毫米，$dpi DPI';
  }

  @override
  String get exportSavePhoto => '保存照片';

  @override
  String get exportSavePhotoHint => '将精确尺寸的照片保存到相册。';

  @override
  String get exportShare => '分享';

  @override
  String get exportShareHint => '将完成的照片发送到其他应用。';

  @override
  String get exportDoneShare => '已分享。';

  @override
  String exportFileSizeLimit(int kb) {
    return '最大文件大小：$kb KB';
  }

  @override
  String get exportPdf => 'PDF（可直接打印）';

  @override
  String get exportPdfHint => '包含一张精确实际尺寸的照片，可直接打印。';

  @override
  String get exportPrintSheetTitle => '打印拼版';

  @override
  String exportPrintSheet(String size) {
    return '打印拼版 — $size';
  }

  @override
  String get exportPrintSheetHint => '在一张相纸上排列多张照片。';

  @override
  String get exportDoneSave => '已保存。';

  @override
  String get exportDonePdf => 'PDF 已可分享。';

  @override
  String get exportDoneSheet => '打印拼版已可分享。';

  @override
  String get exportLocalNote => '照片在此设备上生成，不会上传任何内容。';

  @override
  String get historyDelete => '删除';

  @override
  String get settingsPrivacy => '隐私';

  @override
  String get settingsClearHistoryHint => '删除此设备上保存的所有照片。';

  @override
  String get settingsClearHistoryConfirm => '这将永久删除应用中保存的每一张照片，且无法撤销。';

  @override
  String get settingsClearHistoryAction => '全部删除';

  @override
  String get privacyPolicyBody =>
      'PhotoPass 完全在此设备上处理您的照片。\n\n• 照片绝不会上传到任何服务器。\n• 应用不含广告、数据分析或跟踪。\n• 无需账号或登录。\n• 保存的照片仅存储在应用的私有存储中。\n• 唯一的网络访问是在浏览器中打开官方政府来源的链接。\n• 删除应用会移除其全部数据。';

  @override
  String get settingsAppearance => '外观';

  @override
  String get settingsGeneral => '通用';

  @override
  String get settingsLanguage => '语言';

  @override
  String get settingsThemeLight => '浅色';

  @override
  String get settingsThemeDark => '深色';

  @override
  String get settingsThemeSystem => '跟随系统';

  @override
  String get settingsPrivacyPolicy => '隐私政策';

  @override
  String get settingsTerms => '使用条款';

  @override
  String get settingsRateApp => '给应用评分';

  @override
  String get settingsClearHistory => '删除所有已保存的照片';

  @override
  String get settingsAbout => '关于';

  @override
  String settingsVersion(String version) {
    return '版本 $version';
  }

  @override
  String get disclaimer => '要求可能会变更。请务必查阅官方来源。PhotoPass 无法保证照片被受理。';

  @override
  String get homeHeadline => '制作符合要求的护照照片';

  @override
  String get homeCreatePhoto => '创建照片';

  @override
  String get homeRecentTitle => '最近';

  @override
  String get homeFavoritesTitle => '收藏';

  @override
  String get homeYourPhotosTitle => '您的照片';

  @override
  String get homeYourPhotosEmpty => '您创建的照片将显示在这里。';

  @override
  String get specFavoriteAdd => '添加到收藏';

  @override
  String get specFavoriteRemove => '从收藏中移除';

  @override
  String get editorModeCrop => '裁剪';

  @override
  String get editorModeBackground => '背景';

  @override
  String get editorModeAdjust => '调整';

  @override
  String get editorReset => '重置';

  @override
  String get editorDiscardTitle => '放弃更改？';

  @override
  String get editorDiscardBody => '您的裁剪和调整将会丢失。';

  @override
  String get editorDiscardConfirm => '放弃';

  @override
  String get captureFlash => '闪光灯';

  @override
  String get complianceActionRetake => '使用更均匀的光线重新拍摄。';

  @override
  String get complianceActionBackground => '更换背景，或在素色墙面前重新拍摄。';

  @override
  String get complianceActionCenter => '将面部置于中央，使用自动对齐，然后重新拍摄。';

  @override
  String get complianceActionDimensions => '重新导出以获得准确的所需尺寸。';

  @override
  String get complianceActionFilesize => '以 JPEG 格式导出以保持在大小限制内。';

  @override
  String get exportAdvancedDetails => '详情';

  @override
  String get historyMissingPhoto => '照片文件缺失';

  @override
  String get swatchRequired => '必需';

  @override
  String get swatchSuggested => '建议';

  @override
  String get editorCropHint => '拖动以移动，双指捏合以缩放。';

  @override
  String get historyReopen => '打开';

  @override
  String get historyReopenHint => '在编辑器中打开此照片。';
}
