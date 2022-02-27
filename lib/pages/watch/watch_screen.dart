import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/entity/watch_entity.dart';
import 'package:hanime/pages/watch/video_screen.dart';
import 'package:hanime/providers/watch_state.dart';
import 'package:hanime/services/watch_services.dart';
import 'package:provider/src/provider.dart';

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
    bool loading = context.watch<WatchState>().loading;

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
                    if (index == _videoIndex || loading) {
                      return;
                    }
                    context.read<WatchState>().setLoading(true);
                    setState(() {
                      _videoIndex = index;
                    });
                    WatchEntity data = await getEpisodeData(
                        watchEntity.videoList[index].htmlUrl);
                    videoScreenKey.currentState!
                        .playerChange(data.videoData.video[0].list[0].url);
                    setState(() {
                      _shareTitle = data.info.shareTitle;
                    });
                  }),
              BriefScreen(
                watchEntity: watchEntity,
                title: _shareTitle == null
                    ? watchEntity.info.shareTitle
                    : _shareTitle,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: watchEntity.commendList.length,
                    //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        //横轴元素个数
                        crossAxisCount: 3,
                        //纵轴间距
                        mainAxisSpacing: 5.0,
                        //横轴间距
                        crossAxisSpacing: 5.0,
                        //子组件宽高长度比例
                        childAspectRatio: 90 / 160),
                    itemBuilder: (BuildContext context, int index) {
                      //Widget Function(BuildContext context, int index)
                      return getItemContainer(watchEntity.commendList[index]);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getItemContainer(WatchCommendList item) {
    return Container(
      width: 50.0,
      height: 50.0,
      alignment: Alignment.center,
      child: Text(
        item.title,
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
      color: Colors.blue,
    );
  }
}
