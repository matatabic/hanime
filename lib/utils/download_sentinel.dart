import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:m3u8_downloader/m3u8_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'index.dart';

class DownloadSentinel {
  Future<void> _download(id, videoUrl) async {
    _checkPermission().then((hasGranted) async {
      if (hasGranted) {
        String saveDir = await _findSavePath(id);
        await M3u8Downloader.config(
            saveDir: saveDir,
            convertMp4: true,
            threadCount: 5,
            debugMode: true);

        if (videoUrl.indexOf("m3u8") > -1) {
          String m3u8Url = await getM3u8Url(videoUrl);
          M3u8Downloader.download(
              url: m3u8Url,
              name: id,
              progressCallback: progressCallback,
              successCallback: successCallback,
              errorCallback: errorCallback);
        } else {
          downLoadMp4(id, saveDir, videoUrl);
        }
      }
    });
  }

  Future<bool> _checkPermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();
    }
    return status.isGranted;
  }

  Future<String> _findSavePath(id) async {
    final directory = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();

    String baseDir = directory!.path + '/vPlayDownload/';

    Directory root = Directory(baseDir);
    if (!root.existsSync()) {
      await root.create();
    }
    baseDir = baseDir + id;

    root = Directory(baseDir);
    if (!root.existsSync()) {
      await root.create();
    }

    return baseDir;
  }

  static progressCallback(dynamic args) {
    print('progressCallback');
    print(args['progress']);
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

  downLoadMp4(id, saveDir, url) async {
    print("start");

    ///创建DIO
    Dio dio = new Dio();
    var savePath = '$saveDir/$id.mp4';
    print(savePath);

    ///参数一 文件的网络储存URL
    ///参数二 下载的本地目录文件
    ///参数三 下载监听
    Response response =
        await dio.download(url, savePath, onReceiveProgress: (received, total) {
      if (total != -1) {
        ///当前下载的百分比例
        print((received / total * 100).toStringAsFixed(1) + "%");
        // CircularProgressIndicator(value: currentProgress,) 进度 0-1
        // currentProgress = received / total;
        // Provider.of<DownloadState>(context, listen: false)
        //     .setTest(currentProgress.toString());
        // setState(() {});
      }
    });
  }
}
