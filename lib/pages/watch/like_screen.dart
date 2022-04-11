import 'package:flutter/material.dart';
import 'package:hanime/common/LikeButton.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/common/widget/Model.dart';
import 'package:hanime/common/widget/Popup.dart';
import 'package:hanime/providers/favourite_state.dart';
import 'package:provider/src/provider.dart';

class LikeScreen extends StatefulWidget {
  @override
  _LikeScreenState createState() => _LikeScreenState();
}

class _LikeScreenState extends State<LikeScreen> {
  ///给获取详细信息的widget设置一个key
  GlobalKey iconKey = new GlobalKey();
  List _list = ["默认收藏夹", "默认收藏夹", "默认收藏夹", "默认收藏夹", "默认收藏夹"];

  ///获取位置，给后续弹窗设置位置
  late Offset iconOffset;

  ///获取size 后续计算弹出位置
  late Size iconSize;

  ///接受弹窗类构造成功传递来的关闭参数
  late Function closeModel;

  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    ///等待widget初始化完成
    WidgetsBinding.instance!.addPostFrameCallback((duration) {
      ///通过key获取到widget的位置
      RenderBox box = iconKey.currentContext!.findRenderObject() as RenderBox;

      ///获取widget的高宽
      iconSize = box.size;

      ///获取位置
      iconOffset = box.localToGlobal(Offset.zero);
    });

    return Container(
        child: LikeButton(
      key: iconKey,
      onTap: (bool isLike) async {
        if (isLike) {
          setState(() {
            isLiked = false;
          });
        } else {
          showModel(context);
        }
        return null;
      },
      isLiked: isLiked,
      size: Adapt.px(60),
    ));
  }

  ///播放动画
  void showModel(BuildContext context) {
    /// 设置传入弹窗的高宽
    print(Provider.of<FavouriteState>(context, listen: false).favList);
    double _width = Adapt.px(260);
    double _height = Adapt.px(60 + _list.length * 110);

    Navigator.push(
      context,
      Popup(
        child: Model(
          left: iconOffset.dx - _width + iconSize.width / 0.8,
          top: iconOffset.dy + iconSize.height / 3,
          offset: Offset(_width / 2, -_height / 2),
          child: Container(
            // color: Colors.red,
            width: _width,
            height: _height,
            child: buildMenu(_list, _list.length * 110),
          ),
          fun: (close) {
            closeModel = close;
          },
        ),
      ),
    );
  }

  ///构造传入的widget
  Widget buildMenu(favList, addHeight) {
    print(addHeight);
    return Container(
      child: Stack(
        children: [
          Positioned(
            right: Adapt.px(10),
            top: Adapt.px(30),
            child: Container(
              width: Adapt.px(40),
              height: Adapt.px(40),
              transform: Matrix4.rotationZ(45 * 3.14 / 180),
              decoration: BoxDecoration(
                color: Color.fromRGBO(46, 53, 61, 1),
                borderRadius: BorderRadius.circular(Adapt.px(10)),
              ),
            ),
          ),

          ///菜单内容
          Positioned(
            bottom: 0,
            child: Container(
              // color: Colors.,
              // padding: EdgeInsets.only(left: 10),
              width: Adapt.px(260),
              height: Adapt.px(addHeight),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Adapt.px(20)),
                color: Color.fromRGBO(46, 53, 61, 1),
              ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: favList
                    .map<Widget>((e) => Expanded(
                          flex: 1,
                          child: InkWell(
                            child: Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              child: Text(
                                '这应该是选项',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: Adapt.px(28),
                                ),
                              ),
                            ),
                            onTap: () async {
                              print('这是点击了选项${e.toString()}');
                              // await Future.delayed(Duration(milliseconds: 500))
                              //     .then((value) => print('开始'));
                              setState(() {
                                isLiked = !isLiked;
                              });
                              // await closeModel();
                              print('结束');
                            },
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
