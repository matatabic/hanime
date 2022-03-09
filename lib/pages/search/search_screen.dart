import 'dart:ui';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/common/common_image.dart';
import 'package:hanime/common/modal_bottom_route.dart';
import 'package:hanime/entity/search_entity.dart';
import 'package:hanime/pages/search/search_engine.dart';
import 'package:hanime/pages/watch/watch_screen.dart';
import 'package:hanime/services/search_services.dart';

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
          SearchEngine(),
          SearchNav(),
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
                  childAspectRatio: 4 / 3),
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

class SearchNav extends StatelessWidget {
  const SearchNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Adapt.px(150),
      padding: EdgeInsets.symmetric(horizontal: Adapt.px(20)),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ClipOval(
            child: Container(
              width: Adapt.px(100),
              height: Adapt.px(100),
              color: Color.fromRGBO(51, 51, 51, 1),
              child: InkWell(
                  onTap: () {
                    BotToast.showAttachedWidget(
                        // duration: Duration(seconds: 2),
                        target: Offset(0, 0),
                        verticalOffset: 0,
                        attachedBuilder: (void Function() cancelFunc) {
                          return Container(
                            width: 100,
                            height: 100,
                            color: Colors.blueGrey,
                          );
                        });
                  },
                  child: Icon(Icons.dashboard, size: Adapt.px(60))),
            ),
          ),
          ClipOval(
            child: Container(
              width: Adapt.px(100),
              height: Adapt.px(100),
              color: Color.fromRGBO(51, 51, 51, 1),
              child: Icon(Icons.loyalty, size: Adapt.px(60)),
            ),
          ),
          ClipOval(
            child: Container(
              width: Adapt.px(100),
              height: Adapt.px(100),
              color: Color.fromRGBO(51, 51, 51, 1),
              child: Icon(Icons.sort, size: Adapt.px(60)),
            ),
          ),
          ClipOval(
            child: Container(
              width: Adapt.px(100),
              height: Adapt.px(100),
              color: Color.fromRGBO(51, 51, 51, 1),
              child: Icon(Icons.business, size: Adapt.px(60)),
            ),
          ),
          ClipOval(
            child: Container(
              width: Adapt.px(100),
              height: Adapt.px(100),
              color: Color.fromRGBO(51, 51, 51, 1),
              child: Icon(Icons.date_range, size: Adapt.px(60)),
            ),
          ),
          ClipOval(
            child: Container(
              width: Adapt.px(100),
              height: Adapt.px(100),
              color: Color.fromRGBO(51, 51, 51, 1),
              child: Icon(Icons.update, size: 45),
            ),
          ),
        ],
      ),
    );
  }
}

void showAlertDialog(BackButtonBehavior backButtonBehavior,
    {VoidCallback? cancel,
    VoidCallback? confirm,
    VoidCallback? backgroundReturn,
    required double ww,
    required double hh}) {
  BotToast.showAttachedWidget(attachedBuilder: (void Function() cancelFunc) {
    return Container(width: 100, height: 100, color: Colors.red);
  });
  // BotToast.showAnimationWidget(
  //     clickClose: false,
  //     allowClick: false,
  //     onlyOne: true,
  //     crossPage: true,
  //     backButtonBehavior: backButtonBehavior,
  //     wrapToastAnimation: (controller, cancel, child) => Stack(
  //           children: <Widget>[
  //             GestureDetector(
  //               onTap: () {
  //                 cancel();
  //                 backgroundReturn?.call();
  //               },
  //               //The DecoratedBox here is very important,he will fill the entire parent component
  //               child: AnimatedBuilder(
  //                 builder: (_, child) => Opacity(
  //                   opacity: controller.value,
  //                   child: child,
  //                 ),
  //                 child: DecoratedBox(
  //                   decoration: BoxDecoration(color: Colors.blueGrey),
  //                   child: SizedBox.expand(),
  //                 ),
  //                 animation: controller,
  //               ),
  //             ),
  //             CustomOffsetAnimation(
  //               controller: controller,
  //               child: child,
  //             )
  //           ],
  //         ),
  //     toastBuilder: (cancelFunc) => Container(
  //         width: ww,
  //         height: hh,
  //         color: Colors.red,
  //         padding: const EdgeInsets.only(top: 0)),
  //     animationDuration: Duration(milliseconds: 300));
}

class CustomWidget extends StatefulWidget {
  @override
  _CustomWidgetState createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<CustomWidget> {
  BackButtonBehavior backButtonBehavior = BackButtonBehavior.none;

  @override
  Widget build(BuildContext context) {
    var ww = MediaQuery.of(context).size.width;
    var hh = MediaQuery.of(context).size.height -
        Adapt.px(110) -
        MediaQueryData.fromWindow(window).padding.top;
    return Scaffold(
      appBar: AppBar(
        title: const Text('CustomWidget'),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  showAlertDialog(backButtonBehavior, ww: ww, hh: hh);
                },
                child: const Text('customWidget'),
              ),
              Center(
                child: Text('BackButtonBehavior'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomOffsetAnimation extends StatefulWidget {
  final AnimationController controller;
  final Widget child;

  const CustomOffsetAnimation(
      {Key? key, required this.controller, required this.child})
      : super(key: key);

  @override
  _CustomOffsetAnimationState createState() => _CustomOffsetAnimationState();
}

class _CustomOffsetAnimationState extends State<CustomOffsetAnimation> {
  Tween<Offset>? tweenOffset;
  Tween<double>? tweenScale;

  Animation<double>? animation;

  @override
  void initState() {
    tweenOffset = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, 0.1),
    );
    tweenScale = Tween<double>(begin: 0, end: 1);
    animation =
        CurvedAnimation(parent: widget.controller, curve: Curves.decelerate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      child: widget.child,
      animation: widget.controller,
      builder: (BuildContext context, Widget? child) {
        return FractionalTranslation(
            translation: tweenOffset!.evaluate(animation!),
            child: ClipRect(
              child: Transform.scale(
                scale: tweenScale!.evaluate(animation!),
                child: Opacity(
                  child: child,
                  opacity: animation!.value,
                ),
              ),
            ));
      },
    );
  }
}
