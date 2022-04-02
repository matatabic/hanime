import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/common/common_image.dart';
import 'package:hanime/entity/watch_entity.dart';
import 'package:hanime/pages/watch/video_screen.dart';
import 'package:hanime/services/watch_services.dart';

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
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
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
                  if (_videoIndex || _loading) {
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
      SliverPadding(
        padding: EdgeInsets.only(top: Adapt.px(20)),
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
            return watchEntity.commendCount == 3
                ? getItemContainer(watchEntity.commend[index])
                : getItemContainer1(watchEntity.commend[index]);
          },
          childCount: watchEntity.commend.length, //设置个数
        ),
      )
    ])));
  }

  Widget getItemContainer(WatchCommend item) {
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => WatchScreen(htmlUrl: item.url)));
        },
        child: Stack(
          alignment: Alignment(-1, 1),
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
          ],
        ));
  }

  Widget getItemContainer1(WatchCommend item) {
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => WatchScreen(htmlUrl: item.url)));
        },
        child: Stack(
          alignment: Alignment(-1, 1),
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
                "123",
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
          ],
        ));
  }
}
