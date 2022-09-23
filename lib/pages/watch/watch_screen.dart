import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/fijkplayer_skin/schema.dart';
import 'package:hanime/common/widget/hero_slide_page.dart';
import 'package:hanime/component/anime_2card.dart';
import 'package:hanime/component/anime_3card.dart';
import 'package:hanime/entity/watch_entity.dart';
import 'package:hanime/pages/watch/video_screen.dart';
import 'package:hanime/providers/download_model.dart';
import 'package:hanime/services/watch_services.dart';
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

class _WatchScreenState extends State<WatchScreen> {
  Interval opacityCurve = Interval(0.0, 1, curve: Curves.fastOutSlowIn);
  ScrollController _controller = ScrollController();
  var _futureBuilderFuture;
  final FijkPlayer player = FijkPlayer();
  // var _videoIndex;
  // bool _loading = false;
  String _shareTitle = "";

  @override
  initState() {
    super.initState();
    _futureBuilderFuture = loadData(widget.htmlUrl);
  }

  @override
  dispose() {
    super.dispose();
    _controller.dispose();
  }

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
                _futureBuilderFuture = loadData(widget.htmlUrl);
              });
            },
          ));
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

  Future loadData(htmlUrl) async {
    print("htmlUrl: $htmlUrl");
    var data = await getWatchData(htmlUrl);
    WatchEntity watchEntity = WatchEntity.fromJson(data);

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
              // videoIndex: _videoIndex,
              // loading: _loading,
              loadData: (String htmlUrl) => loadData(htmlUrl),
              playerChange: (String url) => playerChange(url),
            ),
          )),
      SliverToBoxAdapter(
          child: BriefScreen(
        watchEntity: watchEntity,
        playerChange: (String url) => playerChange,
        controller: _controller,
      )),
      SliverToBoxAdapter(
          child: InfoScreen(
        // shareTitle: _shareTitle,
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
          loadData: (String htmlUrl) => loadData(htmlUrl),
          playerChange: (String url) => playerChange(url),
        ),
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
