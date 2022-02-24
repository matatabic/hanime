import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/entity/watch_entity.dart';
import 'package:hanime/pages/watch/video_screen.dart';
import 'package:hanime/services/watch_services.dart';
import 'package:hanime/utils/logUtil.dart';

import 'brief_screen.dart';
import 'episode_screen.dart';

class WatchScreen extends StatefulWidget {
  final String htmlUrl;

  WatchScreen({Key? key, required this.htmlUrl}) : super(key: key);

  @override
  _WatchScreenState createState() => _WatchScreenState();
}

class _WatchScreenState extends State<WatchScreen> {
  var _futureBuilderFuture;
  var _videoIndex;
  var _shareTitle;

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

  initState() {
    super.initState();
    _futureBuilderFuture = loadData();
  }

  Future loadData() async {
    var data = await getWatchData(widget.htmlUrl);
    WatchEntity watchEntity = WatchEntity.fromJson(data);
    LogUtil.d(watchEntity);
    return watchEntity;
  }

  getEpisodeData(htmlUrl) async {
    var data = await getWatchData(htmlUrl);
    WatchEntity watchEntity = WatchEntity.fromJson(data);

    return watchEntity;
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
        return _createListView(context, snapshot);
      // default:
      //   return Center();
    }
  }

  Widget _createListView(BuildContext context, AsyncSnapshot snapshot) {
    WatchEntity watchEntity = snapshot.data;
    return SafeArea(
      child: SizedBox.expand(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              VideoScreen(
                key: videoScreenKey,
                data: watchEntity,
              ),
              EpisodeScreen(
                  watchEntity: watchEntity,
                  videoIndex: _videoIndex,
                  onTap: (index) async {
                    WatchEntity data = await getEpisodeData(
                        watchEntity.videoList[index].htmlUrl);
                    videoScreenKey.currentState!
                        .playerChange(data.videoData.video[0].list[0].url);
                    setState(() {
                      _videoIndex = index;
                      _shareTitle = data.info.shareTitle;
                    });
                  }),
              BriefScreen(
                watchEntity: watchEntity,
                title: _shareTitle == null
                    ? watchEntity.info.shareTitle
                    : _shareTitle,
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTagWidget(tagList) {
    List<Widget> tagWidgetList = [];
    for (var item in tagList) {
      tagWidgetList.add(Container(
        padding: EdgeInsets.all(3.5),
        decoration: BoxDecoration(
            border: new Border.all(
          color: Colors.grey, //边框颜色
          width: 2.0, //边框粗细
        )),
        child: Text(
          item,
          style: TextStyle(fontSize: 17),
        ),
      ));
    }

    return tagWidgetList;
  }
}
