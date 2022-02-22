import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/fijkplayer_skin/fijkplayer_skin.dart';
import 'package:hanime/common/fijkplayer_skin/schema.dart'
    show VideoSourceFormat;
import 'package:hanime/entity/watch_entity.dart';
import 'package:hanime/utils/logUtil.dart';

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
  WatchEntity data;

  VideoScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen>
    with TickerProviderStateMixin {
  final FijkPlayer player = FijkPlayer();

  VideoSourceFormat? _videoSourceTabs;

  int _curTabIdx = 0;
  int _curActiveIdx = 0;

  ShowConfigAbs vCfg = PlayerShowConfig();

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // LogUtil.d(widget.videoData);
    // setState(() {
    //   videoList = widget.videoData;
    // });
    // 格式化json转对象
    print("JJJ");
    LogUtil.d(widget.data.videoData);
    _videoSourceTabs =
        VideoSourceFormat.fromJson(widget.data.videoData.toJson());
    // 这句不能省，必须有
    speed = 1.0;
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
              playerTitle: widget.data.info.title,
              // 当前视频源tabIndex
              curTabIdx: _curTabIdx,
              // 当前视频源activeIndex
              curActiveIdx: _curActiveIdx,
              // 显示的配置
              showConfig: vCfg,
              // json格式化后的视频数据
              videoFormat: _videoSourceTabs,
            );
          },
        ),
      ],
    );
  }
}
