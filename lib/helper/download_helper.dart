// lib/helpers/download_helper.dart

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

class DownloadHelper {
  DownloadHelper._(); // Prevent instantiation

  /// Checks/request storage permission on Android.
  static Future<bool> _ensureStoragePermission() async {
    if (!Platform.isAndroid) return true;

    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;
    final sdkInt = androidInfo.version.sdkInt!;

    if (sdkInt >= 30) {
      // Android 11+ → MANAGE_EXTERNAL_STORAGE
      var manageStatus = await Permission.manageExternalStorage.status;
      if (manageStatus.isGranted) return true;

      manageStatus = await Permission.manageExternalStorage.request();
      return manageStatus.isGranted;
    } else {
      // Android 10 (API 29) and below → READ/WRITE_EXTERNAL_STORAGE
      var storageStatus = await Permission.storage.status;
      if (storageStatus.isGranted) return true;

      storageStatus = await Permission.storage.request();
      return storageStatus.isGranted;
    }
  }

  /// Downloads [url] onto a custom folder `/storage/emulated/0/Permits/`
  /// with filename [savedFileName]. Shows SnackBars on errors.
  /// Returns the FlutterDownloader taskId if successful, else null.
  static Future<String?> downloadFile({
    required String url,
    required String savedFileName,
    required BuildContext context,
  }) async {
    // 0) Check URL isn’t empty
    if (url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Download URL is empty.")),
      );
      return null;
    }

    // 1) Ensure proper storage permission
    final hasPermission = await _ensureStoragePermission();
    if (!hasPermission) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Storage permission denied.")),
      );
      return null;
    }

    // 2) Find the “root” of external storage.
    //
    //    We use getExternalStorageDirectories(type: downloads) to get a path
    //    like "/storage/emulated/0/Download". Its parent is "/storage/emulated/0".
    final extDirs = await getExternalStorageDirectories(
      type: StorageDirectory.downloads,
    );
    if (extDirs == null || extDirs.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Cannot locate external storage root.")),
      );
      return null;
    }

    final downloadsDir = extDirs.first;
    // e.g. downloadsDir.path == "/storage/emulated/0/Download"
    final rootDir = downloadsDir.parent;
    // e.g. rootDir.path == "/storage/emulated/0"

    // 3) Build the custom “Permits” folder under the root.
    final permitsDir = Directory('${rootDir.path}/Permits');

    // If it doesn't exist, create it (recursively).
    if (!await permitsDir.exists()) {
      try {
        await permitsDir.create(recursive: true);
      } catch (e) {
        debugPrint('Failed to create Permits directory: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content:
              Text("Unable to create Permits folder on device.")),
        );
        return null;
      }
    }

    final savePath = permitsDir.path;
    // Example: "/storage/emulated/0/Permits"

    // 4) Enqueue the download to that folder.
    try {
      final taskId = await FlutterDownloader.enqueue(
        url: url,
        savedDir: savePath,
        fileName: savedFileName,
        showNotification: true, // show progress in notification bar
        openFileFromNotification: true, // tap notification to open file
      );

      debugPrint('Download enqueued (taskId: $taskId)');
      // Inform the user where it went:
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
            Text("Saved to: $savePath/$savedFileName")),
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
