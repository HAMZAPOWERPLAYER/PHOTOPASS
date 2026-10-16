// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'PhotoPass';

  @override
  String get navHome => 'Главная';

  @override
  String get navHistory => 'История';

  @override
  String get navSettings => 'Настройки';

  @override
  String get onboardingPrivacyTitle => 'Ваши фото никогда не покидают телефон';

  @override
  String get onboardingPrivacyBody =>
      'PhotoPass распознаёт лица, удаляет фон и экспортирует фото полностью на вашем устройстве. Без аккаунта, без загрузки в облако и без аналитики для ваших изображений.';

  @override
  String get onboardingHowTitle => 'Три простых шага';

  @override
  String get onboardingHowBody =>
      'Выберите страну и тип документа, сделайте или выберите фото, затем экспортируйте фото, соответствующее требованиям и готовое к печати.';

  @override
  String get onboardingLanguageTitle => 'Выберите язык';

  @override
  String get commonContinue => 'Продолжить';

  @override
  String get commonSkip => 'Пропустить';

  @override
  String get commonStart => 'Начать';

  @override
  String get commonBack => 'Назад';

  @override
  String get commonCancel => 'Отмена';

  @override
  String get commonRetry => 'Попробовать снова';

  @override
  String get commonClose => 'Закрыть';

  @override
  String get errorGenericTitle => 'Что-то пошло не так';

  @override
  String get errorGenericBody => 'Пожалуйста, попробуйте ещё раз.';

  @override
  String get placeholderBody =>
      'Этот экран появится на следующем этапе сборки.';

  @override
  String get homeSearchHint => 'Поиск страны или документа';

  @override
  String get homePopularTitle => 'Популярные';

  @override
  String get homePassport => 'Загранпаспорт';

  @override
  String get homeVisa => 'Виза';

  @override
  String get homeIdCard => 'Удостоверение личности';

  @override
  String get homeCustomSize => 'Произвольный размер';

  @override
  String get historyEmptyTitle => 'Фото пока нет';

  @override
  String get historyEmptyBody => 'Здесь появятся созданные вами фото.';

  @override
  String get countrySelectTitle => 'Страна и документ';

  @override
  String get countrySearchHint => 'Поиск страны';

  @override
  String get countryNoResults => 'Подходящих стран не найдено';

  @override
  String countryDocumentsCount(int count) {
    return 'Документов: $count';
  }

  @override
  String get specSizeLabel => 'Размер';

  @override
  String get specBackgroundLabel => 'Фон';

  @override
  String get specDpiLabel => 'Разрешение';

  @override
  String get specFormatsLabel => 'Форматы';

  @override
  String get specHeadHeightLabel => 'Высота головы';

  @override
  String get specEyeLineLabel => 'Линия глаз от нижнего края';

  @override
  String get specGlassesAllowed => 'Очки разрешены';

  @override
  String get specGlassesNotAllowed => 'Очки запрещены';

  @override
  String get specMaxFileSizeLabel => 'Максимальный размер файла';

  @override
  String get specVerifiedBadge => 'Проверено';

  @override
  String get specUnverifiedBadge => 'Не проверено';

  @override
  String get specUnverifiedNotice =>
      'Пожалуйста, уточните в официальном источнике.';

  @override
  String get specOfficialSource => 'Официальный источник';

  @override
  String specLastVerified(String date) {
    return 'Последняя проверка: $date';
  }

  @override
  String get specUsePhoto => 'Использовать это фото';

  @override
  String get specNotSpecified => 'Не указано';

  @override
  String get spec_us_passport => 'Паспорт США';

  @override
  String get spec_gb_passport => 'Паспорт Великобритании';

  @override
  String get spec_ca_passport => 'Паспорт Канады';

  @override
  String get spec_cn_visa => 'Виза в Китай';

  @override
  String get spec_de_schengen_visa => 'Германия — шенгенская виза';

  @override
  String get spec_fr_schengen_visa => 'Франция — шенгенская виза';

  @override
  String get spec_it_schengen_visa => 'Италия — шенгенская виза';

  @override
  String get spec_es_schengen_visa => 'Испания — шенгенская виза';

  @override
  String get captureTitle => 'Сделать фото';

  @override
  String get captureRationaleTitle => 'Требуется доступ к камере';

  @override
  String get captureRationaleBody =>
      'PhotoPass использует камеру для съёмки паспортного фото. Фото остаётся на вашем телефоне и никогда не загружается в сеть.';

  @override
  String get captureRationaleDenied =>
      'Доступ к камере отключён. Включите его в системных настройках, чтобы сделать фото, или выберите фото из галереи.';

  @override
  String get captureRationaleAction => 'Разрешить камеру';

  @override
  String get captureOpenSettings => 'Открыть настройки';

  @override
  String get captureCameraError =>
      'Не удалось запустить камеру. Вы всё ещё можете выбрать фото из галереи.';

  @override
  String get captureHintFace => 'Поместите лицо в овал';

  @override
  String get captureSwitchCamera => 'Переключить камеру';

  @override
  String get captureGallery => 'Выбрать из галереи';

  @override
  String get editorTitle => 'Редактировать фото';

  @override
  String get editorRotate => 'Повернуть на 90°';

  @override
  String get editorAutoFit => 'Автоподгонка по лицу';

  @override
  String get editorApply => 'Обрезать фото';

  @override
  String get retouchTitle => 'Фон и корректировки';

  @override
  String get retouchBackground => 'Фон';

  @override
  String get retouchRemoveBackground => 'Заменить фон';

  @override
  String get retouchRemoveBackgroundHint =>
      'Заменяет однотонный фон за вами на чистый цвет.';

  @override
  String retouchTolerance(int value) {
    return 'Порог распознавания: $value';
  }

  @override
  String get retouchBackgroundColor => 'Цвет замены';

  @override
  String get retouchAdjustments => 'Корректировки';

  @override
  String get retouchBrightness => 'Яркость';

  @override
  String get retouchContrast => 'Контраст';

  @override
  String get retouchSaturation => 'Насыщенность';

  @override
  String get retouchLocalNote =>
      'Вся обработка выполняется на этом устройстве.';

  @override
  String get retouchApply => 'Продолжить';

  @override
  String get complianceTitle => 'Проверка соответствия';

  @override
  String get complianceIntro =>
      'Эти проверки сравнивают ваше фото с официальными требованиями. Они носят рекомендательный характер и не гарантируют, что фото будет принято.';

  @override
  String get complianceContinue => 'Перейти к экспорту';

  @override
  String get complianceMeasured => 'Измерено';

  @override
  String get complianceDimensions => 'Размер фото';

  @override
  String get complianceDimensionsDetail =>
      'Фото должно иметь точно заданные размеры в пикселях.';

  @override
  String get complianceFace => 'Обнаружено одно лицо';

  @override
  String get complianceFaceDetail => 'На фото должен быть ровно один человек.';

  @override
  String get complianceHeadHeight => 'Высота головы';

  @override
  String get complianceHeadHeightDetail =>
      'Высота головы должна быть в официальном диапазоне.';

  @override
  String get complianceEyeLine => 'Положение линии глаз';

  @override
  String get complianceEyeLineDetail =>
      'Глаза должны находиться на официальной высоте от нижнего края.';

  @override
  String get complianceBackground => 'Цвет и однотонность фона';

  @override
  String get complianceBackgroundDetail =>
      'Фон должен быть однотонным и соответствовать требуемому цвету.';

  @override
  String get complianceGlasses => 'Очки';

  @override
  String get complianceGlassesAllowed => 'Для этого документа разрешены очки.';

  @override
  String get complianceGlassesForbidden =>
      'Для этого документа очки не разрешены.';

  @override
  String get complianceFileSize => 'Размер файла';

  @override
  String get complianceFileSizeDetail =>
      'Размер файла должен быть меньше официального предела.';

  @override
  String get exportTitle => 'Экспорт';

  @override
  String exportSizeLabel(int width, int height) {
    return '$width × $height пикселей';
  }

  @override
  String exportDetails(String mm, String dpi) {
    return '$mm мм при $dpi DPI';
  }

  @override
  String get exportSavePhoto => 'Сохранить фото';

  @override
  String get exportSavePhotoHint =>
      'Сохраняет фото точного размера в вашу галерею.';

  @override
  String get exportShare => 'Поделиться';

  @override
  String get exportShareHint => 'Отправляет готовое фото в другое приложение.';

  @override
  String get exportDoneShare => 'Поделено.';

  @override
  String exportFileSizeLimit(int kb) {
    return 'Максимальный размер файла: $kb КБ';
  }

  @override
  String get exportPdf => 'PDF (готово к печати)';

  @override
  String get exportPdfHint =>
      'Одно фото точного физического размера, готовое к печати.';

  @override
  String get exportPrintSheetTitle => 'Печатные листы';

  @override
  String exportPrintSheet(String size) {
    return 'Печатный лист — $size';
  }

  @override
  String get exportPrintSheetHint =>
      'Несколько фото, размещённых на одном листе фотобумаги.';

  @override
  String get exportDoneSave => 'Сохранено.';

  @override
  String get exportDonePdf => 'PDF готов к отправке.';

  @override
  String get exportDoneSheet => 'Печатный лист готов к отправке.';

  @override
  String get exportLocalNote =>
      'Фото создаются на этом устройстве. Ничего не загружается в сеть.';

  @override
  String get historyDelete => 'Удалить';

  @override
  String get settingsPrivacy => 'Конфиденциальность';

  @override
  String get settingsClearHistoryHint =>
      'Удаляет все сохранённые фото с этого устройства.';

  @override
  String get settingsClearHistoryConfirm =>
      'Это навсегда удалит все фото, сохранённые в приложении. Действие нельзя отменить.';

  @override
  String get settingsClearHistoryAction => 'Удалить всё';

  @override
  String get privacyPolicyBody =>
      'PhotoPass обрабатывает ваши фото полностью на этом устройстве.\n\n• Фото никогда не загружаются на серверы.\n• В приложении нет рекламы, аналитики и отслеживания.\n• Аккаунт и вход не требуются.\n• Сохранённые фото хранятся только в личном хранилище приложения.\n• Единственный сетевой доступ — открытие ссылок на официальные государственные источники в вашем браузере.\n• Удаление приложения удаляет все его данные.';

  @override
  String get settingsAppearance => 'Оформление';

  @override
  String get settingsGeneral => 'Общие';

  @override
  String get settingsLanguage => 'Язык';

  @override
  String get settingsThemeLight => 'Светлая';

  @override
  String get settingsThemeDark => 'Тёмная';

  @override
  String get settingsThemeSystem => 'Системная';

  @override
  String get settingsPrivacyPolicy => 'Политика конфиденциальности';

  @override
  String get settingsTerms => 'Условия использования';

  @override
  String get settingsRateApp => 'Оценить приложение';

  @override
  String get settingsClearHistory => 'Удалить все сохранённые фото';

  @override
  String get settingsAbout => 'О приложении';

  @override
  String settingsVersion(String version) {
    return 'Версия $version';
  }

  @override
  String get disclaimer =>
      'Требования могут меняться. Всегда проверяйте официальный источник. PhotoPass не может гарантировать принятие фото.';

  @override
  String get homeHeadline =>
      'Создайте паспортное фото, соответствующее требованиям';

  @override
  String get homeCreatePhoto => 'Создать фото';

  @override
  String get homeRecentTitle => 'Недавние';

  @override
  String get homeFavoritesTitle => 'Избранное';

  @override
  String get homeYourPhotosTitle => 'Ваши фото';

  @override
  String get homeYourPhotosEmpty => 'Здесь появятся созданные вами фото.';

  @override
  String get specFavoriteAdd => 'Добавить в избранное';

  @override
  String get specFavoriteRemove => 'Убрать из избранного';

  @override
  String get editorModeCrop => 'Обрезка';

  @override
  String get editorModeBackground => 'Фон';

  @override
  String get editorModeAdjust => 'Корректировка';

  @override
  String get editorReset => 'Сбросить';

  @override
  String get editorDiscardTitle => 'Отменить изменения?';

  @override
  String get editorDiscardBody =>
      'Обрезка и внесённые корректировки будут потеряны.';

  @override
  String get editorDiscardConfirm => 'Отменить';

  @override
  String get captureFlash => 'Вспышка';

  @override
  String get complianceActionRetake =>
      'Переснимите фото с более равномерным освещением.';

  @override
  String get complianceActionBackground =>
      'Замените фон или переснимите на фоне однотонной стены.';

  @override
  String get complianceActionCenter =>
      'Центрируйте лицо, используйте автоподгонку, затем переснимите фото.';

  @override
  String get complianceActionDimensions =>
      'Выполните экспорт заново, чтобы получить точный требуемый размер.';

  @override
  String get complianceActionFilesize =>
      'Экспортируйте в формате JPEG, чтобы не превысить допустимый размер файла.';

  @override
  String get exportAdvancedDetails => 'Подробнее';

  @override
  String get historyMissingPhoto => 'Файл фото отсутствует';

  @override
  String get swatchRequired => 'Обязательно';

  @override
  String get swatchSuggested => 'Рекомендуется';

  @override
  String get editorCropHint =>
      'Перетаскивайте, чтобы переместить; сожмите пальцы, чтобы масштабировать.';

  @override
  String get historyReopen => 'Открыть';

  @override
  String get historyReopenHint => 'Открывает это фото в редакторе.';
}
