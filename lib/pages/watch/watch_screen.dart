import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/entity/watch_entity.dart';
import 'package:hanime/pages/watch/video_screen.dart';
import 'package:hanime/services/watch_services.dart';
import 'package:hanime/utils/logUtil.dart';

import 'episode.dart';

class WatchScreen extends StatefulWidget {
  final String htmlUrl;

  WatchScreen({Key? key, required this.htmlUrl}) : super(key: key);

  @override
  _WatchScreenState createState() => _WatchScreenState();
}

class _WatchScreenState extends State<WatchScreen> {
  var _futureBuilderFuture;
  var _videoIndex;
  var _title;

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
              Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _title == null ? watchEntity.info.shareTitle : _title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Container(
                      child: ExpandableText(
                        watchEntity.info.description,
                        animation: true,
                        prefixText: watchEntity.info.title,
                        prefixStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.orange),
                        expandText: '顯示完整資訊',
                        collapseText: '只顯示部分資訊',
                        maxLines: 3,
                        linkColor: Colors.cyan,
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Wrap(
                          children: _buildTagWidget(watchEntity.tagList),
                          spacing: 10,
                          runSpacing: 10,
                        )),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                color: Color(0x5757571C),
                height: 100,
                margin: EdgeInsets.only(top: 15),
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ClipOval(
                          //圆形头像
                          child: Image.network(
                            watchEntity.info.imgUrl,
                            // 'https://pic2.zhimg.com/v2-639b49f2f6578eabddc458b84eb3c6a1.jpg',
                            fit: BoxFit.cover,
                            width: 70.0,
                            height: 70.0,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(watchEntity.info.title),
                              Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Text(watchEntity.info.countTitle),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 110,
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: ListView.separated(
                    shrinkWrap: true,
                    controller: ScrollController(initialScrollOffset: 300),
                    scrollDirection: Axis.horizontal,
                    itemCount: watchEntity.videoList.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        VerticalDivider(
                          width: 20.0,
                          // color: Color(0xFFFFFFFF),
                        ),
                    itemBuilder: (BuildContext context, int index) {
                      return Episode(
                        videoList: watchEntity.videoList[index],
                        selector: _videoIndex == null
                            ? watchEntity.info.videoIndex == index.toString()
                            : _videoIndex == index,
                        onTap: () async {
                          WatchEntity data = await getEpisodeData(
                              watchEntity.videoList[index].htmlUrl);
                          videoScreenKey.currentState!.playerChange(
                              data.videoData.video[0].list[0].url);
                          setState(() {
                            _videoIndex = index;
                            _title = data.info.shareTitle;
                          });
                        },
                      );
                    }),
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
