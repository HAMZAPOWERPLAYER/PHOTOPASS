# Privacy & Offline Audit — PhotoPass

**Date:** 2026-10-15 (re-verified for release)
**Scope:** dependency graph, Dart source, Android manifest, iOS Info.plist, docs.

## Verdict

PhotoPass is **offline-first and privacy-preserving**. All image processing
(face detection, cropping, background replacement, compliance checks, print
sheets, PDFs) runs on-device. The app performs **no network I/O of its own**;
the only network action possible is the user tapping an official government
source link, which opens in the system browser via `url_launcher`.

## 1. Dependency audit

Enforced by `test/privacy_audit_test.dart` ("dependency audit" group).

| Category | Status |
| --- | --- |
| Ads (`google_mobile_ads`, AdMob, Unity/AppLovin) | ✅ absent |
| Billing / IAP / paywalls (`in_app_purchase`, Stripe, RevenueCat) | ✅ absent |
| Analytics / crash / attribution (Firebase, Sentry, Amplitude, Mixpanel, AppsFlyer, Adjust, Facebook) | ✅ absent |
| HTTP clients (`http`, `dio`, `grpc`, sockets) | ✅ absent |
| Device fingerprinting (`device_info_plus`, `package_info_plus`) | ✅ absent |
| Connectivity (`connectivity_plus`) | ✅ absent |

Full dependency list: `flutter_riverpod`, `go_router`, `intl`,
`flutter_localizations`, `url_launcher`, `camera`, `image_picker`,
`permission_handler`, `google_mlkit_face_detection`, `image`, `path_provider`,
`pdf`, `share_plus`, `gal`. Every package is a UI/platform utility; none opens
a socket on the app's behalf.

## 2. Source audit

Enforced by the "source audit" group. The test scans every `lib/**/*.dart`
file for outbound code paths:

- `package:http/`, `package:dio/` — absent
- `dart:io` `HttpClient(` — absent (only `File`/`Directory`/`Platform` imports)
- `WebSocket.connect` — absent
- `Process.run` — absent (no shell execution)
- `DynamicLibrary.open` — absent (no FFI network tricks)
- `url_launcher` imports — exactly one file, `spec_details_screen.dart`,
  which only opens the spec's `sourceUrl` with `LaunchMode.externalApplication`

Photos, history, and temp files live in app-private storage
(`path_provider` application documents / temporary directories). Nothing is
written to shared/public storage unless the user explicitly taps
"Save to gallery" (`gal`) or "Share" (`share_plus`), both of which are
user-initiated hand-offs to OS components.

## 3. Platform permissions

Enforced by the "platform audit" group.

### Android (`AndroidManifest.xml`)

- `CAMERA` — required for capture.
- **No** `INTERNET`, `ACCESS_NETWORK_STATE`, or `READ_MEDIA_IMAGES`.
  Gallery import uses the system photo picker (no storage permission needed).
- Note: without `INTERNET`, the `url_launcher` external browser hand-off still
  works — the browser app holds the permission, not PhotoPass.

### iOS (`Info.plist`)

- `NSCameraUsageDescription`, `NSPhotoLibraryUsageDescription` only.
- No `NSAppTransportSecurity` exceptions, no location, no Face ID, no
  Contacts, no Motion/Usage descriptions.

## 4. Data inventory

| Data | Location | Leaves device? |
| --- | --- | --- |
| Camera frames | Processed in memory → app temp dir | No |
| Imported gallery photo | Copied into app-private storage | No |
| Working crops / retouch intermediates | App temp dir, cleared on reset | No |
| Final photos & history metadata | App documents (JSON file repo) | Only if the user taps save/share |
| Specs database | Bundled asset, read-only | No |
| Settings (language) | SharedPreferences-free: in-memory / local config | No |

No identifiers, no advertising IDs, no telemetry, no account, no backend.

## 5. Free-forever guarantee

Enforced by `test/privacy_audit_test.dart` (no billing packages) and
`docs/product_policy.md`. There is no code path that can gate a feature:
grep for `paywall`, `premium`, `pro_`, `subscription`, `upgrade` in `lib/`
returns no functional matches.

## 6. Regression policy

- The privacy audit test runs with the normal `flutter test` suite; any PR
  adding a forbidden dependency, a network code path, or a new permission
  fails CI.
- New permissions must be justified in this document and in the Play Store
  data-safety form before being added.
