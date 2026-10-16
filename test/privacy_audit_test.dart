import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Phase 9 privacy audit.
///
/// These checks are a permanent CI gate: they fail the build if the app ever
/// gains a forbidden dependency, a network code path, or a permission that
/// would contradict the free/offline promises in docs/product_policy.md.

/// Packages that would break the free-forever or offline promise.
const forbiddenPackages = <String>[
  'firebase_core',
  'firebase_analytics',
  'firebase_crashlytics',
  'google_mobile_ads',
  'admob',
  'unity_ads',
  'applovin',
  'in_app_purchase',
  'flutter_stripe',
  'pay',
  'purchases_flutter',
  'subscription',
  'http',
  'dio',
  'socket',
  'web_socket',
  'grpc',
  'sentry',
  'sentry_flutter',
  'amplitude_flutter',
  'mixpanel_flutter',
  'facebook_app_events',
  'adjust_sdk',
  'appsflyer_sdk',
  'connectivity_plus',
  'device_info_plus',
  'package_info_plus',
];

/// Dart source patterns that indicate an outbound network path.
const forbiddenSourcePatterns = <Pattern>[
  'package:http/',
  'package:dio/',
  'HttpClient(',
  'WebSocket.connect',
  'Process.run',
  'DynamicLibrary.open',
];

void main() {
  final root = Directory.current.path;

  group('dependency audit', () {
    test('pubspec declares no analytics, ads, billing or HTTP package', () {
      final pubspec = File('$root${Platform.pathSeparator}pubspec.yaml')
          .readAsStringSync()
          .toLowerCase();
      final declared = pubspec
          .split('\n')
          .where((line) => !line.trimLeft().startsWith('#'))
          .join('\n');
      for (final name in forbiddenPackages) {
        final wordBoundary = RegExp('(^|[\r\n\\s])$name:',
            multiLine: true, caseSensitive: false);
        expect(
          wordBoundary.hasMatch(declared),
          isFalse,
          reason: 'forbidden dependency "$name" found in pubspec.yaml',
        );
      }
    });

    test('no monetization keys or plugins exist', () {
      final pubspec = File('$root${Platform.pathSeparator}pubspec.yaml')
          .readAsStringSync()
          .toLowerCase();
      expect(pubspec.contains('billing'), isFalse);
      expect(pubspec.contains('paywall'), isFalse);
      expect(pubspec.contains('iap'), isFalse);
    });

    test('lib has no feature-gating or paywall vocabulary', () {
      final banned = [
        'paywall',
        'premium_',
        'pro_',
        'subscription',
        'upgrade_to',
        'free_trial',
        'watermark',
      ];
      final offenders = <String>[];
      final libDir = Directory('$root${Platform.pathSeparator}lib');
      for (final file in libDir.listSync(recursive: true)) {
        if (file is! File || !file.path.endsWith('.dart')) continue;
        final lines = file.readAsLinesSync();
        for (var i = 0; i < lines.length; i++) {
          for (final word in banned) {
            if (lines[i].toLowerCase().contains(word)) {
              offenders.add('${file.path}:${i + 1} -> $word');
            }
          }
        }
      }
      expect(offenders, isEmpty,
          reason: 'feature-gating vocabulary found:\n${offenders.join('\n')}');
    });
  });

  group('source audit', () {
    test('lib contains no outbound network code path', () {
      final libDir = Directory('$root${Platform.pathSeparator}lib');
      final offenders = <String>[];
      for (final file in libDir.listSync(recursive: true)) {
        if (file is! File || !file.path.endsWith('.dart')) continue;
        final text = file.readAsLinesSync();
        for (var i = 0; i < text.length; i++) {
          for (final pattern in forbiddenSourcePatterns) {
            if (text[i].contains(pattern)) {
              offenders.add('${file.path}:${i + 1} -> $pattern');
            }
          }
        }
      }
      expect(
        offenders,
        isEmpty,
        reason: 'network-capable code found:\n${offenders.join('\n')}',
      );
    });

    test('url_launcher is used only for official source links', () {
      final launchUsers = <String>[];
      final libDir = Directory('$root${Platform.pathSeparator}lib');
      for (final file in libDir.listSync(recursive: true)) {
        if (file is! File || !file.path.endsWith('.dart')) continue;
        if (file.readAsLinesSync().contains("import 'package:url_launcher/url_launcher.dart';")) {
          launchUsers.add(file.path);
        }
      }
      expect(launchUsers, hasLength(1));
      expect(launchUsers.single, contains('spec_details_screen.dart'));
    });
  });

  group('platform audit', () {
    test('Android manifest requests no INTERNET permission', () {
      final manifest = File(
              '$root${Platform.pathSeparator}android${Platform.pathSeparator}app'
              '${Platform.pathSeparator}src${Platform.pathSeparator}main'
              '${Platform.pathSeparator}AndroidManifest.xml')
          .readAsStringSync();
      expect(manifest.contains('android.permission.INTERNET'), isFalse);
      expect(manifest.contains('android.permission.ACCESS_NETWORK_STATE'), isFalse);
      expect(manifest.contains('android.permission.READ_MEDIA_IMAGES'), isFalse,
          reason: 'gallery uses the system photo picker, not media access');
    });

    test('iOS declares only camera and photo library usage', () {
      final plist = File(
              '$root${Platform.pathSeparator}ios${Platform.pathSeparator}Runner'
              '${Platform.pathSeparator}Info.plist')
          .readAsStringSync();
      expect(plist.contains('NSCameraUsageDescription'), isTrue);
      // ATS exceptions would weaken the privacy posture; none are allowed.
      expect(plist.contains('NSAppTransportSecurity'), isFalse);
      expect(plist.contains('NSLocationWhenInUseUsageDescription'), isFalse);
      expect(plist.contains('NSFaceIDUsageDescription'), isFalse);
    });

    test('privacy documentation exists and states the offline promise', () {
      final policy = File(
              '$root${Platform.pathSeparator}docs${Platform.pathSeparator}product_policy.md')
          .readAsStringSync()
          .toLowerCase();
      expect(policy.contains('zero ads'), isTrue);
      expect(policy.contains('offline'), isTrue);
      expect(policy.contains('never uploaded'), isTrue);
    });
  });
}
