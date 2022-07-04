import 'package:drag_and_drop_lists/drag_and_drop_list_interface.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/common/custom_dialog.dart';
import 'package:hanime/entity/favourite_entity.dart';
import 'package:hanime/pages/watch/watch_screen.dart';
import 'package:hanime/providers/favourite_model.dart';
import 'package:provider/provider.dart';
import 'package:shake_animation_widget/shake_animation_widget.dart';

import 'favourite_item.dart';

class FavouriteScreen extends StatefulWidget {
  FavouriteScreen({Key? key}) : super(key: key);

  @override
  _FavouriteScreen createState() => _FavouriteScreen();
}

class _FavouriteScreen extends State<FavouriteScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  bool _deleteMode = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final favouriteList = context.watch<FavouriteModel>().favouriteList;

    return Scaffold(
      floatingActionButton: _deleteMode
          ? SpeedDial(
              onPress: () {
                setState(() {
                  _deleteMode = false;
                });
              },
              child: Icon(Icons.clear),
              backgroundColor: Colors.red,
            )
          : SpeedDial(child: Icon(Icons.add), children: [
              SpeedDialChild(
                  child: Icon(Icons.add),
                  backgroundColor: Colors.red,
                  label: '新建收藏夹',
                  labelStyle: TextStyle(fontSize: Adapt.px(38)),
                  onTap: () => CustomDialog.showTextDialog(
                      context,
                      "新建收藏夹",
                      (String content) => {
                            if (content.length > 0)
                              context.read<FavouriteModel>().addList(content),
                            Navigator.pop(context)
                          })),
              SpeedDialChild(
                child: Icon(Icons.brush),
                backgroundColor: Colors.orange,
                label: '删除收藏夹',
                labelStyle: TextStyle(fontSize: Adapt.px(38)),
                onTap: () => {
                  setState(() {
                    _deleteMode = true;
                  })
                },
              )
            ]),
      body: DragAndDropLists(
        children: favouriteList
            .map((v) => _buildList(v) as DragAndDropListInterface)
            .toList(),
        // itemDraggingWidth: 100,
        onItemReorder: _onItemReorder,
        onListReorder: _onListReorder,
        contentsWhenEmpty: Center(
          child: Text(
            '暂无收藏',
            textScaleFactor: 1.5,
          ),
        ),
        // listGhost is mandatory when using expansion tiles to prevent multiple widgets using the same globalkey
        listGhost: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 100.0),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(7.0),
              ),
              child: Icon(Icons.add_box),
            ),
          ),
        ),
      ),
    );
  }

  _buildList(FavouriteEntity favourite) {
    return DragAndDropListExpansion(
      canDrag: !_deleteMode,
      title: Text(favourite.name),
      contentsWhenEmpty: Center(
        child: Text('暂无影片'),
      ),
      leading: _deleteMode
          ? InkWell(
              onTap: () {
                CustomDialog.showDialog(
                    context,
                    "确认删除该收藏夹?",
                    (context) => {
                          Provider.of<FavouriteModel>(context, listen: false)
                              .removeList(favourite),
                          Navigator.pop(context)
                        });
              },
              child: ShakeAnimationWidget(
                  isForward: true,
                  shakeRange: 0.3,
                  child: Icon(Icons.delete,
                      size: Adapt.px(64), color: Colors.red)),
            )
          : Icon(
              Icons.folder,
              size: Adapt.px(64),
            ), // Icon(Icons.folder),
      children: favourite.children
          .map((v) => _buildItem(v) as DragAndDropItem)
          .toList(),
      listKey: ObjectKey(favourite),
    );
  }

  _buildItem(FavouriteChildren anime) {
    return DragAndDropItem(
      canDrag: !_deleteMode,
      feedbackWidget: Container(
        child: FavouriteItem(anime: anime, showBg: false),
      ),
      child: Slidable(
        key: const ValueKey(1),
        startActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (BuildContext context) {
                CustomDialog.showDialog(
                    context,
                    "确认删除该影片?",
                    (context) => {
                          context.read<FavouriteModel>().removeItem(anime),
                          Navigator.pop(context)
                        });
              },
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: '删除',
            )
          ],
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => WatchScreen(htmlUrl: anime.htmlUrl)));
          },
          child: FavouriteItem(
            anime: anime,
          ),
        ),
      ),
    );
  }

  _onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    context
        .read<FavouriteModel>()
        .orderItem(oldItemIndex, oldListIndex, newItemIndex, newListIndex);
  }

  _onListReorder(int oldListIndex, int newListIndex) {
    context.read<FavouriteModel>().orderList(oldListIndex, newListIndex);
  }
}
