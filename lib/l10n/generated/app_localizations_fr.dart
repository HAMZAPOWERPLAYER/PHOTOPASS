// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'PhotoPass';

  @override
  String get navHome => 'Accueil';

  @override
  String get navHistory => 'Historique';

  @override
  String get navSettings => 'Paramètres';

  @override
  String get onboardingPrivacyTitle =>
      'Vos photos ne quittent jamais votre téléphone';

  @override
  String get onboardingPrivacyBody =>
      'PhotoPass détecte les visages, supprime l\'arrière-plan et exporte votre photo entièrement sur votre appareil. Pas de compte, pas de téléversement cloud et pas d\'analytique sur vos images.';

  @override
  String get onboardingHowTitle => 'Trois étapes simples';

  @override
  String get onboardingHowBody =>
      'Sélectionnez votre pays et votre type de document, prenez ou choisissez une photo, puis exportez une image conforme et prête à imprimer.';

  @override
  String get onboardingLanguageTitle => 'Choisissez votre langue';

  @override
  String get commonContinue => 'Continuer';

  @override
  String get commonSkip => 'Passer';

  @override
  String get commonStart => 'Commencer';

  @override
  String get commonBack => 'Retour';

  @override
  String get commonCancel => 'Annuler';

  @override
  String get commonRetry => 'Réessayer';

  @override
  String get commonClose => 'Fermer';

  @override
  String get errorGenericTitle => 'Une erreur s\'est produite';

  @override
  String get errorGenericBody => 'Veuillez réessayer.';

  @override
  String get placeholderBody =>
      'Cet écran arrivera dans une phase de build ultérieure.';

  @override
  String get homeSearchHint => 'Rechercher un pays ou un document';

  @override
  String get homePopularTitle => 'Populaires';

  @override
  String get homePassport => 'Passeport';

  @override
  String get homeVisa => 'Visa';

  @override
  String get homeIdCard => 'Carte d\'identité';

  @override
  String get homeCustomSize => 'Taille personnalisée';

  @override
  String get historyEmptyTitle => 'Aucune photo pour l\'instant';

  @override
  String get historyEmptyBody =>
      'Les photos que vous créerez apparaîtront ici.';

  @override
  String get countrySelectTitle => 'Pays et document';

  @override
  String get countrySearchHint => 'Rechercher un pays';

  @override
  String get countryNoResults => 'Aucun pays correspondant';

  @override
  String countryDocumentsCount(int count) {
    return '$count documents';
  }

  @override
  String get specSizeLabel => 'Taille';

  @override
  String get specBackgroundLabel => 'Arrière-plan';

  @override
  String get specDpiLabel => 'Résolution';

  @override
  String get specFormatsLabel => 'Formats';

  @override
  String get specHeadHeightLabel => 'Hauteur de la tête';

  @override
  String get specEyeLineLabel => 'Ligne des yeux depuis le bas';

  @override
  String get specGlassesAllowed => 'Lunettes autorisées';

  @override
  String get specGlassesNotAllowed => 'Lunettes non autorisées';

  @override
  String get specMaxFileSizeLabel => 'Taille de fichier max.';

  @override
  String get specVerifiedBadge => 'Vérifié';

  @override
  String get specUnverifiedBadge => 'Non vérifié';

  @override
  String get specUnverifiedNotice =>
      'Veuillez confirmer auprès de la source officielle.';

  @override
  String get specOfficialSource => 'Source officielle';

  @override
  String specLastVerified(String date) {
    return 'Dernière vérification : $date';
  }

  @override
  String get specUsePhoto => 'Utiliser cette photo';

  @override
  String get specNotSpecified => 'Non spécifié';

  @override
  String get spec_us_passport => 'Passeport des États-Unis';

  @override
  String get spec_gb_passport => 'Passeport du Royaume-Uni';

  @override
  String get spec_ca_passport => 'Passeport du Canada';

  @override
  String get spec_cn_visa => 'Visa pour la Chine';

  @override
  String get spec_de_schengen_visa => 'Allemagne — Visa Schengen';

  @override
  String get spec_fr_schengen_visa => 'France — Visa Schengen';

  @override
  String get spec_it_schengen_visa => 'Italie — Visa Schengen';

  @override
  String get spec_es_schengen_visa => 'Espagne — Visa Schengen';

  @override
  String get captureTitle => 'Prendre une photo';

  @override
  String get captureRationaleTitle => 'Accès à l\'appareil photo requis';

  @override
  String get captureRationaleBody =>
      'PhotoPass utilise votre appareil photo pour prendre une photo de passeport. La photo reste sur votre téléphone et n\'est jamais téléversée.';

  @override
  String get captureRationaleDenied =>
      'L\'accès à l\'appareil photo est désactivé. Activez-le dans les paramètres du système pour prendre une photo, ou choisissez-en une dans votre galerie.';

  @override
  String get captureRationaleAction => 'Autoriser l\'appareil photo';

  @override
  String get captureOpenSettings => 'Ouvrir les paramètres';

  @override
  String get captureCameraError =>
      'Impossible de démarrer l\'appareil photo. Vous pouvez toujours choisir une photo dans votre galerie.';

  @override
  String get captureHintFace => 'Positionnez votre visage dans l\'ovale';

  @override
  String get captureSwitchCamera => 'Changer d\'appareil photo';

  @override
  String get captureGallery => 'Choisir dans la galerie';

  @override
  String get editorTitle => 'Modifier la photo';

  @override
  String get editorRotate => 'Pivoter de 90°';

  @override
  String get editorAutoFit => 'Ajustement automatique au visage';

  @override
  String get editorApply => 'Rogner la photo';

  @override
  String get retouchTitle => 'Arrière-plan et réglages';

  @override
  String get retouchBackground => 'Arrière-plan';

  @override
  String get retouchRemoveBackground => 'Remplacer l\'arrière-plan';

  @override
  String get retouchRemoveBackgroundHint =>
      'Remplace l\'arrière-plan uni derrière vous par une couleur nette.';

  @override
  String retouchTolerance(int value) {
    return 'Tolérance de détection : $value';
  }

  @override
  String get retouchBackgroundColor => 'Couleur de remplacement';

  @override
  String get retouchAdjustments => 'Réglages';

  @override
  String get retouchBrightness => 'Luminosité';

  @override
  String get retouchContrast => 'Contraste';

  @override
  String get retouchSaturation => 'Couleur';

  @override
  String get retouchLocalNote =>
      'Tout le traitement s\'effectue sur cet appareil.';

  @override
  String get retouchApply => 'Continuer';

  @override
  String get complianceTitle => 'Contrôle de conformité';

  @override
  String get complianceIntro =>
      'Ces contrôles comparent votre photo aux exigences officielles. Ils constituent une aide, pas une garantie d\'acceptation.';

  @override
  String get complianceContinue => 'Continuer vers l\'export';

  @override
  String get complianceMeasured => 'Mesuré';

  @override
  String get complianceDimensions => 'Taille de la photo';

  @override
  String get complianceDimensionsDetail =>
      'La photo doit avoir exactement les dimensions en pixels requises.';

  @override
  String get complianceFace => 'Un visage détecté';

  @override
  String get complianceFaceDetail =>
      'La photo doit contenir exactement une personne.';

  @override
  String get complianceHeadHeight => 'Hauteur de la tête';

  @override
  String get complianceHeadHeightDetail =>
      'La hauteur de la tête doit se situer dans la fourchette officielle.';

  @override
  String get complianceEyeLine => 'Position de la ligne des yeux';

  @override
  String get complianceEyeLineDetail =>
      'Les yeux doivent se situer à la hauteur officielle depuis le bas.';

  @override
  String get complianceBackground => 'Couleur et uniformité de l\'arrière-plan';

  @override
  String get complianceBackgroundDetail =>
      'L\'arrière-plan doit être uni et correspondre à la couleur requise.';

  @override
  String get complianceGlasses => 'Lunettes';

  @override
  String get complianceGlassesAllowed =>
      'Les lunettes sont autorisées pour ce document.';

  @override
  String get complianceGlassesForbidden =>
      'Les lunettes ne sont pas autorisées pour ce document.';

  @override
  String get complianceFileSize => 'Taille du fichier';

  @override
  String get complianceFileSizeDetail =>
      'Le fichier doit rester en dessous de la limite de taille officielle.';

  @override
  String get exportTitle => 'Export';

  @override
  String exportSizeLabel(int width, int height) {
    return '$width × $height pixels';
  }

  @override
  String exportDetails(String mm, String dpi) {
    return '$mm mm à $dpi DPI';
  }

  @override
  String get exportSavePhoto => 'Enregistrer la photo';

  @override
  String get exportSavePhotoHint =>
      'Enregistre la photo à la taille exacte dans votre galerie.';

  @override
  String get exportShare => 'Partager';

  @override
  String get exportShareHint =>
      'Envoie la photo terminée à une autre application.';

  @override
  String get exportDoneShare => 'Partagée.';

  @override
  String exportFileSizeLimit(int kb) {
    return 'Taille de fichier maximale : $kb KB';
  }

  @override
  String get exportPdf => 'PDF (prêt à imprimer)';

  @override
  String get exportPdfHint =>
      'Une photo à la taille physique exacte, prête à être imprimée.';

  @override
  String get exportPrintSheetTitle => 'Planches d\'impression';

  @override
  String exportPrintSheet(String size) {
    return 'Planche d\'impression — $size';
  }

  @override
  String get exportPrintSheetHint =>
      'Plusieurs photos disposées sur une feuille de papier photo.';

  @override
  String get exportDoneSave => 'Enregistrée.';

  @override
  String get exportDonePdf => 'PDF prêt à être partagé.';

  @override
  String get exportDoneSheet => 'Planche d\'impression prête à être partagée.';

  @override
  String get exportLocalNote =>
      'Les photos sont créées sur cet appareil. Rien n\'est téléversé.';

  @override
  String get historyDelete => 'Supprimer';

  @override
  String get settingsPrivacy => 'Confidentialité';

  @override
  String get settingsClearHistoryHint =>
      'Supprime toutes les photos enregistrées de cet appareil.';

  @override
  String get settingsClearHistoryConfirm =>
      'Cette action supprime définitivement toutes les photos enregistrées dans l\'application. Elle est irréversible.';

  @override
  String get settingsClearHistoryAction => 'Tout supprimer';

  @override
  String get privacyPolicyBody =>
      'PhotoPass traite vos photos entièrement sur cet appareil.\n\n• Les photos ne sont jamais téléversées vers un serveur.\n• L\'application ne contient ni publicité, ni analyse, ni suivi.\n• Aucun compte ni connexion n\'est requis.\n• Les photos enregistrées sont stockées uniquement dans le stockage privé de l\'application.\n• Le seul accès réseau consiste à ouvrir les liens des sources officielles du gouvernement dans votre navigateur.\n• La suppression de l\'application supprime toutes ses données.';

  @override
  String get settingsAppearance => 'Apparence';

  @override
  String get settingsGeneral => 'Général';

  @override
  String get settingsLanguage => 'Langue';

  @override
  String get settingsThemeLight => 'Clair';

  @override
  String get settingsThemeDark => 'Sombre';

  @override
  String get settingsThemeSystem => 'Système';

  @override
  String get settingsPrivacyPolicy => 'Politique de confidentialité';

  @override
  String get settingsTerms => 'Conditions d\'utilisation';

  @override
  String get settingsRateApp => 'Noter l\'application';

  @override
  String get settingsClearHistory => 'Supprimer toutes les photos enregistrées';

  @override
  String get settingsAbout => 'À propos';

  @override
  String settingsVersion(String version) {
    return 'Version $version';
  }

  @override
  String get disclaimer =>
      'Les exigences peuvent changer. Vérifiez toujours la source officielle. PhotoPass ne peut pas garantir l\'acceptation.';

  @override
  String get homeHeadline => 'Créez une photo de passeport conforme';

  @override
  String get homeCreatePhoto => 'Créer une photo';

  @override
  String get homeRecentTitle => 'Récents';

  @override
  String get homeFavoritesTitle => 'Favoris';

  @override
  String get homeYourPhotosTitle => 'Vos photos';

  @override
  String get homeYourPhotosEmpty =>
      'Les photos que vous créerez apparaîtront ici.';

  @override
  String get specFavoriteAdd => 'Ajouter aux favoris';

  @override
  String get specFavoriteRemove => 'Retirer des favoris';

  @override
  String get editorModeCrop => 'Rogner';

  @override
  String get editorModeBackground => 'Arrière-plan';

  @override
  String get editorModeAdjust => 'Ajuster';

  @override
  String get editorReset => 'Réinitialiser';

  @override
  String get editorDiscardTitle => 'Abandonner les modifications ?';

  @override
  String get editorDiscardBody =>
      'Votre recadrage et vos réglages seront perdus.';

  @override
  String get editorDiscardConfirm => 'Abandonner';

  @override
  String get captureFlash => 'Flash';

  @override
  String get complianceActionRetake =>
      'Reprenez la photo avec un éclairage plus uniforme.';

  @override
  String get complianceActionBackground =>
      'Remplacez l\'arrière-plan ou reprenez la photo devant un mur uni.';

  @override
  String get complianceActionCenter =>
      'Centrez votre visage, utilisez l\'ajustement automatique, puis reprenez la photo.';

  @override
  String get complianceActionDimensions =>
      'Exportez à nouveau pour obtenir la taille exacte requise.';

  @override
  String get complianceActionFilesize =>
      'Exportez au format JPEG pour rester en dessous de la limite de taille.';

  @override
  String get exportAdvancedDetails => 'Détails';

  @override
  String get historyMissingPhoto => 'Fichier photo introuvable';

  @override
  String get swatchRequired => 'Requis';

  @override
  String get swatchSuggested => 'Suggéré';

  @override
  String get editorCropHint =>
      'Faites glisser pour déplacer, pincez pour zoomer.';

  @override
  String get historyReopen => 'Ouvrir';

  @override
  String get historyReopenHint => 'Ouvre cette photo dans l\'éditeur.';
}
