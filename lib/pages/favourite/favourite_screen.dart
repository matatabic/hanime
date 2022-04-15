import 'package:drag_and_drop_lists/drag_and_drop_list_expansion.dart';
import 'package:drag_and_drop_lists/drag_and_drop_list_interface.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:hanime/providers/favourite_state.dart';
import 'package:hanime/utils/logUtil.dart';
import 'package:provider/provider.dart';

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

class _ListTileExample extends State<ExpansionTileExample> {
  late List<InnerList> _lists;
  List<Favourite> _favList = [];
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      List<Favourite> favList =
          Provider.of<FavouriteState>(context, listen: false).favList;
      _favList = favList;
    });

    super.initState();

    _lists = List.generate(10, (outerIndex) {
      return InnerList(
        name: outerIndex.toString(),
        children: List.generate(6, (innerIndex) => '$outerIndex.$innerIndex'),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return DragAndDropLists(
      children: _favList
          .map((v) => _buildList(v) as DragAndDropListInterface)
          .toList(),
      // children: [_favList.map((v) => _buildList(1)).toList()],
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
    );
  }

  _buildList(Favourite fav) {
    LogUtil.d(12421412312);
    // var innerList = _favList[0];

    return DragAndDropListExpansion(
      title: Text('List ${fav.name}'),
      // subtitle: Text('Subtitle ${innerList.name}'),
      leading: Icon(Icons.ac_unit),
      // children: List.generate(innerList.children.length,
      //     (index) => _buildItem(innerList.children[index])),
      children:
          fav.children.map((v) => _buildItem(v) as DragAndDropItem).toList(),
      listKey: ObjectKey(fav),
    );
  }

  _buildItem(Anime anime) {
    return DragAndDropItem(
      child: ListTile(
        title: Text(anime.title),
      ),
    );
  }

  _onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    print("_onItemReorder");
    setState(() {
      // var movedItem = _lists[oldListIndex].children.removeAt(oldItemIndex);
      // _lists[newListIndex].children.insert(newItemIndex, movedItem);
    });
  }

  _onListReorder(int oldListIndex, int newListIndex) {
    print('oldListIndex: $oldListIndex, newListIndex: $newListIndex');
    setState(() {
      // var movedList = _lists.removeAt(oldListIndex);
      // _lists.insert(newListIndex, movedList);
    });
  }
}
