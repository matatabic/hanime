import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/common/fijkplayer_skin/schema.dart';
import 'package:hanime/common/hero_photo_view.dart';
import 'package:hanime/common/modal_bottom_route.dart';
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
  var _futureBuilderFuture;
  final FijkPlayer player = FijkPlayer();
  var _videoIndex;
  bool _loading = false;
  String _shareTitle = "";

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
        }
        ;
        return _createWidget(context, snapshot);
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

  initState() {
    super.initState();
    _futureBuilderFuture = loadData();
  }

  Future loadData() async {
    var data = await getWatchData(widget.htmlUrl);
    WatchEntity watchEntity = WatchEntity.fromJson(data);

    return watchEntity;
  }

  getEpisodeData(htmlUrl) async {
    var data = await getWatchData(htmlUrl);
    WatchEntity watchEntity = WatchEntity.fromJson(data);

    return watchEntity;
  }

  Widget _createWidget(BuildContext context, AsyncSnapshot snapshot) {
    print("_createWidget");
    WatchEntity watchEntity = snapshot.data;

    return SafeArea(
        child: SizedBox.expand(
            child: CustomScrollView(slivers: <Widget>[
      SliverAppBar(
          automaticallyImplyLeading: false,
          pinned: true,
          collapsedHeight: Adapt.px(520),
          floating: true,
          stretch: false,
          expandedHeight: Adapt.px(520),
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
                itemWidth: 320,
                itemHeight: 220,
                direction: false,
                videoIndex: _videoIndex,
                loading: _loading,
                onTap: (index) async {
                  if (_videoIndex == index || _loading) {
                    return;
                  }
                  setState(() {
                    _loading = true;
                    _videoIndex = index;
                  });
                  WatchEntity data =
                      await getEpisodeData(watchEntity.episode[index].htmlUrl);
                  playerChange(data.videoData.video[0].list[0].url);

                  setState(() {
                    _shareTitle = data.info.shareTitle;
                    _loading = false;
                  });
                }),
          )),
      SliverToBoxAdapter(
          child: BriefScreen(
        watchEntity: watchEntity,
        playerChange: (String url) => playerChange,
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
            containerHeight: 300,
            itemWidth: 320,
            itemHeight: 200,
            videoIndex: _videoIndex,
            loading: _loading,
            direction: true,
            onTap: (index) async {
              if (index == _videoIndex || _loading) {
                return;
              }
              setState(() {
                _loading = true;
                _videoIndex = index;
              });
              WatchEntity data =
                  await getEpisodeData(watchEntity.episode[index].htmlUrl);
              playerChange(data.videoData.video[0].list[0].url);

              setState(() {
                _shareTitle = data.info.shareTitle;
                _loading = false;
              });
            }),
      ),
      SliverToBoxAdapter(
        child: Container(
          height: Adapt.px(100),
          child: Center(
            child: Text(
              "相關推薦",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: Adapt.px(45),
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
            mainAxisSpacing: Adapt.px(10),
            //横轴间距
            crossAxisSpacing: Adapt.px(10),
            //子组件宽高长度比例
            childAspectRatio: watchEntity.commendCount == 3 ? 2 / 3 : 1.1),
        //加载内容
        delegate: SliverChildBuilderDelegate(
          (context, index) {
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
                      Navigator.of(context).push(NoAnimRouter(
                        HeroPhotoView(
                            heroTag: heroTag,
                            maxScale: 1.5,
                            imageProvider: NetworkImage(
                                watchEntity.commend[index].imgUrl)),
                      ));
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
                      Navigator.of(context).push(NoAnimRouter(
                        HeroPhotoView(
                            heroTag: heroTag,
                            maxScale: 1.5,
                            imageProvider: NetworkImage(
                                watchEntity.commend[index].imgUrl)),
                      ));
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
