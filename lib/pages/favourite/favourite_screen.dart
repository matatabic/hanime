import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/common/drag_and_drop_lists/drag_and_drop_list_interface.dart';
import 'package:hanime/common/drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:hanime/pages/favourite/favourite_item.dart';
import 'package:hanime/providers/favourite_state.dart';
import 'package:provider/provider.dart';
import 'package:shake_animation_widget/shake_animation_widget.dart';

class ExpansionTileExample extends StatefulWidget {
  ExpansionTileExample({Key? key}) : super(key: key);

  @override
  _ListTileExample createState() => _ListTileExample();
}

class InnerList {
  final String name;
  List<String> children;
  InnerList({required this.name, required this.children});
}

class _ListTileExample extends State<ExpansionTileExample>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List<Favourite> _favouriteList = [];
  bool _deleteMode = false;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      List<Favourite> favouriteList =
          Provider.of<FavouriteState>(context, listen: false).favouriteList;
      _favouriteList = favouriteList;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  labelStyle: TextStyle(fontSize: 18.0),
                  onTap: () => _chooseTextDialog(context)),
              SpeedDialChild(
                child: Icon(Icons.brush),
                backgroundColor: Colors.orange,
                label: '删除收藏夹',
                labelStyle: TextStyle(fontSize: 18.0),
                onTap: () => {
                  setState(() {
                    _deleteMode = true;
                  })
                },
              )
            ]),
      body: DragAndDropLists(
        children: _favouriteList
            .map((v) => _buildList(v) as DragAndDropListInterface)
            .toList(),
        // itemDraggingWidth: 100,
        onItemReorder: _onItemReorder,
        onListReorder: _onListReorder,
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

  _buildList(Favourite fav) {
    return DragAndDropListExpansion(
      canDrag: !_deleteMode,
      title: Text(fav.name),
      contentsWhenEmpty: Center(
        child: Text('暂无收藏'),
      ),
      // subtitle: Text('Subtitle '),
      leading: _deleteMode
          ? InkWell(
              onTap: () {
                Provider.of<FavouriteState>(context, listen: false)
                    .removeList(fav);
                setState(() {});
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
      children:
          fav.children.map((v) => _buildItem(v) as DragAndDropItem).toList(),
      listKey: ObjectKey(fav),
    );
  }

  _buildItem(Anime anime) {
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
                Provider.of<FavouriteState>(context, listen: false)
                    .removeItem(anime);
                // context.read()<Favourite>().removeItem(anime);
                setState(() {});
              },
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: '删除',
            )
          ],
        ),
        child: FavouriteItem(
          anime: anime,
        ),
      ),
    );
  }

  _onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    Provider.of<FavouriteState>(context, listen: false)
        .orderItem(oldItemIndex, oldListIndex, newItemIndex, newListIndex);
    setState(() {});
    // var movedItem =
    //     _favouriteList[oldListIndex].children.removeAt(oldItemIndex);
    // setState(() {
    //   _favouriteList[newListIndex].children.insert(newItemIndex, movedItem);
    // });
  }

  _onListReorder(int oldListIndex, int newListIndex) {
    Provider.of<FavouriteState>(context, listen: false)
        .orderList(oldListIndex, newListIndex);
    setState(() {});
    // var movedList = _favouriteList.removeAt(oldListIndex);
    // setState(() {
    //   _favouriteList.insert(newListIndex, movedList);
    // });
  }
}

Future<void> _chooseTextDialog(context) async {
  String name = "";
  showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("新建收藏夹"),
          content: Card(
            elevation: 0.0,
            child: Column(
              children: <Widget>[
                CupertinoTextField(
                  onChanged: (String text) => {name = text},
                  maxLength: 10,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('取消'),
            ),
            CupertinoDialogAction(
              onPressed: () {
                if (name.length > 0) {
                  Provider.of<FavouriteState>(context, listen: false)
                      .addList(name);
                }

                Navigator.pop(context);
              },
              child: Text('确定'),
            ),
          ],
        );
      });
}
