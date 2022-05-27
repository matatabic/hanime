import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/entity/watch_entity.dart';
import 'package:hanime/providers/download_state.dart';
import 'package:hanime/utils/index.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/src/provider.dart';

class DownloadIcon extends StatefulWidget {
  final WatchInfo info;
  final String videoUrl;

  DownloadIcon({Key? key, required this.info, required this.videoUrl})
      : super(key: key);

  @override
  _DownloadIconState createState() => _DownloadIconState();
}

class _DownloadIconState extends State<DownloadIcon> {
  String? _downloadingUrl;

  String? saveDir;

  double currentProgress = 0.0;

  String url1 =
      "https://vkceyugu.cdn.bspapp.com/VKCEYUGU-uni4934e7b/c4d93960-5643-11eb-a16f-5b3e54966275.m3u8";
  String testUrl =
      "https://abre-videos.cdn1122.com/_hls/videos/e/4/0/3/d/e403d71acf21b29fc87837be40b1c0c31616499361-1920-1080-1992-h264.mp4/master.m3u8?validfrom=1652760178&validto=1652932978&rate=382464&hdl=-1&hash=EJi8kx8ieaF4Md2TW8Zs18sLYKc%3D";

  @override
  void initState() {
    super.initState();
  }

  Future<bool> _checkPermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();
    }
    return status.isGranted;
  }

  Future<String> _findSavePath() async {
    final directory = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();

    String baseDir = directory!.path + '/vPlayDownload/';

    Directory root = Directory(baseDir);
    if (!root.existsSync()) {
      await root.create();
    }
    baseDir = baseDir + getVideoId(widget.info.htmlUrl);

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

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () async {
          showCupertinoDialog(
              context: context,
              builder: (context) {
                return CupertinoAlertDialog(
                  title: Text("是否下载该影片?"),
                  actions: <Widget>[
                    CupertinoDialogAction(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('取消'),
                    ),
                    CupertinoDialogAction(
                      onPressed: () {
                        // if (_downloadingUrl == widget.videoUrl) {
                        //   // 暂停
                        //   setState(() {
                        //     _downloadingUrl = null;
                        //   });
                        //   // M3u8Downloader.pause(url1);
                        //   return;
                        // }
                        // 下载
                        _checkPermission().then((hasGranted) async {
                          if (hasGranted) {
                            String saveDir = await _findSavePath();
                            context.read<DownloadState>().addQueue(
                                widget.info, saveDir, widget.videoUrl);

                            // await M3u8Downloader.config(
                            //     saveDir: saveDir,
                            //     convertMp4: true,
                            //     threadCount: 5,
                            //     debugMode: true);
                            //
                            // if (widget.videoUrl.indexOf("m3u8") > -1) {
                            //   String m3u8Url =
                            //       await getM3u8Url(widget.videoUrl);
                            //   M3u8Downloader.download(
                            //       url: m3u8Url,
                            //       name: widget.id,
                            //       progressCallback: progressCallback,
                            //       successCallback: successCallback,
                            //       errorCallback: errorCallback);
                            // } else {
                            //   downLoadMp4(saveDir, widget.videoUrl);
                            // }
                          }
                        });

                        Navigator.pop(context);
                      },
                      child: Text('确定'),
                    ),
                  ],
                );
              });
        },
        child: Container(
            width: Adapt.px(60),
            height: Adapt.px(60),
            alignment: Alignment.center,
            child: SizedBox(
                width: Adapt.px(60),
                height: Adapt.px(60),
                child: Icon(Icons.downloading,
                    size: Adapt.px(60), color: Colors.grey))));
  }

  // downLoadMp4(saveDir, url) async {
  //   print("start");
  //
  //   ///创建DIO
  //   Dio dio = new Dio();
  //   var savePath = '$saveDir/${widget.id}.mp4';
  //   print(savePath);
  //
  //   ///参数一 文件的网络储存URL
  //   ///参数二 下载的本地目录文件
  //   ///参数三 下载监听
  //   Response response =
  //       await dio.download(url, savePath, onReceiveProgress: (received, total) {
  //     if (total != -1) {
  //       ///当前下载的百分比例
  //       print((received / total * 100).toStringAsFixed(1) + "%");
  //       // CircularProgressIndicator(value: currentProgress,) 进度 0-1
  //       currentProgress = received / total;
  //     }
  //   });
  // }
}
