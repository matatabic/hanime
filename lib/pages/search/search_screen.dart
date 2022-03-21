import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/common/common_image.dart';
import 'package:hanime/common/modal_bottom_route.dart';
import 'package:hanime/entity/search_entity.dart';
import 'package:hanime/pages/search/search_engine_screen.dart';
import 'package:hanime/pages/watch/watch_screen.dart';
import 'package:hanime/providers/search_state.dart';
import 'package:hanime/services/search_services.dart';
import 'package:provider/src/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'search_menu_screen.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  var _futureBuilderFuture;
  var _random = "a";
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  String baseUrl =
      "https://hanime1.me/search?query=&genre=全部&sort=无&duration=全部";
  double topHeight =
      MediaQueryData.fromWindow(window).padding.top + Adapt.px(190);

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    var rng = new Random();

    setState(() {
      _random = rng.nextInt(100).toString();
    });

    return Scaffold(
        backgroundColor: Colors.black,
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          onPanDown: (_) {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SmartRefresher(
            enablePullDown: false,
            enablePullUp: true,
            controller: _refreshController,
            onLoading: _onLoading,
            footer: CustomFooter(
              builder: (BuildContext context, LoadStatus? mode) {
                Widget body;
                if (mode == LoadStatus.idle) {
                  body = Text("上拉加载");
                } else if (mode == LoadStatus.loading) {
                  body = CupertinoActivityIndicator();
                } else if (mode == LoadStatus.failed) {
                  body = Text("加载失败！点击重试！");
                } else if (mode == LoadStatus.canLoading) {
                  body = Text("松手,加载更多!");
                } else {
                  body = Text("没有更多数据了!");
                }
                return Container(
                  height: 55.0,
                  child: Center(child: body),
                );
              },
            ),
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  pinned: false,
                  floating: true,
                  stretch: true,
                  automaticallyImplyLeading: false,
                  toolbarHeight: topHeight,
                  expandedHeight: topHeight,
                  flexibleSpace: Column(
                    children: [
                      SearchEngineScreen(
                          loadData: (String url) => {
                                setState(() {
                                  _futureBuilderFuture = loadData(url);
                                })
                              }),
                      SearchMenuScreen(
                          loadData: (String url) => {
                                setState(() {
                                  _futureBuilderFuture = loadData(url);
                                })
                              })
                    ],
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.only(top: 10),
                ),
                FutureBuilder(
                  builder: _buildFuture,
                  future:
                      _futureBuilderFuture, // 用户定义的需要异步执行的代码，类型为Future<String>或者null的变量或函数
                ),
                SliverPadding(
                  padding: EdgeInsets.only(bottom: 10),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildFuture(BuildContext context, AsyncSnapshot snapshot) {
    double surHeight = MediaQuery.of(context).size.height -
        topHeight -
        MediaQueryData.fromWindow(window).padding.top -
        40 -
        kBottomNavigationBarHeight;

    switch (snapshot.connectionState) {
      case ConnectionState.none:
        print('还没有开始网络请求');
        return Text('还没有开始网络请求');
      case ConnectionState.active:
        print('active');
        return Text('ConnectionState.active');
      case ConnectionState.waiting:
        print('waiting');
        return SliverToBoxAdapter(
          child: Container(
            height: surHeight,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      case ConnectionState.done:
        print('done');
        if (snapshot.hasError) {
          String htmlUrl = context.watch<SearchState>().htmlUrl;
          return SliverToBoxAdapter(
            child: Container(
              height: surHeight,
              child: Center(
                  child: MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: Text('网络异常,点击重新加载'),
                onPressed: () {
                  setState(() {
                    _futureBuilderFuture = loadData(htmlUrl);
                  });
                },
              )),
            ),
          );
          // return Text('Error: ${snapshot.error}');
        } else {
          return _createWidget(context, snapshot);
        }
    }
  }

  Widget _createWidget(BuildContext context, AsyncSnapshot snapshot) {
    SearchEntity searchEntity = snapshot.data;
    return SliverGrid(
      //调整间距
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //横轴元素个数
          crossAxisCount: 2,
          //纵轴间距
          mainAxisSpacing: 5.0,
          //横轴间距
          crossAxisSpacing: 5.0,
          //子组件宽高长度比例
          childAspectRatio: 1.1),
      //加载内容
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return getItemContainer(searchEntity.video[index]);
        },
        childCount: searchEntity.video.length, //设置个数
      ),
    );
  }

  Widget getItemContainer(SearchVideo item) {
    return InkWell(
        onTap: () {
          Navigator.push(context,
              Right2LeftRouter(child: WatchScreen(htmlUrl: item.htmlUrl)));
        },
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              flex: 5,
              child: Stack(
                alignment: Alignment(0.9, 0.9),
                children: <Widget>[
                  ConstrainedBox(
                    child: CommonImages(
                      imgUrl:
                          // item.imgUrl
                          'http://img5.mtime.cn/mt/2022/01/19/102417.23221502_1280X720X2.jpg',
                    ),
                    constraints: new BoxConstraints.expand(),
                  ),
                  Container(
                    child: Text(
                      item.duration,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(1.5, 1.5),
                            blurRadius: 3.5,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 2,
                child: Center(
                  child: Container(
                    child: Text(
                      item.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(2.5, 2.5),
                            blurRadius: 3.5,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ))
          ],
        ));
  }

  initState() {
    super.initState();
    _futureBuilderFuture = loadData(baseUrl);
  }

  Future loadData(url) async {
    var data = await getSearchData(url);
    SearchEntity searchEntity = SearchEntity.fromJson(data);
    print(data);
    return searchEntity;
  }
}
