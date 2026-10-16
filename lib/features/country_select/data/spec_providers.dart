import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/errors/result.dart';
import '../domain/photo_spec.dart';
import '../domain/spec_repository.dart';
import 'asset_spec_repository.dart';

/// DI: one repository instance for the whole app.
final specRepositoryProvider = Provider<SpecRepository>(
  (ref) => const AssetSpecRepository(),
);

/// All bundled specs, loaded once at startup and cached.
final photoSpecsProvider = FutureProvider<Result<List<PhotoSpec>>>(
  (ref) => ref.watch(specRepositoryProvider).loadSpecs(),
);
