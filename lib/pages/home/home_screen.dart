import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hanime/common/modal_bottom_route.dart';
import 'package:hanime/pages/home/anime_photo.dart';
import 'package:hanime/pages/home/swiper_screen.dart';
import 'package:hanime/pages/watch/watch_screen.dart';
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

  late AnimationController _colorAnimationController;
  late Animation _colorTween;

  List dataList = [];
  List swiperList = [];

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    setState(() {
      dataList = [];
      swiperList = [];
    });
    loadData();
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  initState() {
    super.initState();
    loadData();
    _colorAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 0));
    _colorTween = ColorTween(begin: Colors.transparent, end: Color(0xffff8f00))
        .animate(_colorAnimationController);
  }

  bool _scrollListener(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.axis == Axis.vertical) {
      _colorAnimationController.animateTo(scrollInfo.metrics.pixels /
          (260 - MediaQuery.of(context).padding.top));
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
          onNotification: _scrollListener,
          child: Stack(
            children: [
              SmartRefresher(
                enablePullDown: true,
                header: WaterDropMaterialHeader(),
                controller: _refreshController,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                child:
                    CustomScrollView(semanticChildCount: 2, slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: Container(
                      height: 260,
                      child: Stack(children: [
                        ConstrainedBox(
                          child: Stack(children: [
                            Container(
                                height: 260,
                                child: Image.network(
                                    'http://img5.mtime.cn/mt/2022/01/19/102417.23221502_1280X720X2.jpg',
                                    // swiperList[context
                                    //     .watch<HomeState>()
                                    //     .swiper_index]['imgUrl'],
                                    fit: BoxFit.cover)),
                            Container(
                              child: new ClipRect(
                                child: new BackdropFilter(
                                  filter: ImageFilter.blur(
                                      sigmaX: 10.0, sigmaY: 10.0),
                                  child: Opacity(
                                    opacity: 0.5,
                                    child: new Container(
                                      decoration: new BoxDecoration(
                                        color: Colors.grey.shade500
                                            .withOpacity(0.3),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ]),
                          constraints: new BoxConstraints.expand(),
                        ),
                        Container(
                          child: SwiperScreen(swiperList: swiperList),
                          alignment: AlignmentDirectional.bottomStart,
                        )
                      ]),
                    ),
                  ),
                  // 当列表项高度固定时，使用 SliverFixedExtendList 比 SliverList 具有更高的性能
                  SliverFixedExtentList(
                      delegate: SliverChildBuilderDelegate(_buildListItem,
                          childCount: dataList.length),
                      itemExtent: 230),
                ]),
              ),
              Container(
                height: MediaQuery.of(context).padding.top,
                child: AnimatedBuilder(
                    animation: _colorAnimationController,
                    builder: (context, child) => Container(
                          color: _colorTween.value,
                        )),
              ),
            ],
          )),
      // ],
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    return getGroupContainer(dataList[index]);
  }

  Widget getGroupContainer(item) {
    return Column(children: <Widget>[
      Container(
        height: 35,
        margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
        child: Row(children: <Widget>[
          Text(
            item['label'].toString(),
            style: TextStyle(fontSize: 18),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 18,
          )
        ]),
        width: double.infinity,
        // height: double.infinity,
      ),
      Container(
          height: 190,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: item["data"].length,
              itemBuilder: (BuildContext context, int index) {
                return AnimePhoto(
                  data: item["data"][index],
                  width: 130,
                  onTap: () {
                    Navigator.push(
                        context,
                        Right2LeftRouter(
                            child: WatchScreen(
                          htmlUrl: item["data"][index]["url"],
                        )));
                  },
                );
              }))
    ]);
  }

  loadData() async {
    var data = await getHomeData();
    setState(() {
      dataList = data['dataList'];
      swiperList = data['swiperList'];
    });
  }
}
