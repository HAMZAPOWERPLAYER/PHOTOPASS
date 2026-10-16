import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:photo_pass/app/flow/selected_spec_provider.dart';
import 'package:photo_pass/features/capture/data/camera_service.dart';
import 'package:photo_pass/features/capture/data/permission_service.dart';
import 'package:photo_pass/features/capture/presentation/capture_screen.dart';
import 'package:photo_pass/features/country_select/domain/photo_spec.dart';
import 'package:photo_pass/l10n/generated/app_localizations.dart';

class _FakePermissionService implements PermissionService {
  _FakePermissionService({this.granted = false, this.permanent = false});

  final bool granted;
  final bool permanent;
  bool openSettingsCalled = false;

  @override
  Future<bool> isGranted() async => granted;

  @override
  Future<bool> isPermanentlyDenied() async => permanent;

  @override
  Future<bool> request() async => granted;

  @override
  Future<void> openSettings() async {
    openSettingsCalled = true;
  }
}

class _FakeCameraService implements CameraService {
  @override
  Future<List<CameraDescription>> availableCameras() async =>
      throw CameraException('unavailable', 'no camera in tests');

  @override
  CameraController createController(CameraDescription description) =>
      throw UnimplementedError();
}

PhotoSpec _testSpec() => const PhotoSpec(
  id: 'us_passport',
  countryCode: 'US',
  documentType: DocumentType.passport,
  displayNameKey: 'spec_us_passport',
  widthMm: 51,
  heightMm: 51,
  dpi: 300,
  backgroundHex: '#FFFFFF',
  fileFormats: ['jpg'],
  glassesAllowed: false,
  sourceUrl: 'https://travel.state.gov',
  lastVerified: '2026-10-15',
  verified: true,
);

Future<void> _pumpCapture(
  WidgetTester tester, {
  required PermissionService permission,
}) async {
  tester.view.physicalSize = const Size(400, 800);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        permissionServiceProvider.overrideWith((ref) => permission),
        cameraServiceProvider.overrideWith((ref) => _FakeCameraService()),
        selectedSpecProvider.overrideWith(_FakeSpecController.new),
      ],
      child: const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: CaptureScreen(),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

class _FakeSpecController extends SelectedSpecController {
  @override
  PhotoSpec build() => _testSpec();
}

void main() {
  testWidgets('shows rationale when permission is denied', (tester) async {
    await _pumpCapture(
      tester,
      permission: _FakePermissionService(granted: false),
    );

    expect(find.text('Camera access needed'), findsOneWidget);
    expect(find.text('Allow camera'), findsOneWidget);
  });

  testWidgets('rationale action requests permission', (tester) async {
    final permission = _FakePermissionService(granted: false);
    await _pumpCapture(tester, permission: permission);

    await tester.tap(find.text('Allow camera'));
    await tester.pumpAndSettle();

    // Still denied → rationale remains visible.
    expect(find.text('Camera access needed'), findsOneWidget);
  });

  testWidgets('permanently denied shows open settings', (tester) async {
    await _pumpCapture(
      tester,
      permission: _FakePermissionService(granted: false, permanent: true),
    );

    expect(find.text('Open settings'), findsOneWidget);
  });

  testWidgets('camera failure shows recoverable error with retry',
      (tester) async {
    await _pumpCapture(
      tester,
      permission: _FakePermissionService(granted: true),
    );

    expect(find.text('Try again'), findsOneWidget);
    expect(find.byIcon(Icons.no_photography_outlined), findsOneWidget);
  });

  testWidgets('gallery remains available on the rationale screen',
      (tester) async {
    // The policy requires core flows stay usable; rationale screen shows
    // the denied message pointing users to the gallery path.
    await _pumpCapture(
      tester,
      permission: _FakePermissionService(granted: false, permanent: true),
    );

    expect(find.textContaining('gallery'), findsWidgets);
  });
}
