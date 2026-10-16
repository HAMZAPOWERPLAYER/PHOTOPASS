import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Phase 10 localization gate.
///
/// Verifies that every supported locale ships a complete, well-formed ARB
/// file: full key parity with the English template, intact placeholders and
/// genuinely translated (not English-copied) content.
void main() {
  final root = Directory.current.path;
  final l10nDir = '$root${Platform.pathSeparator}lib${Platform.pathSeparator}l10n';
  final template = jsonDecode(
    File('$l10nDir${Platform.pathSeparator}app_en.arb').readAsStringSync(),
  ) as Map<String, dynamic>;

  final templateMessages = <String, String>{
    for (final entry in template.entries)
      if (!entry.key.startsWith('@')) entry.key: entry.value as String,
  };
  final templatePlaceholders = <String, Set<String>>{
    for (final entry in template.entries)
      if (entry.key.startsWith('@') && entry.key != '@@locale')
        entry.key.substring(1): {
          for (final placeholder
              in ((entry.value as Map<String, dynamic>)['placeholders']
                      as Map<String, dynamic>? ??
                  const <String, dynamic>{})
                .keys)
            placeholder,
        },
  };

  final arbFiles = Directory(l10nDir)
      .listSync()
      .whereType<File>()
      .where((file) => file.path.endsWith('.arb') && !file.path.endsWith('app_en.arb'))
      .toList()
    ..sort((a, b) => a.path.compareTo(b.path));

  test('all 14 non-English locales are present', () {
    final codes = arbFiles
        .map((file) => file.uri.pathSegments.last.replaceFirst('app_', '').replaceFirst('.arb', ''))
        .toList();
    expect(
      codes,
      ['ar', 'bn', 'de', 'es', 'fa', 'fr', 'hi', 'id', 'ja', 'pt', 'ru', 'tr', 'ur', 'zh'],
    );
  });

  for (final file in arbFiles) {
    final name = file.uri.pathSegments.last;
    final locale = name.replaceFirst('app_', '').replaceFirst('.arb', '');

    group('[$locale] localization', () {
      late Map<String, dynamic> arb;

      setUp(() {
        arb = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      });

      test('is valid JSON with a matching @@locale', () {
        expect(arb['@@locale'], locale);
      });

      test('has full key parity with the English template', () {
        final missing = templateMessages.keys
            .where((key) => !arb.containsKey(key))
            .toList();
        final extra = arb.keys
            .where((key) =>
                !key.startsWith('@') && !templateMessages.containsKey(key))
            .toList();
        expect(missing, isEmpty, reason: 'missing keys: $missing');
        expect(extra, isEmpty, reason: 'extra keys: $extra');
      });

      test('has no empty translations', () {
        final empty = templateMessages.keys
            .where((key) => (arb[key] as String? ?? '').trim().isEmpty)
            .toList();
        expect(empty, isEmpty, reason: 'empty values: $empty');
      });

      test('preserves every placeholder of the template', () {
        final broken = <String>[];
        for (final entry in templatePlaceholders.entries) {
          final value = arb[entry.key] as String? ?? '';
          for (final placeholder in entry.value) {
            if (!value.contains('{$placeholder}')) {
              broken.add('${entry.key}: missing {$placeholder}');
            }
          }
        }
        expect(broken, isEmpty, reason: broken.join('\n'));
      });

      test('copies placeholder metadata with identical types', () {
        for (final entry in templatePlaceholders.entries) {
          final meta = arb['@${entry.key}'];
          expect(meta, isNotNull, reason: 'missing @${entry.key}');
          final templateTypes = (template['@${entry.key}']
                  as Map<String, dynamic>)['placeholders'] as Map<String, dynamic>;
          final types = (meta as Map<String, dynamic>)['placeholders']
              as Map<String, dynamic>;
          expect(types.keys.toSet(), templateTypes.keys.toSet(),
              reason: '@${entry.key} placeholders differ');
          for (final key in templateTypes.keys) {
            expect(
              (types[key] as Map<String, dynamic>)['type'],
              (templateTypes[key] as Map<String, dynamic>)['type'],
              reason: '@${entry.key}.$key type differs',
            );
          }
        }
      });

      test('is actually translated, not copied from English', () {
        // The brand name may legitimately stay "PhotoPass".
        const allowIdentical = {'appTitle'};
        final identical = templateMessages.entries
            .where((entry) =>
                !allowIdentical.contains(entry.key) &&
                arb[entry.key] == entry.value)
            .map((entry) => entry.key)
            .toList();
        // A handful of near-technical strings may match by coincidence, but
        // wholesale English copying must fail loudly.
        expect(
          identical.length,
          lessThan(templateMessages.length ~/ 10),
          reason: 'too many untranslated keys: $identical',
        );
        // Core UI strings must always be translated.
        for (final key in [
          'navHome',
          'navSettings',
          'commonContinue',
          'onboardingPrivacyTitle',
          'settingsLanguage',
        ]) {
          expect(arb[key], isNot(templateMessages[key]),
              reason: '$key is still English');
        }
      });

      test('keeps bullet formatting in the privacy policy body', () {
        final body = arb['privacyPolicyBody'] as String;
        expect(body, contains('•'));
        expect(body, contains('\n\n'));
        final bullets = '•'.allMatches(body).length;
        expect(bullets, 6, reason: 'privacy policy must keep its 6 bullets');
      });
    });
  }
}
