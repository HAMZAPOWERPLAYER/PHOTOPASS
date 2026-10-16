import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/flow/user_data_controller.dart';
import '../../../core/errors/result_extensions.dart';
import '../domain/photo_spec.dart';
import 'spec_providers.dart';

/// Resolves the user's favourite specifications to full spec objects.
final favouriteSpecListProvider = Provider<List<PhotoSpec>>((ref) {
  final favourites = ref.watch(favouritesProvider);
  final specs = _specMap(ref);
  return [for (final id in favourites) ?(specs[id])];
});

/// Recently used specifications, most recent first (spec §33.2).
final recentSpecListProvider = Provider<List<PhotoSpec>>((ref) {
  final recents = ref.watch(recentSpecsProvider);
  final specs = _specMap(ref);
  return [for (final id in recents) ?(specs[id])];
});

Map<String, PhotoSpec> _specMap(Ref ref) {
  final async = ref.watch(photoSpecsProvider);
  final result = async.value;
  if (result == null || !result.isSuccess) return const {};
  return {for (final spec in result.requireValue) spec.id: spec};
}
