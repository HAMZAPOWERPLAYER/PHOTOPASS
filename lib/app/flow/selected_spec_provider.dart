import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/country_select/domain/photo_spec.dart';

/// The spec the user chose on the details screen; drives capture, editor
/// and export. Null until a spec is selected.
class SelectedSpecController extends Notifier<PhotoSpec?> {
  @override
  PhotoSpec? build() => null;

  void select(PhotoSpec spec) => state = spec;

  void clear() => state = null;
}

final selectedSpecProvider =
    NotifierProvider<SelectedSpecController, PhotoSpec?>(
  SelectedSpecController.new,
);
