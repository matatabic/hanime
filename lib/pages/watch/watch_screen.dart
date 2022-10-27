import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hanime/common/fijkplayer_skin/schema.dart';
import 'package:hanime/common/widget/hero_slide_page.dart';
import 'package:hanime/component/anime_2card.dart';
import 'package:hanime/component/anime_3card.dart';
import 'package:hanime/entity/watch_entity.dart';
import 'package:hanime/pages/watch/video_screen.dart';
import 'package:hanime/providers/download_model.dart';
import 'package:hanime/providers/watch_model.dart';
import 'package:hanime/services/watch_services.dart';
import 'package:hanime/utils/utils.dart';
import 'package:provider/src/provider.dart';

import 'brief_screen.dart';
import 'episode_screen.dart';
import 'info_screen.dart';

class WatchScreen extends StatefulWidget {
  final String htmlUrl;

  WatchScreen({Key? key, required this.htmlUrl}) : super(key: key);

  @override
  _WatchScreenState createState() => _WatchScreenState();
}

class _WatchScreenState extends State<WatchScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  Interval opacityCurve = Interval(0.0, 1, curve: Curves.fastOutSlowIn);
  ScrollController _controller = ScrollController();
  var _futureBuilderFuture;
  final FijkPlayer player = FijkPlayer();
  dynamic _videoIndex;
  bool _loading = false;
  String _shareTitle = '';

  int _cloudFlareStep = 0;
  int _durationTime = 1500;
  bool _networkError = false;
  InAppWebViewController? _webViewController;

  @override
  initState() {
    super.initState();
    _futureBuilderFuture = loadData(widget.htmlUrl);
  }

  @override
  dispose() {
    player.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<WatchModel>().setIsFlicker(false);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: FutureBuilder(
          builder: _buildFuture,
          future:
              _futureBuilderFuture, // 用户定义的需要异步执行的代码，类型为Future<String>或者null的变量或函数
        ),
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
          if (_networkError) {
            return Center(
                child: MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: Text('网络异常,点击重新加载'),
              onPressed: () {
                setState(() {
                  _networkError = false;
                  _futureBuilderFuture = loadData(widget.htmlUrl);
                });
              },
            ));
          }
          return Stack(
            children: [
              Opacity(
                opacity: 0,
                child: SizedBox(
                  width: 1,
                  height: 1,
                  child: InAppWebView(
                    onWebViewCreated: (controller) {
                      _webViewController = controller;
                    },
                    initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions(
                        clearCache: false,
                      ),
                    ),
                    initialUrlRequest:
                        URLRequest(url: Uri.parse(widget.htmlUrl)),
                    onLoadError: (controller, url, code, message) {
                      print("onLoadError");
                    },
                    onLoadHttpError: (controller, url, code, message) {
                      print("onLoadHttpError");
                    },
                    onUpdateVisitedHistory:
                        (controller, url, androidIsReload) async {
                      if (url.toString() != widget.htmlUrl) {
                        _durationTime = 5000;
                      }
                      if (_cloudFlareStep == 4) {
                        _durationTime = 2000;
                      }

                      Utils.debounce(() async {
                        String? html = await _webViewController?.getHtml();
                        _cloudFlareStep = 0;
                        if (html != null && !html.contains("net::ERR")) {
                          setState(() {
                            _futureBuilderFuture =
                                watchHtml2Data(html, widget.htmlUrl);
                          });
                        } else {
                          setState(() {
                            _networkError = true;
                          });
                        }
                      }, durationTime: _durationTime);
                      _cloudFlareStep++;
                    },
                  ),
                ),
              ),
              Center(child: CircularProgressIndicator())
            ],
          );

          // return Text('Error: ${snapshot.error}');
        } else {
          return _createWidget(context, snapshot);
        }
    }
  }

  playerChange(String url) async {
    if (player.value.state == FijkState.completed) {
      await player.stop();
    }

    await player.reset().then((_) async {
      player.setDataSource(url, autoPlay: true);
    });
  }

  playerStop() async {
    await player.pause();
  }

  videoChange(WatchEntity watchEntity, int index) async {
    if (_loading) {
      return;
    }
    playerStop();
    setState(() {
      _loading = true;
      _videoIndex = index;
    });
    context.read<WatchModel>().setIsFlicker(false);
    WatchEntity data = await loadData(watchEntity.episode[index].htmlUrl);
    playerChange(data.videoData.video[0].list[0].url);
    setState(() {
      watchEntity.info = data.info;
      watchEntity.tag = data.tag;
      watchEntity.videoData = data.videoData;
      _shareTitle = data.info.shareTitle;
      _loading = false;
    });
  }

  Future loadData(htmlUrl) async {
    WatchEntity watchEntity = await getWatchData(htmlUrl);
    return watchEntity;
  }

  Widget _createWidget(BuildContext context, AsyncSnapshot snapshot) {
    print("_createWidget");
    WatchEntity watchEntity = snapshot.data;
    return SafeArea(
        child: SizedBox.expand(
            child: CustomScrollView(controller: _controller, slivers: <Widget>[
      SliverAppBar(
          automaticallyImplyLeading: false,
          pinned: true,
          collapsedHeight: 260,
          floating: true,
          stretch: false,
          expandedHeight: 260,
          flexibleSpace: VideoScreen(
            watchEntity: watchEntity,
            videoSource: context
                    .read<DownloadModel>()
                    .isCacheVideo(watchEntity.info.htmlUrl)
                ? context
                    .read<DownloadModel>()
                    .getCacheVideoUrl(watchEntity.info.htmlUrl)
                : VideoSourceFormat.fromJson(watchEntity.videoData.toJson()),
            player: player,
            playerChange: (String url) => playerChange,
            episodeScreen: EpisodeScreen(
                watchEntity: watchEntity,
                itemWidth: 170,
                itemHeight: 110,
                direction: false,
                videoIndex: _videoIndex,
                loading: _loading,
                videoChange: (int index) => videoChange(watchEntity, index)),
          )),
      SliverToBoxAdapter(
          child: BriefScreen(
        watchEntity: watchEntity,
        playerChange: (String url) => playerChange,
        controller: _controller,
      )),
      SliverToBoxAdapter(
          child: InfoScreen(
        shareTitle: _shareTitle,
        player: player,
        watchEntity: watchEntity,
      )),
      SliverToBoxAdapter(
        child: EpisodeScreen(
            watchEntity: watchEntity,
            containerHeight: 150,
            itemWidth: 170,
            itemHeight: 110,
            direction: true,
            videoIndex: _videoIndex,
            loading: _loading,
            videoChange: (int index) => videoChange(watchEntity, index)),
      ),
      SliverToBoxAdapter(
        child: Container(
          height: 50,
          child: Center(
            child: Text(
              "相關推薦",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      SliverGrid(
        //调整间距
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //横轴元素个数
            crossAxisCount: watchEntity.commendCount,
            //纵轴间距
            mainAxisSpacing: 5,
            //横轴间距
            crossAxisSpacing: 5,
            //子组件宽高长度比例
            childAspectRatio: watchEntity.commendCount == 3 ? 2 / 3 : 1.05),
        //加载内容
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            print("SliverChildBuilderDelegate");
            String heroTag = UniqueKey().toString();
            return watchEntity.commendCount == 3
                ? Anime3Card(
                    onTap: () {
                      playerStop();
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => WatchScreen(
                                  htmlUrl:
                                      watchEntity.commend[index].htmlUrl)));
                    },
                    onLongPress: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          opaque: false,
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return AnimatedBuilder(
                              animation: animation,
                              builder: (context, child) {
                                return Opacity(
                                  opacity:
                                      opacityCurve.transform(animation.value),
                                  child: HeroSlidePage(
                                      heroTag: heroTag,
                                      url: watchEntity.commend[index].imgUrl),
                                );
                              },
                            );
                          }));
                    },
                    heroTag: heroTag,
                    title: watchEntity.commend[index].title,
                    imgUrl: watchEntity.commend[index].imgUrl)
                : Anime2Card(
                    onTap: () {
                      playerStop();
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => WatchScreen(
                                  htmlUrl:
                                      watchEntity.commend[index].htmlUrl)));
                    },
                    onLongPress: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          opaque: false,
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return AnimatedBuilder(
                              animation: animation,
                              builder: (context, child) {
                                return Opacity(
                                  opacity:
                                      opacityCurve.transform(animation.value),
                                  child: HeroSlidePage(
                                      heroTag: heroTag,
                                      url: watchEntity.commend[index].imgUrl),
                                );
                              },
                            );
                          }));
                    },
                    heroTag: heroTag,
                    htmlUrl: watchEntity.commend[index].htmlUrl,
                    title: watchEntity.commend[index].title,
                    imgUrl: watchEntity.commend[index].imgUrl,
                    duration: watchEntity.commend[index].duration,
                    genre: watchEntity.commend[index].genre,
                    author: watchEntity.commend[index].author,
                    created: watchEntity.commend[index].created,
                  );
          },
          childCount: watchEntity.commend.length, //设置个数
        ),
      )
    ])));
  }
}
