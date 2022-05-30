import 'dart:isolate';
import 'dart:ui';

import 'package:hanime/entity/download_entity.dart';
import 'package:m3u8_downloader/m3u8_downloader.dart';
import 'package:permission_handler/permission_handler.dart';

import 'index.dart';

class M3u8RangeDownload {
  static Future<void> downloadWithChunks(DownloadEntity downloadEntity,
      {Function? onProgressCallback,
      Function? onSuccessCallback,
      Function? onErrorCallback}) async {
    await M3u8Downloader.config(
        saveDir: downloadEntity.baseDir,
        convertMp4: true,
        threadCount: 5,
        debugMode: true);
    String m3u8Url = await getM3u8Url(downloadEntity.videoUrl);
    M3u8Downloader.download(
        url: m3u8Url,
        name: downloadEntity.title,
        progressCallback: onProgressCallback,
        successCallback: onSuccessCallback,
        errorCallback: onErrorCallback);
  }

  Future<bool> _checkPermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();
    }
    return status.isGranted;
  }

  void _progressCallback(dynamic args) {
    print('progressCallback');
    print(args['progress']);
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    if (send != null) {
      args["status"] = 1;
      send.send(args);
    }
  }

  void _successCallback(dynamic args) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    if (send != null) {
      send.send({
        "status": 2,
        "url": args["url"],
        "filePath": args["filePath"],
        "dir": args["dir"]
      });
    }
  }

  void _errorCallback(dynamic args) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    if (send != null) {
      send.send({"status": 3, "url": args["url"]});
    }
  }
}
