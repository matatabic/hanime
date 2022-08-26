import 'dart:async';
import 'dart:isolate';
import 'dart:ui';

import 'package:bot_toast/bot_toast.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hanime/pages/home/home_screen.dart';
import 'package:hanime/pages/my/my_screen.dart';
import 'package:hanime/pages/search/search_screen.dart';
import 'package:hanime/providers/download_model.dart';
import 'package:hanime/providers/favourite_model.dart';
import 'package:hanime/request/dio_range_download_manage.dart';
import 'package:hanime/request/m3u8_range_download_manage.dart';
import 'package:hanime/utils/utils.dart';
import 'package:m3u8_downloader/m3u8_downloader.dart';
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
  dynamic _lastTime;
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
            _doQuit();
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
    print("registerPortWithName");
    _port.listen((dynamic data) {
      // 监听数据请求
      print("listen");
      print(data);
      switch (data['status']) {
        case 1: //下载中
          Provider.of<DownloadModel>(context, listen: false)
              .changeDownloadProgress(
                  data['url'], Utils.doubleRemoveDecimal(data['progress'], 3));
          break;
        case 2: //下载完成
          Provider.of<DownloadModel>(context, listen: false)
              .downloadSuccess(data['url'], localVideoUrl: data['filePath']);
          break;
        case 3: //下载错误
          Provider.of<DownloadModel>(context, listen: false)
              .errorDownload(data['url']);
          break;
      }
    });

    Timer.periodic(Duration(milliseconds: 5000), (_) {
      List<DownloadEntity> downloadList =
          Provider.of<DownloadModel>(context, listen: false).downloadList;
      List<DownloadEntity> downloadingList =
          downloadList.where((element) => element.downloading).toList();
      if (downloadingList.length < 3) {
        for (DownloadEntity item in downloadList) {
          if (item.waitDownload) {
            print("开始下载");
            _download(item);
          }
        }
      }
    });
  }

  onErrorCallback(error, stackTrace) {
    Provider.of<DownloadModel>(context, listen: false)
        .errorDownload(error.message);
    return Response(
      requestOptions: RequestOptions(path: ''),
    );
  }

  void _download(DownloadEntity downloadEntity) async {
    String baseUrl = await Utils.findBasePath(downloadEntity.htmlUrl);

    if (downloadEntity.videoUrl.indexOf("m3u8") > -1) {
      M3u8RangeDownloadManage.downloadWithChunks(downloadEntity, baseUrl);
    } else {
      await DioRangeDownloadManage.downloadWithChunks(
        url: downloadEntity.videoUrl,
        savePath: "$baseUrl/${Utils.getVideoId(downloadEntity.htmlUrl)}.mp4",
        onReceiveProgress: (received, total) {
          if (total != -1) {
            Provider.of<DownloadModel>(context, listen: false)
                .changeDownloadProgress(downloadEntity.videoUrl,
                    Utils.doubleRemoveDecimal(received / total, 3));

            print("下载1已接收：" +
                received.toString() +
                "总共：" +
                total.toString() +
                "进度：+${(received / total * 100).floor()}%");
          }
        },
        done: () {
          Provider.of<DownloadModel>(context, listen: false)
              .downloadSuccess(downloadEntity.videoUrl);

          print("下载1完成");
        },
        failed: (String error) {
          print("下载1失败");
          print(error);
          if (error.contains("410")) {
            Provider.of<DownloadModel>(context, listen: false)
                .downloadSuccess(downloadEntity.videoUrl);
          }
          Provider.of<DownloadModel>(context, listen: false)
              .errorDownload(downloadEntity.videoUrl);
        },
      );
    }
    Provider.of<DownloadModel>(context, listen: false)
        .changeDownloadState(downloadEntity);
  }

  void _doQuit() async {
    // 两秒内没有再点过退出按钮
    if (_lastTime == null ||
        DateTime.now().difference(_lastTime) > Duration(seconds: 2)) {
      // 重置最后一次点击的时间
      _lastTime = DateTime.now();
      BotToast.showCustomNotification(
          duration: const Duration(seconds: 2),
          align: Alignment(0, -1.2),
          toastBuilder: (_) {
            return Container(
              alignment: Alignment.bottomLeft,
              width: Adapt.screenW(),
              height: Adapt.px(300),
              color: Colors.redAccent,
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Row(
                  children: [
                    Icon(Icons.west),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        "再按一次返回键退出应用",
                        style: TextStyle(fontSize: Adapt.px(32)),
                      ),
                    )
                  ],
                ),
              ),
            );
          });
    }
    // 两秒内点了两次退出按钮，则退出 APP
    else {
      await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    }
  }
}
