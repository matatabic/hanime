import 'package:flutter/material.dart';
import 'package:hanime/common/like_button_widget/Model.dart';
import 'package:hanime/common/like_button_widget/Popup.dart';
import 'package:hanime/common/like_button_widget/like_button.dart';
import 'package:hanime/entity/favourite_entity.dart';
import 'package:hanime/entity/watch_entity.dart';
import 'package:hanime/providers/favourite_model.dart';
import 'package:hanime/utils/utils.dart';
import 'package:provider/provider.dart';

class LikeWidget extends StatefulWidget {
  final WatchInfo info;
  final List<WatchEpisode> episodeList;
  final ScrollController controller;

  LikeWidget(
      {Key? key,
      required this.info,
      required this.controller,
      required this.episodeList})
      : super(key: key);

  @override
  _LikeIconState createState() => _LikeIconState();
}

class _LikeIconState extends State<LikeWidget> {
  ///给获取详细信息的widget设置一个key
  GlobalKey iconKey = new GlobalKey();

  ///获取位置，给后续弹窗设置位置
  late Offset iconOffset;

  ///获取size 后续计算弹出位置
  late Size iconSize;

  ///接受弹窗类构造成功传递来的关闭参数
  late Function closeModel;

  bool isPanel = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.controller.addListener(() {
      Utils.debounce(() {
        setState(() {});
      }, durationTime: 300);
    });
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
    bool isLiked =
        context.read<FavouriteModel>().isFavouriteAnime(widget.info.htmlUrl);

    return LikeButton(
      key: iconKey,
      isPanel: isPanel,
      onTap: (bool isLike) async {
        if (isLike) {
          // context
          //     .read<FavouriteModel>()
          //     .removeItemByHtmlUrl(widget.info.htmlUrl);
          // Provider.of<FavouriteModel>(context, listen: false)
          //     .removeItemByHtmlUrl(widget.info.htmlUrl);
        } else {
          bool isFavouriteEpisode = context
              .read<FavouriteModel>()
              .isFavouriteEpisode(widget.episodeList, widget.info);
          if (isFavouriteEpisode) {
            context.read<FavouriteModel>().addAnime(widget.info);
            print("已经收藏过了");
          } else {
            print("没有收藏过");
            context.read<FavouriteModel>().addAnimeByFavIndex(widget.info, 0);
          }
          // showModel();
        }
        return null;
      },
      isLiked: isLiked,
      size: 30,
    );
  }

  ///播放动画
  void showModel() {
    /// 设置传入弹窗的高宽
    final favouriteList =
        Provider.of<FavouriteModel>(context, listen: false).favouriteList;
    double _width = 130;
    double _height = 30 + favouriteList.length * 55;

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
            child: buildMenu(favouriteList, favouriteList.length * 55),
          ),
          fun: (close) {
            closeModel = close;
          },
        ),
      ),
    );
  }

  ///构造传入的widget
  Widget buildMenu(List<FavouriteEntity> favList, double itemHeight) {
    return Container(
      child: Stack(
        children: [
          Positioned(
            right: 5,
            top: 15,
            child: Container(
              width: 20,
              height: 20,
              transform: Matrix4.rotationZ(45 * 3.14 / 180),
              decoration: BoxDecoration(
                color: Color.fromRGBO(46, 53, 61, 1),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),

          ///菜单内容
          Positioned(
            bottom: 0,
            child: Container(
              width: 130,
              height: itemHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromRGBO(46, 53, 61, 1),
              ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: favList
                    .asMap()
                    .map((index, element) => MapEntry(
                        index,
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            customBorder: StadiumBorder(),
                            child: Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              child: Text(
                                element.name,
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            onTap: () async {
                              context
                                  .read<FavouriteModel>()
                                  .addAnimeByFavIndex(widget.info, index);
                              isPanel = true;
                              await closeModel();
                            },
                          ),
                        )))
                    .values
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
