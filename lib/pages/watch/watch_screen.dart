import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/entity/watch_entity.dart';
import 'package:hanime/pages/watch/video_screen.dart';
import 'package:hanime/services/watch_services.dart';

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
  bool _isExpanded = false;
  var _futureBuilderFuture;

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
    // LogUtil.d(json.encode(data));
    // /*将Json转成实体类*/
    WatchEntity watchEntity = WatchEntity.fromJson(data);
    // LogUtil.d(newsBean);

    return watchEntity;
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
                data: watchEntity,
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      watchEntity.info.shareTitle,
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
                          spacing: 25,
                          runSpacing: 10,
                        )),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Container(
                        color: Colors.red,
                        height: 100,
                        child: Center(
                          child: Text("123"),
                        ),
                      ),
                    ),
                    ExpansionPanelList(
                      // 点击折叠按钮实现面板的伸缩
                      expansionCallback: (int panelIndex, bool isExpanded) {
                        setState(() {
                          _isExpanded = !isExpanded;
                        });
                      },
                      children: [
                        ExpansionPanel(
                          headerBuilder:
                              (BuildContext context, bool isExpanded) {
                            return Container(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                'Panel A',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            );
                          },
                          body: new Center(
                            child: new Column(
                              children: <Widget>[
                                Container(
                                  width: 300.0,
                                  height: 200.0,
                                  color: Colors.blue,
                                ),
                                Container(
                                  width: 300.0,
                                  height: 200.0,
                                  color: Colors.yellow,
                                ),
                                Container(
                                  width: 300.0,
                                  height: 200.0,
                                  color: Colors.pink,
                                ),
                                Container(
                                  width: 300.0,
                                  height: 200.0,
                                  color: Colors.blue,
                                ),
                                Container(
                                  width: 300.0,
                                  height: 200.0,
                                  color: Colors.yellow,
                                ),
                                Container(
                                  width: 300.0,
                                  height: 200.0,
                                  color: Colors.pink,
                                ),
                                Container(
                                  width: 300.0,
                                  height: 200.0,
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                          ),
                          isExpanded: _isExpanded, // 设置面板的状态，true展开，false折叠
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
