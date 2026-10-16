import 'failure.dart';

/// Explicit success/failure wrapper — no exceptions across feature boundaries.
///
/// Use in domain/data layers:
/// ```dart
/// Future<Result<PhotoSpec>> load() async => ...
/// ```
sealed class Result<T> {
  const Result();

  bool get isSuccess => this is Success<T>;

  R when<R>({
    required R Function(T value) success,
    required R Function(Failure failure) failure,
  }) =>
      switch (this) {
        final Success<T> v => success(v.value),
        final FailureResult<T> f => failure(f.failure),
      };
}

/// Successful [Result] carrying [value].
final class Success<T> extends Result<T> {
  const Success(this.value);

  final T value;
}

/// Failed [Result] carrying a [Failure].
final class FailureResult<T> extends Result<T> {
  const FailureResult(this.failure);

  final Failure failure;
}
