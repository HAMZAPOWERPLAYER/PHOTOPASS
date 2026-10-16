// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'PhotoPass';

  @override
  String get navHome => 'Início';

  @override
  String get navHistory => 'Histórico';

  @override
  String get navSettings => 'Configurações';

  @override
  String get onboardingPrivacyTitle => 'Suas fotos nunca saem do seu celular';

  @override
  String get onboardingPrivacyBody =>
      'O PhotoPass detecta rostos, remove o fundo e exporta sua foto inteiramente no seu dispositivo. Sem conta, sem upload na nuvem e sem análise das suas imagens.';

  @override
  String get onboardingHowTitle => 'Três passos simples';

  @override
  String get onboardingHowBody =>
      'Escolha seu país e o tipo de documento, tire ou selecione uma foto e exporte uma imagem em conformidade, pronta para impressão.';

  @override
  String get onboardingLanguageTitle => 'Escolha seu idioma';

  @override
  String get commonContinue => 'Continuar';

  @override
  String get commonSkip => 'Pular';

  @override
  String get commonStart => 'Começar';

  @override
  String get commonBack => 'Voltar';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonRetry => 'Tentar novamente';

  @override
  String get commonClose => 'Fechar';

  @override
  String get errorGenericTitle => 'Algo deu errado';

  @override
  String get errorGenericBody => 'Por favor, tente novamente.';

  @override
  String get placeholderBody =>
      'Esta tela chega em uma fase posterior de desenvolvimento.';

  @override
  String get homeSearchHint => 'Buscar país ou documento';

  @override
  String get homePopularTitle => 'Populares';

  @override
  String get homePassport => 'Passaporte';

  @override
  String get homeVisa => 'Visto';

  @override
  String get homeIdCard => 'Cartão de identidade';

  @override
  String get homeCustomSize => 'Tamanho personalizado';

  @override
  String get historyEmptyTitle => 'Nenhuma foto ainda';

  @override
  String get historyEmptyBody => 'As fotos que você criar aparecerão aqui.';

  @override
  String get countrySelectTitle => 'País e documento';

  @override
  String get countrySearchHint => 'Buscar país';

  @override
  String get countryNoResults => 'Nenhum país correspondente';

  @override
  String countryDocumentsCount(int count) {
    return '$count documentos';
  }

  @override
  String get specSizeLabel => 'Tamanho';

  @override
  String get specBackgroundLabel => 'Fundo';

  @override
  String get specDpiLabel => 'Resolução';

  @override
  String get specFormatsLabel => 'Formatos';

  @override
  String get specHeadHeightLabel => 'Altura da cabeça';

  @override
  String get specEyeLineLabel => 'Linha dos olhos a partir da base';

  @override
  String get specGlassesAllowed => 'Óculos permitidos';

  @override
  String get specGlassesNotAllowed => 'Óculos não permitidos';

  @override
  String get specMaxFileSizeLabel => 'Tamanho máximo do arquivo';

  @override
  String get specVerifiedBadge => 'Verificado';

  @override
  String get specUnverifiedBadge => 'Não verificado';

  @override
  String get specUnverifiedNotice => 'Confirme com a fonte oficial.';

  @override
  String get specOfficialSource => 'Fonte oficial';

  @override
  String specLastVerified(String date) {
    return 'Última verificação em $date';
  }

  @override
  String get specUsePhoto => 'Usar esta foto';

  @override
  String get specNotSpecified => 'Não especificado';

  @override
  String get spec_us_passport => 'Passaporte dos Estados Unidos';

  @override
  String get spec_gb_passport => 'Passaporte do Reino Unido';

  @override
  String get spec_ca_passport => 'Passaporte do Canadá';

  @override
  String get spec_cn_visa => 'Visto para a China';

  @override
  String get spec_de_schengen_visa => 'Alemanha — visto Schengen';

  @override
  String get spec_fr_schengen_visa => 'França — visto Schengen';

  @override
  String get spec_it_schengen_visa => 'Itália — visto Schengen';

  @override
  String get spec_es_schengen_visa => 'Espanha — visto Schengen';

  @override
  String get captureTitle => 'Tirar uma foto';

  @override
  String get captureRationaleTitle => 'Acesso à câmera necessário';

  @override
  String get captureRationaleBody =>
      'O PhotoPass usa sua câmera para tirar uma foto de passaporte. A foto fica no seu celular e nunca é enviada.';

  @override
  String get captureRationaleDenied =>
      'O acesso à câmera está desativado. Ative-o nas configurações do sistema para tirar uma foto ou escolha uma da sua galeria.';

  @override
  String get captureRationaleAction => 'Permitir câmera';

  @override
  String get captureOpenSettings => 'Abrir configurações';

  @override
  String get captureCameraError =>
      'Não foi possível iniciar a câmera. Você ainda pode escolher uma foto da sua galeria.';

  @override
  String get captureHintFace => 'Posicione o rosto dentro do óvalo';

  @override
  String get captureSwitchCamera => 'Trocar câmera';

  @override
  String get captureGallery => 'Escolher da galeria';

  @override
  String get editorTitle => 'Editar foto';

  @override
  String get editorRotate => 'Girar 90°';

  @override
  String get editorAutoFit => 'Ajustar automaticamente ao rosto';

  @override
  String get editorApply => 'Recortar foto';

  @override
  String get retouchTitle => 'Fundo e ajustes';

  @override
  String get retouchBackground => 'Fundo';

  @override
  String get retouchRemoveBackground => 'Substituir fundo';

  @override
  String get retouchRemoveBackgroundHint =>
      'Preenche o fundo liso atrás de você com uma cor limpa.';

  @override
  String retouchTolerance(int value) {
    return 'Tolerância de detecção: $value';
  }

  @override
  String get retouchBackgroundColor => 'Cor de substituição';

  @override
  String get retouchAdjustments => 'Ajustes';

  @override
  String get retouchBrightness => 'Brilho';

  @override
  String get retouchContrast => 'Contraste';

  @override
  String get retouchSaturation => 'Cor';

  @override
  String get retouchLocalNote =>
      'Todo o processamento acontece neste dispositivo.';

  @override
  String get retouchApply => 'Continuar';

  @override
  String get complianceTitle => 'Verificação de conformidade';

  @override
  String get complianceIntro =>
      'Estas verificações comparam sua foto com os requisitos oficiais. Elas são orientação, não uma garantia de aceitação.';

  @override
  String get complianceContinue => 'Continuar para a exportação';

  @override
  String get complianceMeasured => 'Medido';

  @override
  String get complianceDimensions => 'Tamanho da foto';

  @override
  String get complianceDimensionsDetail =>
      'A foto deve ter exatamente as dimensões em pixels exigidas.';

  @override
  String get complianceFace => 'Um rosto detectado';

  @override
  String get complianceFaceDetail =>
      'A foto deve conter exatamente uma pessoa.';

  @override
  String get complianceHeadHeight => 'Altura da cabeça';

  @override
  String get complianceHeadHeightDetail =>
      'A altura da cabeça deve estar dentro da faixa oficial.';

  @override
  String get complianceEyeLine => 'Posição da linha dos olhos';

  @override
  String get complianceEyeLineDetail =>
      'Os olhos devem estar na altura oficial contada a partir da base.';

  @override
  String get complianceBackground => 'Cor e uniformidade do fundo';

  @override
  String get complianceBackgroundDetail =>
      'O fundo deve ser liso e corresponder à cor exigida.';

  @override
  String get complianceGlasses => 'Óculos';

  @override
  String get complianceGlassesAllowed =>
      'Óculos são permitidos para este documento.';

  @override
  String get complianceGlassesForbidden =>
      'Óculos não são permitidos para este documento.';

  @override
  String get complianceFileSize => 'Tamanho do arquivo';

  @override
  String get complianceFileSizeDetail =>
      'O arquivo deve permanecer abaixo do limite de tamanho oficial.';

  @override
  String get exportTitle => 'Exportar';

  @override
  String exportSizeLabel(int width, int height) {
    return '$width × $height pixels';
  }

  @override
  String exportDetails(String mm, String dpi) {
    return '$mm mm a $dpi DPI';
  }

  @override
  String get exportSavePhoto => 'Salvar foto';

  @override
  String get exportSavePhotoHint =>
      'Salva a foto no tamanho exato na sua galeria.';

  @override
  String get exportShare => 'Compartilhar';

  @override
  String get exportShareHint => 'Envia a foto pronta para outro aplicativo.';

  @override
  String get exportDoneShare => 'Compartilhada.';

  @override
  String exportFileSizeLimit(int kb) {
    return 'Tamanho máximo do arquivo: $kb KB';
  }

  @override
  String get exportPdf => 'PDF (pronto para impressão)';

  @override
  String get exportPdfHint =>
      'Uma foto no tamanho físico exato, pronta para imprimir.';

  @override
  String get exportPrintSheetTitle => 'Folhas de impressão';

  @override
  String exportPrintSheet(String size) {
    return 'Folha de impressão — $size';
  }

  @override
  String get exportPrintSheetHint =>
      'Várias fotos organizadas em uma folha de papel fotográfico.';

  @override
  String get exportDoneSave => 'Salva.';

  @override
  String get exportDonePdf => 'PDF pronto para compartilhar.';

  @override
  String get exportDoneSheet => 'Folha de impressão pronta para compartilhar.';

  @override
  String get exportLocalNote =>
      'As fotos são criadas neste dispositivo. Nada é enviado.';

  @override
  String get historyDelete => 'Excluir';

  @override
  String get settingsPrivacy => 'Privacidade';

  @override
  String get settingsClearHistoryHint =>
      'Exclui todas as fotos salvas deste dispositivo.';

  @override
  String get settingsClearHistoryConfirm =>
      'Isso exclui permanentemente todas as fotos salvas no aplicativo. Esta ação não pode ser desfeita.';

  @override
  String get settingsClearHistoryAction => 'Excluir tudo';

  @override
  String get privacyPolicyBody =>
      'PhotoPass processa suas fotos inteiramente neste dispositivo.\n\n• As fotos nunca são enviadas a nenhum servidor.\n• O aplicativo não contém anúncios, análise de dados nem rastreamento.\n• Nenhuma conta ou login é necessário.\n• As fotos salvas ficam apenas no armazenamento privado do aplicativo.\n• O único acesso à rede é a abertura de links de fontes oficiais do governo no seu navegador.\n• Excluir o aplicativo remove todos os seus dados.';

  @override
  String get settingsAppearance => 'Aparência';

  @override
  String get settingsGeneral => 'Geral';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsThemeLight => 'Claro';

  @override
  String get settingsThemeDark => 'Escuro';

  @override
  String get settingsThemeSystem => 'Sistema';

  @override
  String get settingsPrivacyPolicy => 'Política de privacidade';

  @override
  String get settingsTerms => 'Termos de uso';

  @override
  String get settingsRateApp => 'Avaliar o aplicativo';

  @override
  String get settingsClearHistory => 'Excluir todas as fotos salvas';

  @override
  String get settingsAbout => 'Sobre';

  @override
  String settingsVersion(String version) {
    return 'Versão $version';
  }

  @override
  String get disclaimer =>
      'Os requisitos podem mudar. Sempre verifique a fonte oficial. O PhotoPass não pode garantir a aceitação.';

  @override
  String get homeHeadline => 'Crie uma foto de passaporte em conformidade';

  @override
  String get homeCreatePhoto => 'Criar uma foto';

  @override
  String get homeRecentTitle => 'Recentes';

  @override
  String get homeFavoritesTitle => 'Favoritos';

  @override
  String get homeYourPhotosTitle => 'Suas fotos';

  @override
  String get homeYourPhotosEmpty => 'As fotos que você criar aparecerão aqui.';

  @override
  String get specFavoriteAdd => 'Adicionar aos favoritos';

  @override
  String get specFavoriteRemove => 'Remover dos favoritos';

  @override
  String get editorModeCrop => 'Recortar';

  @override
  String get editorModeBackground => 'Fundo';

  @override
  String get editorModeAdjust => 'Ajustar';

  @override
  String get editorReset => 'Redefinir';

  @override
  String get editorDiscardTitle => 'Descartar alterações?';

  @override
  String get editorDiscardBody => 'Seu recorte e seus ajustes serão perdidos.';

  @override
  String get editorDiscardConfirm => 'Descartar';

  @override
  String get captureFlash => 'Flash';

  @override
  String get complianceActionRetake =>
      'Tire a foto novamente com uma iluminação mais uniforme.';

  @override
  String get complianceActionBackground =>
      'Substitua o fundo ou tire a foto novamente contra uma parede lisa.';

  @override
  String get complianceActionCenter =>
      'Centralize o rosto, use o ajuste automático e tire a foto novamente.';

  @override
  String get complianceActionDimensions =>
      'Exporte novamente para gerar o tamanho exato exigido.';

  @override
  String get complianceActionFilesize =>
      'Exporte como JPEG para manter-se abaixo do limite de tamanho.';

  @override
  String get exportAdvancedDetails => 'Detalhes';

  @override
  String get historyMissingPhoto => 'Arquivo da foto não encontrado';

  @override
  String get swatchRequired => 'Obrigatório';

  @override
  String get swatchSuggested => 'Sugerido';

  @override
  String get editorCropHint =>
      'Arraste para mover, junte os dedos para ampliar.';

  @override
  String get historyReopen => 'Abrir';

  @override
  String get historyReopenHint => 'Abre esta foto no editor.';
}
