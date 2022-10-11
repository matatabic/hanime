import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'download/download_screen.dart';
import 'favourite/favourite_screen.dart';

class MyScreen extends StatefulWidget {
  const MyScreen({Key? key}) : super(key: key);

  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print("收藏下载收藏下载收藏下载收藏下载收藏下载");
    return SafeArea(
      child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Colors.red,
                indicatorWeight: 3,
                tabs: [
                  Tab(text: "收藏"),
                  Tab(text: "下载"),
                ]),
            body: TabBarView(children: [FavouriteScreen(), DownloadScreen()]),
          )),
    );
  }
}
