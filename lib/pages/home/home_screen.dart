import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/entity/home_entity.dart';
import 'package:hanime/pages/home/home_header_screen.dart';
import 'package:hanime/pages/home/widght/fire_widget.dart';
import 'package:hanime/pages/home/widght/hot_widget.dart';
import 'package:hanime/pages/home/widght/latest_widget.dart';
import 'package:hanime/pages/home/widght/tag_widget.dart';
import 'package:hanime/pages/home/widght/top_widget.dart';
import 'package:hanime/pages/home/widght/watch_widget.dart';
import 'package:hanime/services/home_services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  var _futureBuilderFuture;
  late AnimationController _colorAnimationController;
  late Animation _colorTween;

  Interval opacityCurve = Interval(0.0, 1, curve: Curves.fastOutSlowIn);
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  InAppWebViewController? webViewController;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        builder: _buildFuture,
        future:
            _futureBuilderFuture, // 用户定义的需要异步执行的代码，类型为Future<String>或者null的变量或函数
      ),
    );
  }

  Widget _buildFuture(BuildContext context, AsyncSnapshot snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
        print('还没有开始网络请求');
        return Text('还没有开始网络请求');
      case ConnectionState.active:
        print('active');
        return Text('ConnectionState.active');
      case ConnectionState.waiting:
        print('waiting');
        return Center(
          child: CircularProgressIndicator(),
        );
      case ConnectionState.done:
        print('done');
        print(snapshot.error);
        if (snapshot.hasError) {
          return InAppWebView(
            initialUrlRequest:
                URLRequest(url: Uri.parse("https://hanime1.me/")),
            onLoadStop: (controller, url) async {
              // pullToRefreshController.endRefreshing();
              // setState(() {
              //   this.url = url.toString();
              //   urlController.text = this.url;
              // });
              print("onLoadStoponLoadStoponLoadStoponLoadStop");
            },
          );

          return Center(
              child: MaterialButton(
            color: Colors.blue,
            textColor: Colors.white,
            child: Text('网络异常,点击重新加载'),
            onPressed: () {
              setState(() {
                _futureBuilderFuture = loadData();
              });
            },
          ));
          // return Text('Error: ${snapshot.error}');
        } else {
          return _createWidget(context, snapshot);
        }
    }
  }

  Widget _createWidget(BuildContext context, AsyncSnapshot snapshot) {
    print("_createWidget");
    HomeEntity homeEntity = snapshot.data;

    return NotificationListener<ScrollNotification>(
        onNotification: _scrollListener,
        child: Stack(children: [
          SmartRefresher(
            enablePullDown: true,
            header: WaterDropMaterialHeader(),
            controller: _refreshController,
            onRefresh: _onRefresh,
            child: CustomScrollView(semanticChildCount: 2, slivers: <Widget>[
              SliverToBoxAdapter(
                  child: HomeHeaderScreen(swiperList: homeEntity.swiper)),
              // 当列表项高度固定时，使用 SliverFixedExtendList 比 SliverList 具有更高的性能
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                switch (index) {
                  case 0:
                    return TopWidget(
                        data: homeEntity.top, opacityCurve: opacityCurve);
                  case 1:
                    return LatestWidget(
                        data: homeEntity.latest, opacityCurve: opacityCurve);
                  case 2:
                    return FireWidget(
                        data: homeEntity.fire, opacityCurve: opacityCurve);
                  case 3:
                    return TagWidget(
                        data: homeEntity.tag, opacityCurve: opacityCurve);
                  case 4:
                    return HotWidget(
                        data: homeEntity.hot, opacityCurve: opacityCurve);
                  case 5:
                    return WatchWidget(
                        data: homeEntity.watch, opacityCurve: opacityCurve);
                }
              }, childCount: 6)),
            ]),
          ),
          Container(
            height: MediaQuery.of(context).padding.top,
            child: AnimatedBuilder(
                animation: _colorAnimationController,
                builder: (context, child) => Container(
                      color: _colorTween.value,
                    )),
          )
        ]));
  }

  void _onRefresh() async {
    setState(() {
      _futureBuilderFuture = loadData();
    });
  }

  initState() {
    super.initState();
    _futureBuilderFuture = loadData();
    _colorAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 0));
    _colorTween = ColorTween(begin: Colors.transparent, end: Color(0xffff8f00))
        .animate(_colorAnimationController);
  }

  bool _scrollListener(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.axis == Axis.vertical) {
      _colorAnimationController.animateTo(scrollInfo.metrics.pixels /
          (Adapt.px(520) - MediaQuery.of(context).padding.top));
      return true;
    }
    return false;
  }

  Future loadData() async {
    var data = await getHomeData();
    print("loadDataloadDataloadDataloadDataloadDataloadData");
    print(data);
    HomeEntity homeEntity = HomeEntity.fromJson(data);

    return homeEntity;
  }
}
