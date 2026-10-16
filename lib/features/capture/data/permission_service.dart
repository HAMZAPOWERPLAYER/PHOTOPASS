import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

/// Camera permission handling, abstracted for tests.
abstract interface class PermissionService {
  Future<bool> isGranted();

  Future<bool> isPermanentlyDenied();

  /// Requests permission; returns true when granted.
  Future<bool> request();

  Future<void> openSettings();
}

/// Device implementation backed by `permission_handler`.
class DevicePermissionService implements PermissionService {
  const DevicePermissionService();

  @override
  Future<bool> isGranted() async => (await Permission.camera.status).isGranted;

  @override
  Future<bool> isPermanentlyDenied() async =>
      (await Permission.camera.status).isPermanentlyDenied;

  @override
  Future<bool> request() async => (await Permission.camera.request()).isGranted;

  @override
  Future<void> openSettings() => openAppSettings();
}

final permissionServiceProvider = Provider<PermissionService>(
  (ref) => const DevicePermissionService(),
);
