import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/fijkplayer_skin/fijkplayer_skin.dart';
import 'package:hanime/common/fijkplayer_skin/schema.dart'
    show VideoSourceFormat;
import 'package:hanime/entity/watch_entity.dart';
import 'package:hanime/providers/watch_state.dart';
import 'package:hanime/services/watch_services.dart';
import 'package:provider/src/provider.dart';

import 'brief_screen.dart';
import 'episode_image.dart';
import 'episode_screen.dart';

// 定制UI配置项
class PlayerShowConfig implements ShowConfigAbs {
  @override
  bool drawerBtn = true;
  @override
  bool nextBtn = false;
  @override
  bool speedBtn = true;
  @override
  bool topBar = true;
  @override
  bool lockBtn = true;
  @override
  bool autoNext = false;
  @override
  bool bottomPro = true;
  @override
  bool stateAuto = true;
  @override
  bool isAutoPlay = false;
}

class VideoScreen extends StatefulWidget {
  WatchEntity watchEntity;

  VideoScreen({Key? key, required this.watchEntity}) : super(key: key);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen>
    with TickerProviderStateMixin {
  final FijkPlayer player = FijkPlayer();

  VideoSourceFormat? _videoSource;

  int _curTabIdx = 0;
  int _curActiveIdx = 0;
  var _videoIndex;
  bool _loading = false;

  ShowConfigAbs vCfg = PlayerShowConfig();

  @override
  void dispose() {
    super.dispose();
    // player.dispose();
    player.release();
  }

  @override
  void initState() {
    super.initState();
    // 格式化json转对象
    _videoSource =
        VideoSourceFormat.fromJson(widget.watchEntity.videoData.toJson());
    // 这句不能省，必须有
    speed = 1.0;
  }

  playerChange(String url) async {
    if (player.value.state == FijkState.completed) {
      await player.stop();
    }

    await player.reset().then((_) async {
      player.setDataSource(url, autoPlay: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FijkView(
          height: 260,
          color: Colors.black,
          fit: FijkFit.cover,
          player: player,
          panelBuilder: (
            FijkPlayer player,
            FijkData data,
            BuildContext context,
            Size viewSize,
            Rect texturePos,
          ) {
            /// 使用自定义的布局
            /// 精简模式，可不传递onChangeVideo
            return CustomFijkPanel(
                player: player,
                viewSize: viewSize,
                texturePos: texturePos,
                pageContent: context,
                // 标题 当前页面顶部的标题部分
                playerTitle: widget.watchEntity.info.title,
                // 当前视频源tabIndex
                curTabIdx: _curTabIdx,
                // 当前视频源activeIndex
                curActiveIdx: _curActiveIdx,
                // 显示的配置
                showConfig: vCfg,
                // json格式化后的视频数据
                videoFormat: _videoSource,
                // createConList: _createTabConList(widget.watchEntity.episode)
                createConList: EpisodeScreen(
                    watchEntity: widget.watchEntity,
                    videoIndex: _videoIndex,
                    loading: _loading,
                    containerHeight: 500,
                    itemWidth: 160,
                    itemHeight: 110,
                    direction: false,
                    onTap: (index) async {
                      if (index == _videoIndex || _loading) {
                        return;
                      }
                      setState(() {
                        _loading = true;
                        _videoIndex = index;
                      });
                      WatchEntity data = await getEpisodeData(
                          widget.watchEntity.episode[index].htmlUrl);
                      playerChange(data.videoData.video[0].list[0].url);
                      context.read<WatchState>().setTitle(data.info.shareTitle);
                      setState(() {
                        _loading = false;
                      });
                    }));
          },
        ),
        BriefScreen(watchEntity: widget.watchEntity),
        EpisodeScreen(
            watchEntity: widget.watchEntity,
            videoIndex: _videoIndex,
            loading: _loading,
            containerHeight: 120,
            itemWidth: 160,
            itemHeight: 90,
            direction: true,
            onTap: (index) async {
              if (index == _videoIndex || _loading) {
                return;
              }
              setState(() {
                _loading = true;
                _videoIndex = index;
              });
              WatchEntity data = await getEpisodeData(
                  widget.watchEntity.episode[index].htmlUrl);
              playerChange(data.videoData.video[0].list[0].url);
              context.read<WatchState>().setTitle(data.info.shareTitle);
              setState(() {
                _loading = false;
              });
            }),
      ],
    );
  }

  Widget _createTabConList(List<WatchEpisode> episodeList) {
    ListView episodeData = ListView.separated(
        itemCount: episodeList.length,
        separatorBuilder: (BuildContext context, int index) => Container(
              height: 20.0,
            ),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Container(
            child: Row(
              children: [
                Stack(children: [
                  EpisodePhoto(
                    width: 160,
                    height: 90,
                    imgUrl: episodeList[index].imgUrl,
                    selector: false,
                  ),
                  // loadingCover(160, 90),
                ]),
                Expanded(
                    child: Container(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(episodeList[index].title)))
              ],
            ),
          );
        });
    return Container(color: Color.fromRGBO(0, 0, 0, 0.5), child: episodeData);
  }

  getEpisodeData(htmlUrl) async {
    var data = await getWatchData(htmlUrl);
    WatchEntity watchEntity = WatchEntity.fromJson(data);

    return watchEntity;
  }
}
