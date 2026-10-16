/// Pure search helpers over the spec database — fully unit-testable.
library;

import 'photo_spec.dart';

/// Filters [specs] by [query] against country code, country name, document
/// type label and spec id. Empty/blank queries return everything.
List<PhotoSpec> searchSpecs(
  List<PhotoSpec> specs,
  String query, {
  Map<String, String> countryNames = const {},
}) {
  final normalized = query.trim().toLowerCase();
  if (normalized.isEmpty) return specs;

  return specs.where((spec) {
    final countryName =
        (countryNames[spec.countryCode] ?? spec.countryCode).toLowerCase();
    return spec.countryCode.toLowerCase().contains(normalized) ||
        countryName.contains(normalized) ||
        spec.documentType.wireName.contains(normalized) ||
        spec.id.toLowerCase().contains(normalized);
  }).toList(growable: false);
}

/// Groups specs by country code, preserving first-seen order.
Map<String, List<PhotoSpec>> groupByCountry(List<PhotoSpec> specs) {
  final grouped = <String, List<PhotoSpec>>{};
  for (final spec in specs) {
    grouped.putIfAbsent(spec.countryCode, () => []).add(spec);
  }
  return grouped;
}
