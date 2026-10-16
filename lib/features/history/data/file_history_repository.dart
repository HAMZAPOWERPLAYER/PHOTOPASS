import 'dart:convert' show jsonDecode, jsonEncode;
import 'dart:io' show Directory, File, Platform;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import '../../../core/errors/failure.dart';
import '../../../core/errors/result.dart';
import '../domain/history_repository.dart';

/// JSON-file backed local history (app-private documents directory).
/// No cloud, no sync — data lives and dies on the device.
class FileHistoryRepository implements HistoryRepository {
  const FileHistoryRepository();

  Future<File> _indexFile() async {
    final dir = await getApplicationDocumentsDirectory();
    final historyDir = Directory('${dir.path}${Platform.pathSeparator}history');
    if (!await historyDir.exists()) {
      await historyDir.create(recursive: true);
    }
    return File('${historyDir.path}${Platform.pathSeparator}index.json');
  }

  Future<Directory> _photosDir() async {
    final dir = await getApplicationDocumentsDirectory();
    final photosDir = Directory('${dir.path}${Platform.pathSeparator}history${Platform.pathSeparator}photos');
    if (!await photosDir.exists()) {
      await photosDir.create(recursive: true);
    }
    return photosDir;
  }

  @override
  Future<List<HistoryEntry>> list() async {
    try {
      final file = await _indexFile();
      if (!await file.exists()) return const [];
      final decoded = jsonDecode(await file.readAsString());
      if (decoded is! List<Object?>) return const [];
      return decoded
          .map((item) => HistoryEntry.fromJson(item! as Map<String, dynamic>))
          .toList(growable: false);
    } on Exception {
      return const [];
    }
  }

  @override
  Future<void> add(HistoryEntry entry) async {
    final current = await list();
    final file = await _indexFile();
    await file.writeAsString(
      jsonEncode([entry.toJson(), ...current.map((e) => e.toJson())]),
      flush: true,
    );
  }

  @override
  Future<void> remove(String id) async {
    final current = await list();
    final target = current.where((entry) => entry.id == id).firstOrNull;
    if (target != null) {
      final photo = File(target.filePath);
      if (await photo.exists()) await photo.delete();
    }
    final file = await _indexFile();
    await file.writeAsString(
      jsonEncode(current.where((entry) => entry.id != id).map((e) => e.toJson()).toList()),
      flush: true,
    );
  }

  @override
  Future<void> clearAll() async {
    final dir = await _photosDir();
    if (await dir.exists()) {
      await for (final entity in dir.list()) {
        if (entity is File) await entity.delete();
      }
    }
    final file = await _indexFile();
    if (await file.exists()) await file.writeAsString('[]', flush: true);
  }

  /// Copies [sourcePath] into the private photos dir and records it.
  Future<Result<HistoryEntry>> importPhoto({
    required String sourcePath,
    required String specId,
    required String countryCode,
  }) async {
    try {
      final dir = await _photosDir();
      final id = DateTime.now().microsecondsSinceEpoch.toString();
      final ext = sourcePath.substring(sourcePath.lastIndexOf('.'));
      final dest = File('${dir.path}${Platform.pathSeparator}$id$ext');
      await File(sourcePath).copy(dest.path);
      final entry = HistoryEntry(
        id: id,
        filePath: dest.path,
        specId: specId,
        countryCode: countryCode,
        createdAt: DateTime.now().toIso8601String(),
      );
      await add(entry);
      return Success(entry);
    } on Exception catch (error) {
      return FailureResult(StorageFailure('history save failed', cause: error));
    }
  }
}

final historyRepositoryProvider = Provider<HistoryRepository>(
  (ref) => const FileHistoryRepository(),
);
