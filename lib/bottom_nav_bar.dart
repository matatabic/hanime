import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/pages/home/home_screen.dart';
import 'package:hanime/pages/my/my_screen.dart';
import 'package:hanime/pages/search/search_screen.dart';
import 'package:hanime/providers/download_model.dart';
import 'package:hanime/providers/favourite_model.dart';
import 'package:hanime/utils/dio_range_download_manage.dart';
import 'package:hanime/utils/m3u8_range_download_manage.dart';
import 'package:m3u8_downloader/m3u8_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/src/provider.dart';

import 'common/adapt.dart';
import 'entity/download_entity.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  int currentIndex = 0;

  ReceivePort _port = ReceivePort();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCache();
    initM3u8Downloader();
    tabController = TabController(vsync: this, length: 3)
      ..addListener(() {
        setState(() {
          currentIndex = tabController.index;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          // backgroundColor: colors[currentIndex],
          color: Theme.of(context).primaryColor,
          buttonBackgroundColor: Colors.transparent,
          backgroundColor: Colors.black26,
          index: currentIndex,
          items: <Widget>[
            Icon(Icons.home, size: Adapt.px(60)),
            Icon(Icons.cloud_circle, size: Adapt.px(60)),
            Icon(Icons.collections, size: Adapt.px(60)),
          ],
          onTap: (index) {
            //Handle button tap
            setState(() {
              currentIndex = index;
            });
            tabController.animateTo(index,
                duration: Duration(milliseconds: 300), curve: Curves.ease);
          },
        ),
        body: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: tabController,
            children: <Widget>[
              HomeScreen(),
              SearchScreen(),
              MyScreen(),
            ],
          ),
        ));
  }

  void loadCache() async {
    context.read<FavouriteModel>().getCache();
    context.read<DownloadModel>().getCache();
  }

  void initM3u8Downloader() async {
    M3u8Downloader.initialize(onSelect: () async {
      print('下载成功点击');
      return null;
    });

    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      // 监听数据请求
      print(data);
    });

    Timer.periodic(Duration(milliseconds: 10000), (_) {
      List<DownloadEntity> downloadList =
          Provider.of<DownloadModel>(context, listen: false).downloadList;

      for (DownloadEntity item in downloadList) {
        if (item.waitDownload) {
          print("开始下载");
          _download(item);
        }
      }
    });
    // double temp = 0;
    // Timer.periodic(Duration(milliseconds: 1000), (_) {
    //   if (temp >= 1) {
    //     return;
    //   }
    //   Provider.of<DownloadModel>(context, listen: false)
    //       .changeDownloadProgress(38462, temp);
    //   temp = temp + 0.01;
    // });
  }

  onErrorCallback(error, stackTrace) {
    Provider.of<DownloadModel>(context, listen: false)
        .errorDownload(error.message);
    return Response(
      requestOptions: RequestOptions(path: ''),
    );
  }

  Future<String> _findBasePath(int id) async {
    final directory = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();

    String baseDir = directory!.path + '/video/';

    Directory root = Directory(baseDir);
    if (!root.existsSync()) {
      await root.create();
    }
    baseDir = baseDir + id.toString();

    root = Directory(baseDir);
    if (!root.existsSync()) {
      await root.create();
    }

    return baseDir;
  }

  void _download(DownloadEntity downloadEntity) async {
    String baseUrl = await _findBasePath(downloadEntity.id);

    if (downloadEntity.videoUrl.indexOf("m3u8") > -1) {
      M3u8RangeDownloadManage.downloadWithChunks(downloadEntity, baseUrl,
          onProgressCallback: onProgressCallback);
    } else {
      await DioRangeDownloadManage.downloadWithChunks(
        url: downloadEntity.videoUrl,
        savePath: "$baseUrl/${downloadEntity.id}.mp4",
        onReceiveProgress: (received, total) {
          if (total != -1) {
            String tempProgress = (received / total).toStringAsFixed(3);
            double progress = double.parse(tempProgress);

            Provider.of<DownloadModel>(context, listen: false)
                .changeDownloadProgress(downloadEntity.id, progress);

            print("下载1已接收：" +
                received.toString() +
                "总共：" +
                total.toString() +
                "进度：+${(received / total * 100).floor()}%");
          }
        },
        done: () {
          Provider.of<DownloadModel>(context, listen: false)
              .downloadSuccess(downloadEntity.id);
          print("下载1完成");
        },
        failed: (String uri) {},
      );
    }
    Provider.of<DownloadModel>(context, listen: false)
        .changeDownloadState(downloadEntity);
  }

  onProgressCallback(dynamic args) {
    print('progressCallback');
    print(args['progress']);
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    if (send != null) {
      args["status"] = 1;
      send.send(args);
    }
  }

  onReceiveProgress(received, total) {
    if (total != -1) {
      print("${(received / total * 100).floor()}%");
      // if (received / total * 100.floor() > 50) {
      //   cancelToken.cancel();
      // }
    }
  }
}
