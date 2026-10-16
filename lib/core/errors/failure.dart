/// Recoverable failures surfaced by the app.
///
/// Every feature failure maps to one of these types so the UI can render a
/// friendly, recoverable message instead of a raw exception.
sealed class Failure implements Exception {
  const Failure(this.message, {this.cause});

  /// Technical description, for logging. UI strings come from l10n keys.
  final String message;

  /// Original error, if any.
  final Object? cause;

  @override
  String toString() => '$runtimeType: $message';
}

/// Camera or photo-picker permission denied/refused.
final class PermissionFailure extends Failure {
  const PermissionFailure(super.message, {super.cause});
}

/// No face found, multiple faces, or face unusable for the chosen spec.
final class FaceDetectionFailure extends Failure {
  const FaceDetectionFailure(super.message, {super.cause});
}

/// Image decoding, processing or encoding failed.
final class ImageProcessingFailure extends Failure {
  const ImageProcessingFailure(super.message, {super.cause});
}

/// Writing or reading local files (gallery save, history, temp files).
final class StorageFailure extends Failure {
  const StorageFailure(super.message, {super.cause});
}

/// Preset database could not be loaded or is invalid.
final class PresetLoadFailure extends Failure {
  const PresetLoadFailure(super.message, {super.cause});
}

/// Anything not covered above.
final class UnknownFailure extends Failure {
  const UnknownFailure(super.message, {super.cause});
}
