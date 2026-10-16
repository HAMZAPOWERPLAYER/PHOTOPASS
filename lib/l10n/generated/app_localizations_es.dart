// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'PhotoPass';

  @override
  String get navHome => 'Inicio';

  @override
  String get navHistory => 'Historial';

  @override
  String get navSettings => 'Ajustes';

  @override
  String get onboardingPrivacyTitle => 'Tus fotos nunca salen de tu teléfono';

  @override
  String get onboardingPrivacyBody =>
      'PhotoPass detecta rostros, elimina el fondo y exporta tu foto completamente en tu dispositivo. Sin cuenta, sin subidas a la nube y sin analíticas de tus imágenes.';

  @override
  String get onboardingHowTitle => 'Tres pasos sencillos';

  @override
  String get onboardingHowBody =>
      'Elige tu país y el tipo de documento, toma o selecciona una foto y exporta una imagen conforme y lista para imprimir.';

  @override
  String get onboardingLanguageTitle => 'Elige tu idioma';

  @override
  String get commonContinue => 'Continuar';

  @override
  String get commonSkip => 'Omitir';

  @override
  String get commonStart => 'Comenzar';

  @override
  String get commonBack => 'Atrás';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonRetry => 'Reintentar';

  @override
  String get commonClose => 'Cerrar';

  @override
  String get errorGenericTitle => 'Algo salió mal';

  @override
  String get errorGenericBody => 'Inténtalo de nuevo.';

  @override
  String get placeholderBody =>
      'Esta pantalla llegará en una fase posterior de desarrollo.';

  @override
  String get homeSearchHint => 'Buscar país o documento';

  @override
  String get homePopularTitle => 'Populares';

  @override
  String get homePassport => 'Pasaporte';

  @override
  String get homeVisa => 'Visa';

  @override
  String get homeIdCard => 'Documento de identidad';

  @override
  String get homeCustomSize => 'Tamaño personalizado';

  @override
  String get historyEmptyTitle => 'Aún no hay fotos';

  @override
  String get historyEmptyBody => 'Las fotos que crees aparecerán aquí.';

  @override
  String get countrySelectTitle => 'País y documento';

  @override
  String get countrySearchHint => 'Buscar país';

  @override
  String get countryNoResults => 'No hay países que coincidan';

  @override
  String countryDocumentsCount(int count) {
    return '$count documentos';
  }

  @override
  String get specSizeLabel => 'Tamaño';

  @override
  String get specBackgroundLabel => 'Fondo';

  @override
  String get specDpiLabel => 'Resolución';

  @override
  String get specFormatsLabel => 'Formatos';

  @override
  String get specHeadHeightLabel => 'Altura de la cabeza';

  @override
  String get specEyeLineLabel => 'Línea de los ojos desde el borde inferior';

  @override
  String get specGlassesAllowed => 'Se permiten gafas';

  @override
  String get specGlassesNotAllowed => 'No se permiten gafas';

  @override
  String get specMaxFileSizeLabel => 'Tamaño máximo de archivo';

  @override
  String get specVerifiedBadge => 'Verificado';

  @override
  String get specUnverifiedBadge => 'No verificado';

  @override
  String get specUnverifiedNotice => 'Confírmalo con la fuente oficial.';

  @override
  String get specOfficialSource => 'Fuente oficial';

  @override
  String specLastVerified(String date) {
    return 'Última verificación: $date';
  }

  @override
  String get specUsePhoto => 'Usar esta foto';

  @override
  String get specNotSpecified => 'No especificado';

  @override
  String get spec_us_passport => 'Pasaporte de Estados Unidos';

  @override
  String get spec_gb_passport => 'Pasaporte del Reino Unido';

  @override
  String get spec_ca_passport => 'Pasaporte de Canadá';

  @override
  String get spec_cn_visa => 'Visa de China';

  @override
  String get spec_de_schengen_visa => 'Alemania — Visa Schengen';

  @override
  String get spec_fr_schengen_visa => 'Francia — Visa Schengen';

  @override
  String get spec_it_schengen_visa => 'Italia — Visa Schengen';

  @override
  String get spec_es_schengen_visa => 'España — Visa Schengen';

  @override
  String get captureTitle => 'Tomar una foto';

  @override
  String get captureRationaleTitle => 'Se necesita acceso a la cámara';

  @override
  String get captureRationaleBody =>
      'PhotoPass usa la cámara para tomar la foto de pasaporte. La foto permanece en tu teléfono y nunca se sube.';

  @override
  String get captureRationaleDenied =>
      'El acceso a la cámara está desactivado. Actívalo en los ajustes del sistema para tomar una foto o elige una de tu galería.';

  @override
  String get captureRationaleAction => 'Permitir cámara';

  @override
  String get captureOpenSettings => 'Abrir ajustes';

  @override
  String get captureCameraError =>
      'No se pudo iniciar la cámara. Aún puedes elegir una foto de tu galería.';

  @override
  String get captureHintFace => 'Coloca tu rostro dentro del óvalo';

  @override
  String get captureSwitchCamera => 'Cambiar cámara';

  @override
  String get captureGallery => 'Elegir de la galería';

  @override
  String get editorTitle => 'Editar foto';

  @override
  String get editorRotate => 'Rotar 90°';

  @override
  String get editorAutoFit => 'Ajustar automáticamente al rostro';

  @override
  String get editorApply => 'Recortar foto';

  @override
  String get retouchTitle => 'Fondo y ajustes';

  @override
  String get retouchBackground => 'Fondo';

  @override
  String get retouchRemoveBackground => 'Reemplazar fondo';

  @override
  String get retouchRemoveBackgroundHint =>
      'Rellena el fondo liso que hay detrás con un color limpio.';

  @override
  String retouchTolerance(int value) {
    return 'Tolerancia de detección: $value';
  }

  @override
  String get retouchBackgroundColor => 'Color de reemplazo';

  @override
  String get retouchAdjustments => 'Ajustes';

  @override
  String get retouchBrightness => 'Brillo';

  @override
  String get retouchContrast => 'Contraste';

  @override
  String get retouchSaturation => 'Color';

  @override
  String get retouchLocalNote =>
      'Todo el procesamiento se realiza en este dispositivo.';

  @override
  String get retouchApply => 'Continuar';

  @override
  String get complianceTitle => 'Comprobación de conformidad';

  @override
  String get complianceIntro =>
      'Estas comprobaciones comparan tu foto con los requisitos oficiales. Son una orientación, no una garantía de aceptación.';

  @override
  String get complianceContinue => 'Continuar a la exportación';

  @override
  String get complianceMeasured => 'Medido';

  @override
  String get complianceDimensions => 'Tamaño de la foto';

  @override
  String get complianceDimensionsDetail =>
      'La foto debe tener exactamente las dimensiones en píxeles requeridas.';

  @override
  String get complianceFace => 'Un rostro detectado';

  @override
  String get complianceFaceDetail =>
      'La foto debe contener exactamente una persona.';

  @override
  String get complianceHeadHeight => 'Altura de la cabeza';

  @override
  String get complianceHeadHeightDetail =>
      'La altura de la cabeza debe estar dentro del rango oficial.';

  @override
  String get complianceEyeLine => 'Posición de la línea de los ojos';

  @override
  String get complianceEyeLineDetail =>
      'Los ojos deben situarse a la altura oficial desde el borde inferior.';

  @override
  String get complianceBackground => 'Color y uniformidad del fondo';

  @override
  String get complianceBackgroundDetail =>
      'El fondo debe ser liso y coincidir con el color requerido.';

  @override
  String get complianceGlasses => 'Gafas';

  @override
  String get complianceGlassesAllowed =>
      'Se permiten gafas para este documento.';

  @override
  String get complianceGlassesForbidden =>
      'No se permiten gafas para este documento.';

  @override
  String get complianceFileSize => 'Tamaño del archivo';

  @override
  String get complianceFileSizeDetail =>
      'El archivo debe mantenerse por debajo del límite de tamaño oficial.';

  @override
  String get exportTitle => 'Exportar';

  @override
  String exportSizeLabel(int width, int height) {
    return '$width × $height píxeles';
  }

  @override
  String exportDetails(String mm, String dpi) {
    return '$mm mm a $dpi DPI';
  }

  @override
  String get exportSavePhoto => 'Guardar foto';

  @override
  String get exportSavePhotoHint =>
      'Guarda la foto con el tamaño exacto en tu galería.';

  @override
  String get exportShare => 'Compartir';

  @override
  String get exportShareHint => 'Envía la foto terminada a otra aplicación.';

  @override
  String get exportDoneShare => 'Compartida.';

  @override
  String exportFileSizeLimit(int kb) {
    return 'Tamaño máximo de archivo: $kb KB';
  }

  @override
  String get exportPdf => 'PDF (listo para imprimir)';

  @override
  String get exportPdfHint =>
      'Una foto con el tamaño físico exacto, lista para imprimir.';

  @override
  String get exportPrintSheetTitle => 'Hojas de impresión';

  @override
  String exportPrintSheet(String size) {
    return 'Hoja de impresión — $size';
  }

  @override
  String get exportPrintSheetHint =>
      'Varias fotos dispuestas en una hoja de papel fotográfico.';

  @override
  String get exportDoneSave => 'Guardada.';

  @override
  String get exportDonePdf => 'PDF listo para compartir.';

  @override
  String get exportDoneSheet => 'Hoja de impresión lista para compartir.';

  @override
  String get exportLocalNote =>
      'Las fotos se crean en este dispositivo. No se sube nada.';

  @override
  String get historyDelete => 'Eliminar';

  @override
  String get settingsPrivacy => 'Privacidad';

  @override
  String get settingsClearHistoryHint =>
      'Elimina todas las fotos guardadas de este dispositivo.';

  @override
  String get settingsClearHistoryConfirm =>
      'Esto elimina permanentemente todas las fotos guardadas en la app. No se puede deshacer.';

  @override
  String get settingsClearHistoryAction => 'Eliminar todo';

  @override
  String get privacyPolicyBody =>
      'PhotoPass procesa tus fotos completamente en este dispositivo.\n\n• Las fotos nunca se suben a ningún servidor.\n• La aplicación no contiene anuncios, analíticas ni rastreo.\n• No se requiere cuenta ni inicio de sesión.\n• Las fotos guardadas solo se almacenan en el almacenamiento privado de la aplicación.\n• El único acceso a la red es la apertura de enlaces de fuentes oficiales del gobierno en tu navegador.\n• Al eliminar la aplicación, se eliminan todos sus datos.';

  @override
  String get settingsAppearance => 'Apariencia';

  @override
  String get settingsGeneral => 'General';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsThemeLight => 'Claro';

  @override
  String get settingsThemeDark => 'Oscuro';

  @override
  String get settingsThemeSystem => 'Sistema';

  @override
  String get settingsPrivacyPolicy => 'Política de privacidad';

  @override
  String get settingsTerms => 'Términos de uso';

  @override
  String get settingsRateApp => 'Valorar la aplicación';

  @override
  String get settingsClearHistory => 'Eliminar todas las fotos guardadas';

  @override
  String get settingsAbout => 'Acerca de';

  @override
  String settingsVersion(String version) {
    return 'Versión $version';
  }

  @override
  String get disclaimer =>
      'Los requisitos pueden cambiar. Consulta siempre la fuente oficial. PhotoPass no puede garantizar la aceptación.';

  @override
  String get homeHeadline => 'Crear una foto de pasaporte conforme';

  @override
  String get homeCreatePhoto => 'Crear una foto';

  @override
  String get homeRecentTitle => 'Recientes';

  @override
  String get homeFavoritesTitle => 'Favoritos';

  @override
  String get homeYourPhotosTitle => 'Tus fotos';

  @override
  String get homeYourPhotosEmpty => 'Las fotos que crees aparecerán aquí.';

  @override
  String get specFavoriteAdd => 'Añadir a favoritos';

  @override
  String get specFavoriteRemove => 'Quitar de favoritos';

  @override
  String get editorModeCrop => 'Recortar';

  @override
  String get editorModeBackground => 'Fondo';

  @override
  String get editorModeAdjust => 'Ajustar';

  @override
  String get editorReset => 'Restablecer';

  @override
  String get editorDiscardTitle => '¿Descartar cambios?';

  @override
  String get editorDiscardBody => 'Tu recorte y tus ajustes se perderán.';

  @override
  String get editorDiscardConfirm => 'Descartar';

  @override
  String get captureFlash => 'Flash';

  @override
  String get complianceActionRetake =>
      'Repetir la foto con una iluminación más uniforme.';

  @override
  String get complianceActionBackground =>
      'Reemplazar el fondo o repetir la foto contra una pared lisa.';

  @override
  String get complianceActionCenter =>
      'Centrar el rostro, usar el ajuste automático y repetir la foto.';

  @override
  String get complianceActionDimensions =>
      'Exportar de nuevo para generar el tamaño exacto requerido.';

  @override
  String get complianceActionFilesize =>
      'Exportar como JPEG para mantenerse por debajo del límite de tamaño.';

  @override
  String get exportAdvancedDetails => 'Detalles';

  @override
  String get historyMissingPhoto => 'Archivo de foto no encontrado';

  @override
  String get swatchRequired => 'Requerido';

  @override
  String get swatchSuggested => 'Sugerido';

  @override
  String get editorCropHint => 'Arrastrar para mover, pellizcar para ampliar.';

  @override
  String get historyReopen => 'Abrir';

  @override
  String get historyReopenHint => 'Abre esta foto en el editor.';
}
