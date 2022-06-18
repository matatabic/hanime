import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/component/anime_2card.dart';
import 'package:hanime/component/anime_3card.dart';
import 'package:hanime/entity/search_entity.dart';
import 'package:hanime/pages/search/search_engine_screen.dart';
import 'package:hanime/pages/watch/watch_screen.dart';
import 'package:hanime/providers/search_model.dart';
import 'package:hanime/services/search_services.dart';
import 'package:provider/src/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'search_menu_screen.dart';

class SearchScreen extends StatefulWidget {
  final String htmlUrl;
  final int currentScreen;
  SearchScreen(
      {Key? key,
      this.htmlUrl = "https://hanime1.me/search?query=",
      this.currentScreen = 0})
      : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  var _futureBuilderFuture;
  int page = 1;
  late int totalPage;
  late int commendCount;
  List<SearchVideo> searchVideoList = [];

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  double topHeight =
      MediaQueryData.fromWindow(window).padding.top + Adapt.px(160);

  void _onLoading(BuildContext context, bool loadMore) async {
    print("_onLoading");
    // await Future.delayed(Duration(milliseconds: 1000));
    Search search =
        context.read<SearchModel>().searchList[widget.currentScreen];

    var htmlUrl = "https://hanime1.me/search?query=${search.query}";

    if (search.genreIndex > 0) {
      htmlUrl = "$htmlUrl&genre=${genre.data[search.genreIndex]}";
    }

    if (search.sortIndex > 0) {
      htmlUrl = "$htmlUrl&sort=${genre.data[search.sortIndex]}";
    }

    if (search.durationIndex > 0) {
      htmlUrl = "$htmlUrl&duration=${genre.data[search.durationIndex]}";
    }

    if (search.broad) {
      htmlUrl = "$htmlUrl&broad=on";
    }

    if (search.year != null && search.year != "全部") {
      htmlUrl = "$htmlUrl&year=${search.year}";
      if (search.month != null && search.month != "全部") {
        htmlUrl = "$htmlUrl&month=${search.month}";
      }
    }

    if (search.tagList.length > 0) {
      for (String tag in search.tagList) {
        htmlUrl = "$htmlUrl&tags[]=$tag";
      }
    }

    if (search.brandList.length > 0) {
      for (String brand in search.brandList) {
        htmlUrl = "$htmlUrl&brands[]=$brand";
      }
    }

    print(search.htmlUrl);
    print(htmlUrl);

    if (loadMore) {
      if (totalPage - page > 0) {
        htmlUrl = "$htmlUrl&page=${page + 1}";
        await loadData(htmlUrl);
        page = page + 1;
        context.read<SearchModel>().setHtmlUrl(widget.currentScreen, htmlUrl);
        setState(() {});
        _refreshController.loadComplete();
      } else {
        _refreshController.loadNoData();
      }
    } else {
      if (search.htmlUrl != htmlUrl) {
        page = 1;
        searchVideoList = [];
        setState(() {
          _futureBuilderFuture = loadData(htmlUrl);
        });
        context.read<SearchModel>().setHtmlUrl(widget.currentScreen, htmlUrl);
        _refreshController.loadComplete();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

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
            // physics: const ClampingScrollPhysics(),
            enablePullDown: false,
            enablePullUp: true,
            controller: _refreshController,
            onLoading: () => _onLoading(context, true),
            footer: CustomFooter(
              builder: (BuildContext context, LoadStatus? mode) {
                Widget body;
                if (mode == LoadStatus.loading) {
                  body = CupertinoActivityIndicator();
                } else if (mode == LoadStatus.failed) {
                  body = Text("加载失败！点击重试！");
                } else if (mode == LoadStatus.canLoading) {
                  body = Text("松手,加载更多!");
                } else if (mode == LoadStatus.noMore) {
                  body = Text("没有更多数据了!");
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
                          currentScreen: widget.currentScreen,
                          loadData: () => _onLoading(context, false)),
                      SearchMenuScreen(
                          currentScreen: widget.currentScreen,
                          loadData: () => _onLoading(context, false))
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
          String htmlUrl = context.watch<SearchModel>().htmlUrl;
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
    List<SearchVideo> videoList = snapshot.data;

    return SliverGrid(
      //调整间距
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //横轴元素个数
          crossAxisCount: commendCount,
          //纵轴间距
          mainAxisSpacing: 5.0,
          //横轴间距
          crossAxisSpacing: 5.0,
          //子组件宽高长度比例
          childAspectRatio: commendCount == 3 ? 2 / 3 : 1.1),
      //加载内容
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return commendCount == 3
              ? Anime3Card(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => WatchScreen(
                                htmlUrl: videoList[index].htmlUrl)));
                  },
                  title: videoList[index].title,
                  imgUrl: videoList[index].imgUrl)
              : Anime2Card(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => WatchScreen(
                                htmlUrl: videoList[index].htmlUrl)));
                  },
                  htmlUrl: videoList[index].htmlUrl,
                  title: videoList[index].title,
                  imgUrl: videoList[index].imgUrl,
                  duration: videoList[index].duration,
                  genre: videoList[index].genre,
                  author: videoList[index].author,
                  created: videoList[index].created,
                );
        },
        childCount: videoList.length, //设置个数
      ),
    );
  }

  initState() {
    super.initState();
    _futureBuilderFuture = loadData(widget.htmlUrl);
  }

  Future loadData(url) async {
    var data = await getSearchData(url);

    SearchEntity searchEntity = SearchEntity.fromJson(data);

    commendCount = searchEntity.commendCount;
    totalPage = searchEntity.page;
    searchVideoList.addAll(searchEntity.video);

    return searchVideoList;
  }
}
