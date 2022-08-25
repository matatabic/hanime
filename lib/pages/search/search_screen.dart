import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/common/hero_slide_page.dart';
import 'package:hanime/component/anime_2card.dart';
import 'package:hanime/component/anime_3card.dart';
import 'package:hanime/entity/search_entity.dart';
import 'package:hanime/pages/search/search_header_widget.dart';
import 'package:hanime/pages/watch/watch_screen.dart';
import 'package:hanime/services/search_services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SearchScreen extends StatefulWidget {
  final List tagList;

  SearchScreen({
    Key? key,
    this.tagList = const [],
  }) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  Interval opacityCurve = Interval(0.0, 1, curve: Curves.fastOutSlowIn);

  var _futureBuilderFuture;
  int _page = 1;
  late int _totalPage;
  late int _commendCount;
  List<SearchVideo> _searchVideoList = [];

  String _htmlUrl = "";

  String _query = "";
  bool _broad = false;
  int _genreIndex = 0;
  int _sortIndex = 0;
  int _durationIndex = 0;

  dynamic _year;
  dynamic _month;
  List<String> _customTagList = [];
  List<String> _tagList = [];
  List<String> _brandList = [];

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  double _topHeight =
      MediaQueryData.fromWindow(window).padding.top + Adapt.px(160);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print("mainBUBBBB");
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
          backgroundColor: Colors.black,
          body: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              print("123333333333333333333333");
              FocusManager.instance.rootScope.requestFocus(FocusNode());
            },
            child: SmartRefresher(
              // physics: const ClampingScrollPhysics(),
              enablePullDown: false,
              enablePullUp: true,
              controller: _refreshController,
              onLoading: () => _onLoading({}, true),
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
                  SearchHeaderWidget(
                    loadData: (dynamic data) => _onLoading(data, false),
                    topHeight: _topHeight,
                    genreIndex: _genreIndex,
                    sortIndex: _sortIndex,
                    durationIndex: _durationIndex,
                    broad: _broad,
                    year: _year,
                    month: _month,
                    customTagList: _customTagList,
                    tagList: _tagList,
                    brandList: _brandList,
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
          )),
    );
  }

  Widget _buildFuture(BuildContext context, AsyncSnapshot snapshot) {
    print("_buildFuture");
    double surHeight = MediaQuery.of(context).size.height -
        _topHeight -
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
                    _futureBuilderFuture = loadData(_jointHtml());
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
    print("_createWidget");
    List<SearchVideo> videoList = snapshot.data;

    return SliverGrid(
      //调整间距
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //横轴元素个数
          crossAxisCount: _commendCount,
          //纵轴间距
          mainAxisSpacing: 5.0,
          //横轴间距
          crossAxisSpacing: 5.0,
          //子组件宽高长度比例
          childAspectRatio: _commendCount == 3 ? 2 / 3 : 1.1),
      //加载内容
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          String heroTag = UniqueKey().toString();
          return _commendCount == 3
              ? Anime3Card(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => WatchScreen(
                                htmlUrl: videoList[index].htmlUrl)));
                  },
                  onLongPress: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return AnimatedBuilder(
                            animation: animation,
                            builder: (context, child) {
                              return Opacity(
                                opacity:
                                    opacityCurve.transform(animation.value),
                                child: HeroSlidePage(
                                    heroTag: heroTag,
                                    url: videoList[index].imgUrl),
                              );
                            },
                          );
                        }));
                  },
                  heroTag: heroTag,
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
                  onLongPress: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return AnimatedBuilder(
                            animation: animation,
                            builder: (context, child) {
                              return Opacity(
                                opacity:
                                    opacityCurve.transform(animation.value),
                                child: HeroSlidePage(
                                    heroTag: heroTag,
                                    url: videoList[index].imgUrl),
                              );
                            },
                          );
                        }));
                  },
                  heroTag: heroTag,
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

  @override
  void initState() {
    super.initState();
    initTagListAndCustomTagList();
    _futureBuilderFuture = loadData(_jointHtml());
  }

  void initTagListAndCustomTagList() {
    List tempList = [];

    for (var item in searchTag.data) {
      tempList.addAll(item.data);
    }

    for (var item in widget.tagList) {
      _tagList.add(item);
      if (!tempList.contains(item)) {
        _customTagList.add(item);
      }
    }

    print("_tagList: $_tagList");
    print("_customTagList: $_customTagList");
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onLoading(dynamic data, bool loadMore) async {
    print("_onLoading");
    print(data);
    _saveData(data);
    String newHtml = _jointHtml();
    print(_htmlUrl);
    print(newHtml);
    if (loadMore) {
      if (_totalPage - _page > 0) {
        //获取下一页数据
        print("获取下一页数据");
        _page = _page + 1;
        String tempHtml = "$newHtml&page=$_page";
        await loadData(tempHtml);
        setState(() {});
        _refreshController.loadComplete();
      } else {
        //已经没有更多数据
        print("已经没有更多数据");
        _refreshController.loadNoData();
      }
    } else {
      //获取新的数据，相同的url就不执行
      print("获取新的数据，相同的url就不执行");
      if (newHtml != _htmlUrl) {
        _page = 1;
        _searchVideoList = [];
        setState(() {
          _futureBuilderFuture = loadData(newHtml);
        });
        _refreshController.loadComplete();
      }
    }
  }

  void _saveData(dynamic data) {
    print("_saveData: $data");
    switch (data['type']) {
      case "query":
        _query = data['data'];
        break;
      case "broad":
        _broad = data['data'];
        break;
      case "genre":
        _genreIndex = data['data'];
        break;
      case "sort":
        _sortIndex = data['data'];
        break;
      case "duration":
        _durationIndex = data['data'];
        break;
      case "date":
        _year = data['data']['year'];
        _month = data['data']['month'];
        break;
      case "tag":
        _tagList = data['data'];
        break;
      case "brand":
        _brandList = data['data'];
        break;
    }
  }

  String _jointHtml() {
    String newHtml = "https://hanime1.me/search?query=";
    if (_query.length > 0) {
      newHtml = "$newHtml$_query";
    }

    if (_broad) {
      newHtml = "$newHtml&broad=on";
    }

    if (_genreIndex > 0) {
      newHtml = "$newHtml&genre=${genre.data[_genreIndex]}";
    }

    if (_sortIndex > 0) {
      newHtml = "$newHtml&sort=${sort.data[_sortIndex]}";
    }

    if (_durationIndex > 0) {
      newHtml = "$newHtml&duration=${duration.data[_durationIndex]}";
    }

    if (_year != null && _year != "全部") {
      newHtml = "$newHtml&year=$_year";
      if (_month != null && _month != "全部") {
        newHtml = "$newHtml&month=$_month";
      }
    }

    if (_tagList.length > 0) {
      for (String tag in _tagList) {
        newHtml = "$newHtml&tags[]=$tag";
      }
    }

    if (_brandList.length > 0) {
      for (String brand in _brandList) {
        newHtml = "$newHtml&brands[]=$brand";
      }
    }

    return newHtml;
  }

  Future loadData(url) async {
    print("请求数据");
    var data = await getSearchData(url);

    SearchEntity searchEntity = data;
    _htmlUrl = url;
    _commendCount = searchEntity.commendCount;
    _totalPage = searchEntity.page;
    _searchVideoList.addAll(searchEntity.video);
    print(_searchVideoList.length);
    print("async loadData");
    return _searchVideoList;
  }
}
