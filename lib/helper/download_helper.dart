import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadHelper {
  DownloadHelper._();

  static Future<bool> _ensureStoragePermission() async {
    if (!Platform.isAndroid) return true;

    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;
    final sdkInt = androidInfo.version.sdkInt!;

    if (sdkInt >= 30) {
      var manageStatus = await Permission.manageExternalStorage.status;
      if (manageStatus.isGranted) return true;

      manageStatus = await Permission.manageExternalStorage.request();
      return manageStatus.isGranted;
    } else {
      var storageStatus = await Permission.storage.status;
      if (storageStatus.isGranted) return true;

      storageStatus = await Permission.storage.request();
      return storageStatus.isGranted;
    }
  }

  static Future<String?> downloadFile({
    required String url,
    required String savedFileName,
    required BuildContext context,
  }) async {
    if (url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Download URL is empty.")),
      );
      return null;
    }

    final hasPermission = await _ensureStoragePermission();
    if (!hasPermission) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Storage permission denied.")),
      );
      return null;
    }

    // ✅ Public folder path (outside Android/data)
    final publicDir = Directory('/storage/emulated/0/Permits');
    try {
      if (!await publicDir.exists()) {
        await publicDir.create(recursive: true);
      }
    } catch (e) {
      debugPrint("Failed to create public folder: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to create folder: $e")),
      );
      return null;
    }

    try {
      final taskId = await FlutterDownloader.enqueue(
        url: url,
        savedDir: publicDir.path,
        fileName: savedFileName,
        showNotification: true,
        openFileFromNotification: true,
      );

      debugPrint('Download enqueued to: ${publicDir.path}/$savedFileName');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Saved to: ${publicDir.path}/$savedFileName")),
      );
      return taskId;
    } catch (e) {
      debugPrint('Download failed: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Download failed: $e")),
      );
      return null;
    }
  }
}
