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
    bool res = context
        .read<DownloadState>()
        .downloadList
        .any((element) => element.htmlUrl == widget.info.htmlUrl);
    print(res);
    final widgetContext = context;
    return Container(
        width: Adapt.px(60),
        height: Adapt.px(60),
        alignment: Alignment.center,
        child: SizedBox(
            width: Adapt.px(60),
            height: Adapt.px(60),
            child: res
                ? Container(
                    child: Icon(Icons.downloading,
                        size: Adapt.px(60), color: Colors.red))
                : InkWell(
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
                                    _checkPermission().then((hasGranted) async {
                                      if (hasGranted) {
                                        String saveDir = await _findSavePath();
                                        widgetContext
                                            .read<DownloadState>()
                                            .addQueue(widget.info, saveDir,
                                                widget.videoUrl);
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
                    child: Icon(Icons.downloading,
                        size: Adapt.px(60), color: Colors.grey),
                  )));
  }
}
