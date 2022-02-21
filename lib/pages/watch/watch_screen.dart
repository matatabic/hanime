import 'package:flutter/material.dart';
import 'package:hanime/entity/watch_entity.dart';
import 'package:hanime/pages/watch/video_screen.dart';
import 'package:hanime/services/watch_services.dart';
import 'package:hanime/utils/logUtil.dart';

class WatchScreen extends StatefulWidget {
  final String htmlUrl;
  WatchScreen({Key? key, required this.htmlUrl}) : super(key: key);

  @override
  _WatchScreenState createState() => _WatchScreenState();
}

class _WatchScreenState extends State<WatchScreen> {
  // Map<String, dynamic> info = {};
  // Map<String, List<Map<String, dynamic>>> video = {};
  // List<String> tagList = [];
  // List<String> commendList = [];
  var _futureBuilderFuture;

  @override
  Widget build(BuildContext context) {
    // print(data);
    // print(data.length);
    // if (data.length == 0) {
    //   return Center(
    //     child: Text("PPP"),
    //   );
    // }
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
    // LogUtil.d(json.encode(data));
    // WatchEntity newsBean = WatchEntity.fromJson(data);
    // LogUtil.d(json);
    // /*将Json转成实体类*/
    WatchEntity newsBean = WatchEntity.fromJson(data);
    // LogUtil.d(newsBean);
    // LogUtil.d(json.encode(data));
    return newsBean;
  }

  Widget _createListView(BuildContext context, AsyncSnapshot snapshot) {
    // List movies<WatchEntity> = snapshot.data;
    print("JJJ");
    WatchEntity newsBean = snapshot.data;
    LogUtil.d(newsBean.videoData);
    print("JJJ");
    return SizedBox.expand(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            VideoScreen(
              // data: newsBean,
              // info: snapshot.data['info'],
              videoData: newsBean.videoData,
              // videoLisaat: snapshot.data['videoData'],
            ),
            // Center(
            //   child: Text(snapshot.data['commendList'].length.toString()),
            // ),
          ],
        ),
        // child: VideoScreen(
        //   data: dataList,
        // ),
        // child: Center(
        //   child: Text(dataList.length.toString()),
        // ),
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
        return _createListView(context, snapshot);
      default:
        return Center();
    }
  }
}
