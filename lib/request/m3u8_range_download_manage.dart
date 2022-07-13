import 'dart:isolate';
import 'dart:ui';

import 'package:hanime/entity/download_entity.dart';
import 'package:m3u8_downloader/m3u8_downloader.dart';

class M3u8RangeDownloadManage {
  static Future<void> downloadWithChunks(
      DownloadEntity downloadEntity, String savePath) async {
    await M3u8Downloader.config(
        saveDir: savePath, convertMp4: true, threadCount: 5, debugMode: true);
    // String m3u8Url = await getM3u8Url(downloadEntity.videoUrl);
    M3u8Downloader.download(
        url: downloadEntity.videoUrl,
        name: downloadEntity.title,
        progressCallback: progressCallback,
        successCallback: successCallback,
        errorCallback: errorCallback);
  }

  static progressCallback(dynamic args) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    if (send != null) {
      args["status"] = 1;
      send.send(args);
    }
  }

  static successCallback(dynamic args) {
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

  static errorCallback(dynamic args) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    if (send != null) {
      send.send({"status": 3, "url": args["url"]});
    }
  }
}
