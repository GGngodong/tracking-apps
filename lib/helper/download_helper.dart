
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
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


    final extDirs = await getExternalStorageDirectories(
      type: StorageDirectory.downloads,
    );
    if (extDirs == null || extDirs.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Cannot locate external storage root.")),
      );
      return null;
    }

    final downloadsDir = extDirs.first;
    final rootDir = downloadsDir.parent;


    final permitsDir = Directory('${rootDir.path}/Permits');

    if (!await permitsDir.exists()) {
      try {
        await permitsDir.create(recursive: true);
      } catch (e) {
        debugPrint('Failed to create Permits directory: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Unable to create Permits folder on device.")),
        );
        return null;
      }
    }

    final savePath = permitsDir.path;

    try {
      final taskId = await FlutterDownloader.enqueue(
        url: url,
        savedDir: savePath,
        fileName: savedFileName,
        showNotification: true,
        openFileFromNotification: true,
      );

      debugPrint('Download enqueued (taskId: $taskId)');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Saved to: $savePath/$savedFileName")),
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
