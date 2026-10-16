import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/errors/result_extensions.dart';
import '../../country_select/data/spec_providers.dart';
import '../../country_select/domain/photo_spec.dart';
import '../domain/history_repository.dart';
import 'file_history_repository.dart';

/// Reactive view over local history.
class HistoryState {
  const HistoryState({this.entries = const [], this.loading = true});

  final List<HistoryEntry> entries;
  final bool loading;
}

class HistoryController extends Notifier<HistoryState> {
  @override
  HistoryState build() {
    Future.microtask(refresh);
    return const HistoryState();
  }

  Future<void> refresh() async {
    final entries = await ref.read(historyRepositoryProvider).list();
    state = HistoryState(entries: entries, loading: false);
  }

  Future<void> remove(String id) async {
    await ref.read(historyRepositoryProvider).remove(id);
    await refresh();
  }

  /// Deletes all saved photos and files (Settings → privacy controls).
  Future<void> clearAll() async {
    await ref.read(historyRepositoryProvider).clearAll();
    await refresh();
  }
}

final historyProvider = NotifierProvider<HistoryController, HistoryState>(
  HistoryController.new,
);

/// The spec a history entry refers to (null if the preset was removed).
final historySpecProvider = Provider.family<PhotoSpec?, String>((ref, specId) {
  final async = ref.watch(photoSpecsProvider);
  final result = async.value;
  if (result == null) return null;
  final specs = result.isSuccess ? result.requireValue : const <PhotoSpec>[];
  return specs.where((spec) => spec.id == specId).firstOrNull;
});
