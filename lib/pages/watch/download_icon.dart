import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/DioDownDataClass.dart';
import 'package:hanime/common/LikeButton.dart';
import 'package:hanime/common/adapt.dart';
import 'package:m3u8_downloader/m3u8_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadIcon extends StatefulWidget {
  final String videoUrl;

  DownloadIcon({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _DownloadIconState createState() => _DownloadIconState();
}

class _DownloadIconState extends State<DownloadIcon> {
  GlobalKey iconKey = new GlobalKey();

  bool isLiked = false;

  bool isPanel = false;

  String? _downloadingUrl;

  ReceivePort _port = ReceivePort();

  String url1 =
      "https://vkceyugu.cdn.bspapp.com/VKCEYUGU-uni4934e7b/c4d93960-5643-11eb-a16f-5b3e54966275.m3u8";

  @override
  void initState() {
    super.initState();
    initAsync();
  }

  void initAsync() async {
    String saveDir = await _findSavePath();
    M3u8Downloader.initialize(onSelect: () async {
      print('下载成功点击');
      return null;
    });
    M3u8Downloader.config(
        saveDir: saveDir, threadCount: 5, convertMp4: true, debugMode: true);
    // 注册监听器
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      // 监听数据请求
      print(data);
    });
  }

  // @override
  // void dispose() {
  //   // 移除监听订阅
  //   IsolateNameServer.removePortNameMapping('downloader_send_port');
  //   super.dispose();
  // }

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
    String saveDir = directory!.path + '/vPlayDownload';
    Directory root = Directory(saveDir);
    if (!root.existsSync()) {
      await root.create();
    }
    print(saveDir);
    return saveDir;
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

  @override
  Widget build(BuildContext context) {
    return LikeButton(
      key: iconKey,
      likeBuilder: (bool isLiked) {
        return Icon(
          Icons.file_download,
          color: isLiked ? Colors.red : Colors.grey,
          size: Adapt.px(70),
        );
      },
      onTap: (bool isLike) async {
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
                      if (_downloadingUrl == url1) {
                        // 暂停
                        setState(() {
                          _downloadingUrl = null;
                        });
                        M3u8Downloader.pause(url1);
                        return;
                      }
                      // 下载
                      _checkPermission().then((hasGranted) async {
                        if (hasGranted) {
                          // await M3u8Downloader.config(
                          //   convertMp4: false,
                          // );
                          setState(() {
                            _downloadingUrl = url1;
                          });
                          // print(url1);
                          if (url1.indexOf("m3u8") > -1) {
                            M3u8Downloader.download(
                                url: url1,
                                name: "下载未加密m3u8",
                                progressCallback: progressCallback,
                                successCallback: successCallback,
                                errorCallback: errorCallback);
                          } else {
                            downLoadMp4(widget.videoUrl);
                          }
                          // downLoadM3u8(url1);

                        }
                      });
                      setState(() {
                        isLiked = !isLike;
                      });
                      Navigator.pop(context);
                    },
                    child: Text('确定'),
                  ),
                ],
              );
            });
      },
      isLiked: isLiked,
    );
  }

  downLoadMp4(url) {
    print("start");
    bool isStarted = false;
    // var url = "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4";
    var savePath =
        "/storage/emulated/0/Android/data/com.hanime.hanime/files/vPlayDownload/123.mp4";
    // CancelToken cancelToken = CancelToken();
    RangeDownload.downloadWithChunks(url, savePath,
        // isRangeDownload: false, //Support normal download
        // maxChunkdio:
        //            : 32,
        // dio:
        //     Dio(), //Optional parameters "dio".Convenient to customize request settings.
        // cancelToken: widget.cancelToken,
        onReceiveProgress: (received, total) {
      if (!isStarted) {
        // startTime = DateTime.now();
        isStarted = true;
      }
      if (total != -1) {
        print("${(received / total * 100).floor()}%");
        // if (received / total * 100.floor() > 50) {
        // widget.cancelToken.cancel('cancelled');
        // }
      }
      if ((received / total * 100).floor() >= 100) {
        // var duration = (DateTime.now().millisecondsSinceEpoch -
        //         startTime.millisecondsSinceEpoch) /
        //     1000;
        // print(duration.toString() + "s");
        // print(
        //     (duration ~/ 60).toString() + "m" + (duration % 60).toString() + "s");
      }
    });
    // print(res.statusCode);
    // print(res.statusMessage);
    // print(res.data);
  }
}
