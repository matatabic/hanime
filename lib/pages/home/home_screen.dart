import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/entity/home_entity.dart';
import 'package:hanime/pages/home/home_card.dart';
import 'package:hanime/pages/home/home_header_screen.dart';
import 'package:hanime/pages/watch/watch_screen.dart';
import 'package:hanime/providers/home_state.dart';
import 'package:hanime/services/home_services.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:provider/src/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'cover_photo.dart';
import 'home_tag_card.dart';

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

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
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
        if (snapshot.hasError) {
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
                  child: HomeHeaderScreen(
                swiperList: homeEntity.swiper,
                currentSwiperImage: homeEntity
                    .swiper[context.watch<HomeState>().swiperIndex].imgUrl,
              )),
              // 当列表项高度固定时，使用 SliverFixedExtendList 比 SliverList 具有更高的性能
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                switch (index) {
                  case 0:
                    return topWidget(homeEntity.top);
                  case 1:
                    return latestWidget(homeEntity.latest);
                  case 2:
                    return fireWidget(homeEntity.fire);
                  case 3:
                    return tagWidget(homeEntity.tag);
                  case 4:
                    return hotWidget(homeEntity.hot);
                  case 5:
                    return watchWidget(homeEntity.watch);
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

  Widget topWidget(HomeTop data) {
    return Column(children: <Widget>[
      Container(
          height: Adapt.px(70),
          alignment: Alignment.topCenter,
          margin: EdgeInsets.only(left: Adapt.px(5)),
          child: Row(children: <Widget>[
            Text(
              data.label,
              style: TextStyle(fontSize: Adapt.px(38)),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: Adapt.px(36),
            )
          ]),
          width: double.infinity),
      SizedBox(
          height: Adapt.px(400),
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: data.video.length,
              itemBuilder: (BuildContext context, int index) {
                return CoverPhoto(
                  title: data.video[index].title,
                  imgUrl: data.video[index].imgUrl,
                  latest: data.video[index].latest,
                  width: Adapt.px(270),
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) =>
                              WatchScreen(htmlUrl: data.video[index].htmlUrl)),
                    );
                  },
                );
              }))
    ]);
  }

  Widget latestWidget(HomeLatest data) {
    return Column(children: <Widget>[
      Container(
          height: Adapt.px(70),
          alignment: Alignment.topCenter,
          margin: EdgeInsets.only(left: Adapt.px(5)),
          child: Row(children: <Widget>[
            Text(
              data.label,
              style: TextStyle(fontSize: Adapt.px(38)),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: Adapt.px(36),
            )
          ]),
          width: double.infinity),
      SizedBox(
        height: Adapt.px(820),
        child: InfiniteCarousel.builder(
          itemCount: data.video.length,
          itemExtent: Adapt.screenW() / 2,
          center: false,
          anchor: 1,
          velocityFactor: 1,
          itemBuilder: (context, itemIndex, realIndex) {
            return Padding(
              padding: EdgeInsets.all(3),
              child: Column(
                children: [
                  HomeCard(data: data.video[itemIndex][0]),
                  HomeCard(data: data.video[itemIndex][1])
                ],
              ),
            );
          },
        ),
      ),
    ]);
  }

  Widget fireWidget(HomeFire data) {
    return Column(children: <Widget>[
      Container(
          height: Adapt.px(70),
          alignment: Alignment.topCenter,
          margin: EdgeInsets.only(left: Adapt.px(5)),
          child: Row(children: <Widget>[
            Text(
              data.label,
              style: TextStyle(fontSize: Adapt.px(38)),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: Adapt.px(36),
            )
          ]),
          width: double.infinity),
      SizedBox(
          height: Adapt.px(400),
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: data.video.length,
              itemBuilder: (BuildContext context, int index) {
                return CoverPhoto(
                  title: data.video[index].title,
                  imgUrl: data.video[index].imgUrl,
                  // latest: data.video[index].latest,
                  width: Adapt.px(270),
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) =>
                              WatchScreen(htmlUrl: data.video[index].htmlUrl)),
                    );
                  },
                );
              }))
    ]);
  }

  Widget tagWidget(HomeTag data) {
    return Column(children: <Widget>[
      Container(
          height: Adapt.px(70),
          alignment: Alignment.topCenter,
          margin: EdgeInsets.only(left: Adapt.px(5)),
          child: Row(children: <Widget>[
            Text(
              data.label,
              style: TextStyle(fontSize: Adapt.px(38)),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: Adapt.px(36),
            )
          ]),
          width: double.infinity),
      SizedBox(
        height: Adapt.px(480),
        child: InfiniteCarousel.builder(
          itemCount: data.video.length,
          itemExtent: Adapt.screenW() / 2,
          center: false,
          anchor: 1,
          velocityFactor: 1,
          itemBuilder: (context, itemIndex, realIndex) {
            return Padding(
              padding: EdgeInsets.all(3),
              child: Column(
                children: [
                  HomeTagCard(data: data.video[itemIndex][0], index: 0),
                  HomeTagCard(data: data.video[itemIndex][1], index: 1)
                ],
              ),
            );
          },
        ),
      ),
    ]);
  }

  Widget hotWidget(HomeHot data) {
    return Column(children: <Widget>[
      Container(
          height: Adapt.px(70),
          alignment: Alignment.topCenter,
          margin: EdgeInsets.only(left: Adapt.px(5)),
          child: Row(children: <Widget>[
            Text(
              data.label,
              style: TextStyle(fontSize: Adapt.px(38)),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: Adapt.px(36),
            )
          ]),
          width: double.infinity),
      SizedBox(
          height: Adapt.px(400),
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: data.video.length,
              itemBuilder: (BuildContext context, int index) {
                return CoverPhoto(
                  title: data.video[index].title,
                  imgUrl: data.video[index].imgUrl,
                  width: Adapt.px(270),
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) =>
                              WatchScreen(htmlUrl: data.video[index].htmlUrl)),
                    );
                  },
                );
              }))
    ]);
  }

  Widget watchWidget(HomeWatch homeWatch) {
    return Container();
  }

  Widget cardWidget(HomeWatch homeWatch) {
    return Container();
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
    HomeEntity homeEntity = HomeEntity.fromJson(data);

    return homeEntity;
  }
}
