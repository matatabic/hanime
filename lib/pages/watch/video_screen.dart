import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/common/fijkplayer_skin/fijkplayer_skin.dart';
import 'package:hanime/common/fijkplayer_skin/schema.dart'
    show VideoSourceFormat;
import 'package:hanime/entity/watch_entity.dart';
import 'package:hanime/services/watch_services.dart';

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
  bool bottomPro = false;
  @override
  bool stateAuto = true;
  @override
  bool isAutoPlay = false;
}

class VideoScreen extends StatefulWidget {
  final WatchEntity watchEntity;
  final VideoSourceFormat videoSource;
  final FijkPlayer player;
  final Widget episodeScreen;
  final Function(String url) playerChange;

  VideoScreen(
      {Key? key,
      required this.watchEntity,
      required this.videoSource,
      required this.player,
      required this.episodeScreen,
      required this.playerChange})
      : super(key: key);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen>
    with TickerProviderStateMixin {
  ShowConfigAbs vCfg = PlayerShowConfig();

  @override
  void dispose() {
    super.dispose();
    widget.player.removeListener(_playerValueListener);
    widget.player.release();
  }

  void _playerValueListener() {
    FijkValue value = widget.player.value;
    print(value);
  }

  @override
  void initState() {
    super.initState();
    // 格式化json转对象
    // _videoSource =
    //     VideoSourceFormat.fromJson(widget.watchEntity.videoData.toJson());
    // 这句不能省，必须有
    speed = 1.0;
    widget.player.addListener(_playerValueListener);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.videoSource);
    print("widget.videoSource");
    return Column(
      children: [
        FijkView(
          height: Adapt.px(520),
          color: Colors.black,
          cover: NetworkImage(widget.watchEntity.info.cover),
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
                curTabIdx: 0,
                // 当前视频源activeIndex
                curActiveIdx: 0,
                // 显示的配置
                showConfig: vCfg,
                // json格式化后的视频数据
                videoFormat: widget.videoSource,
                // createConList: _createTabConList(widget.watchEntity.episode)
                episodeScreen: widget.episodeScreen);
          },
        )
      ],
    );
  }

  getEpisodeData(htmlUrl) async {
    var data = await getWatchData(htmlUrl);
    WatchEntity watchEntity = WatchEntity.fromJson(data);

    return watchEntity;
  }
}
