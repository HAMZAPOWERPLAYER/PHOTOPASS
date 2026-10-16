import 'package:flutter/services.dart' show rootBundle;

import '../../../core/errors/failure.dart';
import '../../../core/errors/result.dart';
import '../../country_select/domain/photo_spec.dart';
import '../../country_select/domain/spec_repository.dart';

/// Bundled-asset implementation of [SpecRepository].
class AssetSpecRepository implements SpecRepository {
  const AssetSpecRepository({this.assetPath = _defaultAssetPath});

  static const String _defaultAssetPath = 'assets/presets/photo_specs.json';

  /// Highest preset schema version this build understands.
  static const int supportedSchemaVersion = 1;

  final String assetPath;

  @override
  Future<Result<List<PhotoSpec>>> loadSpecs() async {
    try {
      final raw = await rootBundle.loadString(assetPath);
      final version = PhotoSpec.schemaVersionFromJsonString(raw);
      if (version > supportedSchemaVersion) {
        return FailureResult(
          PresetLoadFailure(
            'Preset schema $version is newer than supported '
            '$supportedSchemaVersion',
          ),
        );
      }
      return Success(PhotoSpec.listFromJsonString(raw));
    } on Object catch (error) {
      return FailureResult(
        PresetLoadFailure('Could not load presets from $assetPath', cause: error),
      );
    }
  }
}
