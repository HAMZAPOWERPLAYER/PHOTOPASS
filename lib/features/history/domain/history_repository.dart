/// A saved photo record in local history. Stored as JSON on-device only.
class HistoryEntry {
  const HistoryEntry({
    required this.id,
    required this.filePath,
    required this.specId,
    required this.countryCode,
    required this.createdAt,
  });

  final String id;
  final String filePath;
  final String specId;
  final String countryCode;

  /// ISO-8601 timestamp.
  final String createdAt;

  Map<String, Object?> toJson() => {
    'id': id,
    'filePath': filePath,
    'specId': specId,
    'countryCode': countryCode,
    'createdAt': createdAt,
  };

  factory HistoryEntry.fromJson(Map<String, dynamic> json) => HistoryEntry(
    id: json['id']! as String,
    filePath: json['filePath']! as String,
    specId: json['specId']! as String,
    countryCode: json['countryCode']! as String,
    createdAt: json['createdAt']! as String,
  );
}

/// Local history storage. Abstracted so the UI never touches files directly.
abstract interface class HistoryRepository {
  Future<List<HistoryEntry>> list();

  Future<void> add(HistoryEntry entry);

  Future<void> remove(String id);

  /// Removes every entry **and** deletes the stored photo files.
  Future<void> clearAll();
}
