import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

///M为Dao返回数据模型，L为列表数据模型，T为具体widget
abstract class BaseListReFreshState<M, L, T extends StatefulWidget>
    extends State<T> {
  List<L> dataList = [];
  int pageIndex = 1;
  late RefreshController refreshController;
  get contentChild;
  void _onRefresh() async {
    loadData(loadMore: false);
  }

  void _onLoading() async {
    loadData(loadMore: true);
  }

  @override
  void initState() {
    super.initState();
    refreshController = RefreshController(initialRefresh: false);
    loadData(loadMore: false);
  }

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        // WaterDropHeader、ClassicHeader、CustomHeader、LinkHeader、MaterialClassicHeader、WaterDropMaterialHeader
        header: CustomHeader(
          builder: (BuildContext context, RefreshStatus? mode) {
            return Container(
              child: Lottie.asset('assets/83685-hubit.json', height: 60),
            );
          },
        ),
        // ClassicFooter、CustomFooter、LinkFooter、LoadIndicator
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus? mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("pull up load");
            } else if (mode == LoadStatus.loading) {
              body = Container(
                child: Lottie.asset('assets/79609-loading-button.json',
                    height: 60),
              );
            } else if (mode == LoadStatus.failed) {
              body = InkWell(
                onTap: () {
                  _onLoading();
                },
                child: Text("加载失败，点击重新加载"),
              );
            } else if (mode == LoadStatus.noMore) {
              body = InkWell(
                onTap: () {
                  _onLoading();
                },
                child: Text("暂无更多数据"),
              );
            } else {
              body = Text("暂无更多数据");
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: contentChild,
      ),
    );
  }

  //获取对应页吗的数据
  Future<M> getData(int pageIndex);

  ///从Mo中解析出list数据
  List<L> parseList(M result);

  Future<void> loadData({loadMore = false}) async {
    if (!loadMore) {
      pageIndex = 1;
    }
    var currentIndex = pageIndex + (loadMore ? 1 : 0);

    try {
      var result = await getData(currentIndex);
      if (mounted) {
        setState(() {
          if (loadMore) {
            if (parseList(result).length == 0) {
              refreshController.loadNoData();
            } else {
              refreshController.loadComplete();
            }
            //合成新数组
            dataList = [...dataList, ...parseList(result)];
            if (parseList(result).length != 0) {
              pageIndex++;
            }
          } else {
            dataList = parseList(result);
            refreshController.refreshCompleted(resetFooterState: true);
          }
        });
      }
    } catch (e) {
      setState(() {
        if (loadMore) {
          refreshController.loadFailed();
        } else {
          refreshController.refreshFailed();
        }
      });
    }
  }
}
