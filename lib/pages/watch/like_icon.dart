import 'package:flutter/material.dart';
import 'package:hanime/common/LikeButton.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/common/widget/Model.dart';
import 'package:hanime/common/widget/Popup.dart';
import 'package:hanime/entity/favourite_entity.dart';
import 'package:hanime/entity/watch_entity.dart';
import 'package:hanime/providers/favourite_model.dart';
import 'package:provider/provider.dart';

class LikeIcon extends StatefulWidget {
  final WatchInfo info;

  LikeIcon({Key? key, required this.info}) : super(key: key);

  @override
  _LikeIconState createState() => _LikeIconState();
}

class _LikeIconState extends State<LikeIcon> {
  ///给获取详细信息的widget设置一个key
  GlobalKey iconKey = new GlobalKey();

  ///获取位置，给后续弹窗设置位置
  late Offset iconOffset;

  ///获取size 后续计算弹出位置
  late Size iconSize;

  ///接受弹窗类构造成功传递来的关闭参数
  late Function closeModel;

  // bool isLiked = false;

  bool isPanel = false;

  @override
  void initState() {
    // WidgetsBinding.instance!.addPostFrameCallback((duration) {
    //   ///通过key获取到widget的位置
    //   // print("通过key获取到widget的位置");
    //   List<FavouriteEntity> favouriteList =
    //       Provider.of<FavouriteModel>(context, listen: false).favouriteList;
    //   setState(() {
    //     isLiked = favouriteList.any((element) => element.children
    //         .any((element) => element.htmlUrl == widget.info.htmlUrl));
    //   });
    // });

    super.initState();
  }

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
    final favouriteList = context.watch<FavouriteModel>().favouriteList;
    bool isLiked = favouriteList.any((element) => element.children
        .any((element) => element.htmlUrl == widget.info.htmlUrl));
    return LikeButton(
      key: iconKey,
      isPanel: isPanel,
      onTap: (bool isLike) async {
        if (isLike) {
          Provider.of<FavouriteModel>(context, listen: false)
              .removeItemByHtmlUrl(widget.info.htmlUrl);
          // setState(() {
          //   isLiked = false;
          // });
        } else {
          showModel(context);
        }
        return null;
      },
      isLiked: isLiked,
      size: Adapt.px(60),
      // width: Adapt.px(60),
      // height: Adapt.px(60),
    );
  }

  ///播放动画
  void showModel(BuildContext context) {
    /// 设置传入弹窗的高宽
    final favouriteList =
        Provider.of<FavouriteModel>(context, listen: false).favouriteList;
    // final favouriteList = context.watch<FavouriteModel>().favouriteList;
    double _width = Adapt.px(260);
    double _height = Adapt.px(60 + favouriteList.length * 110);

    Navigator.push(
      context,
      Popup(
        child: Model(
          left: iconOffset.dx - _width + iconSize.width / 0.8,
          top: iconOffset.dy + iconSize.height / 3,
          offset: Offset(_width / 2, -_height / 2),
          child: Container(
            width: _width,
            height: _height,
            child: buildMenu(favouriteList, favouriteList.length * 110),
          ),
          fun: (close) {
            closeModel = close;
          },
        ),
      ),
    );
  }

  ///构造传入的widget
  Widget buildMenu(List<FavouriteEntity> favList, itemHeight) {
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
              width: Adapt.px(260),
              height: Adapt.px(itemHeight),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Adapt.px(20)),
                color: Color.fromRGBO(46, 53, 61, 1),
              ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: favList
                    .map<Widget>((item) => Expanded(
                          flex: 1,
                          child: InkWell(
                            child: Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              child: Text(
                                item.name,
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: Adapt.px(28),
                                ),
                              ),
                            ),
                            onTap: () async {
                              print(widget.info.htmlUrl);
                              print('这是点击了选项${item.name}');
                              context.read<FavouriteModel>().saveAnime(
                                  FavouriteChildren.fromJson({
                                    "imageUrl": widget.info.imgUrl,
                                    "htmlUrl": widget.info.htmlUrl,
                                    "title": widget.info.title
                                  }),
                                  item);
                              isPanel = true;
                              // setState(() {
                              //   isLiked = !isLiked;
                              // });
                              await closeModel();
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
