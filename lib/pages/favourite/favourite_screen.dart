import 'package:drag_and_drop_lists/drag_and_drop_list_expansion.dart';
import 'package:drag_and_drop_lists/drag_and_drop_list_interface.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:hanime/providers/favourite_state.dart';
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
    return Scaffold(
      floatingActionButton: SpeedDial(child: Icon(Icons.add), children: [
        SpeedDialChild(
            child: Icon(Icons.accessibility),
            backgroundColor: Colors.red,
            label: '第一个按钮',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => print('FIRST CHILD')),
        SpeedDialChild(
          child: Icon(Icons.brush),
          backgroundColor: Colors.orange,
          label: '第二个按钮',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => print('SECOND CHILD'),
        ),
        SpeedDialChild(
          child: Icon(Icons.keyboard_voice),
          backgroundColor: Colors.green,
          label: '第三个按钮',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => print('THIRD CHILD'),
        ),
      ]),
      body: DragAndDropLists(
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
      ),
    );
  }

  _buildList(Favourite fav) {
    return DragAndDropListExpansion(
      title: Text('List ${fav.name}'),
      // subtitle: Text('Subtitle ${innerList.name}'),
      // leading: Icon(Icons.ac_unit),
      // children: List.generate(innerList.children.length,
      //     (index) => _buildItem(innerList.children[index])),
      children:
          fav.children.map((v) => _buildItem(v) as DragAndDropItem).toList(),
      listKey: ObjectKey(fav),
    );
  }

  _buildItem(Anime anime) {
    return DragAndDropItem(
      child: Slidable(
        // Specify a key if the Slidable is dismissible.
        key: const ValueKey(1),

        // The start action pane is the one at the left or the top side.
        startActionPane: const ActionPane(
          // A motion is a widget used to control how the pane animates.
          motion: ScrollMotion(),

          // All actions are defined in the children parameter.
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              onPressed: doNothing,
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
            SlidableAction(
              onPressed: doNothing,
              backgroundColor: Color(0xFF21B7CA),
              foregroundColor: Colors.white,
              icon: Icons.share,
              label: 'Share',
            ),
          ],
        ),

        // The end action pane is the one at the right or the bottom side.
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(onDismissed: () {}),
          children: const [
            SlidableAction(
              // An action can be bigger than the others.
              flex: 2,
              onPressed: doNothing,
              backgroundColor: Color(0xFF7BC043),
              foregroundColor: Colors.white,
              icon: Icons.archive,
              label: 'Archive',
            ),
            SlidableAction(
              onPressed: doNothing,
              backgroundColor: Color(0xFF0392CF),
              foregroundColor: Colors.white,
              icon: Icons.save,
              label: 'Save',
            ),
          ],
        ),

        // The child of the Slidable is what the user sees when the
        // component is not dragged.
        child: const ListTile(title: Text('Slide me')),
      ),
    );
  }

  _onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    print("_onItemReorder");
    setState(() {
      // var movedItem = _lists[oldListIndex].children.removeAt(oldItemIndex);
      // _lists[newListIndex].children.insert(newItemIndex, movedItem);
      var movedItem = _favList[oldListIndex].children.removeAt(oldItemIndex);
      _favList[newListIndex].children.insert(newItemIndex, movedItem);
    });
  }

  _onListReorder(int oldListIndex, int newListIndex) {
    print('oldListIndex: $oldListIndex, newListIndex: $newListIndex');
    setState(() {
      // var movedList = _lists.removeAt(oldListIndex);
      // _lists.insert(newListIndex, movedList);
      var movedList = _favList.removeAt(oldListIndex);
      _favList.insert(newListIndex, movedList);
    });
  }
}

void doNothing(BuildContext context) {}
