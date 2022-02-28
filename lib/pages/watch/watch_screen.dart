import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/common_image.dart';
import 'package:hanime/common/modal_bottom_route.dart';
import 'package:hanime/entity/watch_entity.dart';
import 'package:hanime/pages/watch/video_screen.dart';
import 'package:hanime/services/watch_services.dart';
import 'package:hanime/utils/logUtil.dart';

import 'brief_screen.dart';

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
    LogUtil.d(json.encode(data));
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
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              VideoScreen(
                watchEntity: watchEntity,
              ),
              // EpisodeScreen(
              //     watchEntity: watchEntity,
              //     videoIndex: _videoIndex,
              //     onTap: (index) async {
              //       if (index == _videoIndex || loading) {
              //         return;
              //       }
              //       context.read<WatchState>().setLoading(true);
              //       setState(() {
              //         _videoIndex = index;
              //       });
              //       WatchEntity data = await getEpisodeData(
              //           watchEntity.episode[index].htmlUrl);
              //       videoScreenKey.currentState!
              //           .playerChange(data.videoData.video[0].list[0].url);
              //       setState(() {
              //         _shareTitle = data.info.shareTitle;
              //       });
              //     }),
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
                    itemCount: watchEntity.commend.length,
                    //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        //横轴元素个数
                        crossAxisCount: watchEntity.commendCount,
                        //纵轴间距
                        mainAxisSpacing: 5.0,
                        //横轴间距
                        crossAxisSpacing: 5.0,
                        //子组件宽高长度比例
                        childAspectRatio:
                            watchEntity.commendCount == 3 ? 2 / 3 : 4 / 3),
                    itemBuilder: (BuildContext context, int index) {
                      return getItemContainer(watchEntity.commend[index]);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getItemContainer(WatchCommend item) {
    return InkWell(
        onTap: () {
          Navigator.push(
              context, Right2LeftRouter(child: WatchScreen(htmlUrl: item.url)));
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
}
