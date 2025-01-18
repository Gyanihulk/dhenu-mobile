import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'dart:io';

class AppInfo {
  static final AppInfo _instance = AppInfo._internal();
  late final PackageInfo _packageInfo;
  late final String _deviceUUID;

  AppInfo._internal();

  // Singleton instance
  factory AppInfo() => _instance;

  // Initialize package info and device info
  Future<void> initialize() async {
    // Initialize package info
    _packageInfo = await PackageInfo.fromPlatform();

    // Initialize device info
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      _deviceUUID=androidInfo.id ?? 'Unknown UUID'; // Fetch Android device ID
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      _deviceUUID = iosInfo.identifierForVendor ?? 'Unknown UUID';
    } else {
      _deviceUUID = 'Unsupported Platform';
    }
  }

  // Getters for app information
  String get version => _packageInfo.version; // e.g., "1.0.0"
  String get buildNumber => _packageInfo.buildNumber; // e.g., "1"
  String get appName => _packageInfo.appName; // e.g., "MyApp"
  String get packageName =>
      _packageInfo.packageName; // e.g., "com.example.myapp"

  // Getter for device UUID
  String get deviceUUID => _deviceUUID; // Device UUID
}
