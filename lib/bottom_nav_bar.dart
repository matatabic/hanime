import 'dart:async';
import 'dart:isolate';
import 'dart:ui';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/pages/home/home_screen.dart';
import 'package:hanime/pages/my/my_screen.dart';
import 'package:hanime/pages/search/search_screen.dart';
import 'package:hanime/providers/download_state.dart';
import 'package:hanime/providers/favourite_state.dart';
import 'package:m3u8_downloader/m3u8_downloader.dart';
import 'package:provider/src/provider.dart';

import 'common/adapt.dart';

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
    context.read<FavouriteState>().getCache();
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

    Timer.periodic(Duration(milliseconds: 5000), (_) {
      // print('业务逻辑');
      print(Provider.of<DownloadState>(context, listen: false)
          .downloadList
          .length);
    });
  }
}
