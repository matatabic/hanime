// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class FavouriteScreen extends StatefulWidget {
//   const FavouriteScreen({Key? key}) : super(key: key);
//
//   @override
//   _FavouriteScreenState createState() => _FavouriteScreenState();
// }
//
// class _FavouriteScreenState extends State<FavouriteScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: DefaultTabController(
//           length: 2,
//           child: Scaffold(
//             appBar: TabBar(
//                 indicatorSize: TabBarIndicatorSize.label,
//                 indicatorColor: Colors.red,
//                 indicatorWeight: 3,
//                 tabs: [
//                   Tab(text: "测试1"),
//                   Tab(text: "测试2"),
//                 ]),
//             body: TabBarView(children: [
//               Icon(Icons.explore),
//               Icon(Icons.search),
//             ]),
//           )),
//     );
//   }
// }

import 'package:drag_and_drop_lists/drag_and_drop_list_expansion.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

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

  @override
  void initState() {
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
      children: List.generate(_lists.length, (index) => _buildList(index)),
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

  _buildList(int outerIndex) {
    var innerList = _lists[outerIndex];
    return DragAndDropListExpansion(
      title: Text('List ${innerList.name}'),
      // subtitle: Text('Subtitle ${innerList.name}'),
      leading: Icon(Icons.ac_unit),
      children: List.generate(innerList.children.length,
          (index) => _buildItem(innerList.children[index])),
      listKey: ObjectKey(innerList),
    );
  }

  _buildItem(String item) {
    return DragAndDropItem(
      child: ListTile(
        title: Text(item),
      ),
    );
  }

  _onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    print("_onItemReorder");
    setState(() {
      var movedItem = _lists[oldListIndex].children.removeAt(oldItemIndex);
      _lists[newListIndex].children.insert(newItemIndex, movedItem);
    });
  }

  _onListReorder(int oldListIndex, int newListIndex) {
    print('oldListIndex: $oldListIndex, newListIndex: $newListIndex');
    setState(() {
      var movedList = _lists.removeAt(oldListIndex);
      _lists.insert(newListIndex, movedList);
    });
  }
}
