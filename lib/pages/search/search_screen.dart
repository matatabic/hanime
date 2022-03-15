import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/common_image.dart';
import 'package:hanime/common/modal_bottom_route.dart';
import 'package:hanime/entity/search_entity.dart';
import 'package:hanime/pages/search/search_engine_screen.dart';
import 'package:hanime/pages/watch/watch_screen.dart';
import 'package:hanime/services/search_services.dart';

import 'search_menu_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
        if (snapshot.hasError) {
          return Center(
              child: MaterialButton(
            color: Colors.blue,
            textColor: Colors.white,
            child: Text('网络异常,点击重新加载'),
            onPressed: () {
              setState(() {
                _futureBuilderFuture = loadData();
              });
            },
          ));
          // return Text('Error: ${snapshot.error}');
        } else {
          return _createWidget(context, snapshot);
        }
    }
  }

  Widget _createWidget(BuildContext context, AsyncSnapshot snapshot) {
    SearchEntity searchEntity = snapshot.data;

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          SearchEngineScreen(),
          SearchMenuScreen(
              loadData: () => {
                    setState(() {
                      _futureBuilderFuture = loadData();
                    })
                  }),
          GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 0),
              physics: NeverScrollableScrollPhysics(),
              itemCount: searchEntity.video.length,
              //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //横轴元素个数
                  crossAxisCount: 2,
                  //纵轴间距
                  mainAxisSpacing: 5.0,
                  //横轴间距
                  crossAxisSpacing: 5.0,
                  //子组件宽高长度比例
                  childAspectRatio: 1.1),
              itemBuilder: (BuildContext context, int index) {
                return getItemContainer(searchEntity.video[index]);
              }),
        ],
      ),
    );
  }

  Widget getItemContainer(SearchVideo item) {
    return InkWell(
        onTap: () {
          Navigator.push(context,
              Right2LeftRouter(child: WatchScreen(htmlUrl: item.htmlUrl)));
        },
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              flex: 5,
              child: Stack(
                alignment: Alignment(0.9, 0.9),
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
                      item.duration,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(1.5, 1.5),
                            blurRadius: 3.5,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 2,
                child: Center(
                  child: Container(
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
                ))
          ],
        ));
  }

  initState() {
    super.initState();
    _futureBuilderFuture = loadData();
  }

  Future loadData() async {
    var data = await getSearchData();
    SearchEntity searchEntity = SearchEntity.fromJson(data);

    return searchEntity;
  }
}
