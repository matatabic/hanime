import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/common/fijkplayer_skin/fijkplayer_skin.dart';
import 'package:hanime/common/fijkplayer_skin/schema.dart'
    show VideoSourceFormat;
import 'package:hanime/entity/watch_entity.dart';
import 'package:hanime/providers/watch_state.dart';
import 'package:hanime/services/watch_services.dart';
import 'package:provider/src/provider.dart';

import 'brief_screen.dart';
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
  final WatchEntity watchEntity;
  final FijkPlayer player;

  VideoScreen({Key? key, required this.watchEntity, required this.player})
      : super(key: key);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen>
    with TickerProviderStateMixin {
  // final FijkPlayer player = FijkPlayer();

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
    widget.player.release();
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
    if (widget.player.value.state == FijkState.completed) {
      await widget.player.stop();
    }

    await widget.player.reset().then((_) async {
      widget.player.setDataSource(url, autoPlay: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FijkView(
          height: Adapt.px(520),
          color: Colors.black,
          fit: FijkFit.cover,
          player: widget.player,
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
                    // containerHeight: 1000,
                    itemWidth: 320,
                    itemHeight: 220,
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
            containerHeight: 250,
            itemWidth: 320,
            itemHeight: 165,
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

  getEpisodeData(htmlUrl) async {
    var data = await getWatchData(htmlUrl);
    WatchEntity watchEntity = WatchEntity.fromJson(data);

    return watchEntity;
  }
}
