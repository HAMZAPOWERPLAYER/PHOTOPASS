import 'failure.dart';
import 'result.dart';

extension ResultX<T> on Result<T> {
  /// The failure, when this result failed.
  Failure? get failureOrNull => switch (this) {
    final Success<T> _ => null,
    final FailureResult<T> f => f.failure,
  };

  /// The value when successful; throws when failed (guard with
  /// [failureOrNull] first).
  T get requireValue => switch (this) {
    final Success<T> v => v.value,
    final FailureResult<T> f => throw StateError('Failed result: ${f.failure}'),
  };
}
