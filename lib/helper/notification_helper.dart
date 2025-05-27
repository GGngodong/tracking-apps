import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

Future<void> _requestNotificationPermissionIfNeeded() async {
  if (!Platform.isAndroid) return;

  final info = await DeviceInfoPlugin().androidInfo;
  final sdkInt = info.version.sdkInt!;
  if (sdkInt >= 33) {
    // Android 13+
    final status = await Permission.notification.status;
    if (!status.isGranted) {
      final result = await Permission.notification.request();
      if (!result.isGranted) {
        debugPrint("User denied POST_NOTIFICATIONS permission.");
      }
    }
  }
}
