import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/prefs/app_prefs.dart';

const _kOnboardingDone = 'onboardingDone';
const _kFavourites = 'favouriteSpecs';
const _kRecents = 'recentSpecs';

/// Whether onboarding has been completed (persisted; spec §33.1).
class OnboardingController extends Notifier<bool> {
  @override
  bool build() => ref.read(appPrefsProvider)?.getBool(_kOnboardingDone) ?? false;

  void complete() {
    state = true;
    final prefs = ref.read(appPrefsProvider);
    if (prefs != null) prefs.setBool(_kOnboardingDone, true).ignore();
  }
}

final onboardingDoneProvider =
    NotifierProvider<OnboardingController, bool>(OnboardingController.new);

/// Favourite specification ids (persisted; spec §33.3).
class FavouritesController extends Notifier<Set<String>> {
  @override
  Set<String> build() =>
      ref.read(appPrefsProvider)?.getStringList(_kFavourites)?.toSet() ??
      <String>{};

  void toggle(String specId) {
    final next = Set<String>.of(state);
    if (!next.remove(specId)) next.add(specId);
    state = next;
    final prefs = ref.read(appPrefsProvider);
    if (prefs != null) prefs.setStringList(_kFavourites, next.toList()).ignore();
  }
}

final favouritesProvider =
    NotifierProvider<FavouritesController, Set<String>>(FavouritesController.new);

/// Recently used specification ids, most recent first (persisted; §33.2).
class RecentSpecsController extends Notifier<List<String>> {
  static const _max = 6;

  @override
  List<String> build() =>
      ref.read(appPrefsProvider)?.getStringList(_kRecents)?.toList() ??
      <String>[];

  void record(String specId) {
    final next = <String>[
      specId,
      ...state.where((id) => id != specId),
    ].take(_max).toList();
    state = next;
    final prefs = ref.read(appPrefsProvider);
    if (prefs != null) prefs.setStringList(_kRecents, next).ignore();
  }

  void remove(String specId) {
    final next = state.where((id) => id != specId).toList();
    state = next;
    final prefs = ref.read(appPrefsProvider);
    if (prefs != null) prefs.setStringList(_kRecents, next).ignore();
  }
}

final recentSpecsProvider =
    NotifierProvider<RecentSpecsController, List<String>>(RecentSpecsController.new);
