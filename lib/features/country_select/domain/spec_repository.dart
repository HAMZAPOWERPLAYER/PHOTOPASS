import '../../../core/errors/result.dart';
import 'photo_spec.dart';

/// Loads photo specifications from the bundled preset database.
///
/// Abstract here, implemented in data/ — swapping the JSON asset for a
/// downloaded (but still on-device) database later only touches data/.
abstract interface class SpecRepository {
  /// Reads, parses and validates every bundled spec.
  ///
  /// Fails with [PresetLoadFailure] if the file is missing, its
  /// `schemaVersion` is unsupported, or any spec is malformed.
  Future<Result<List<PhotoSpec>>> loadSpecs();
}
