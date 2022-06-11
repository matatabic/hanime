import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/entity/download_entity.dart';
import 'package:hanime/providers/download_state.dart';
import 'package:provider/provider.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({Key? key}) : super(key: key);

  @override
  _DownloadScreenState createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  bool _deleteMode = false;
  // late List<DragAndDropList> _contents;
  List<DownloadEntity> _downloadList = [];

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      List<DownloadEntity> downloadList =
          Provider.of<DownloadState>(context, listen: false).downloadList;
      _downloadList = downloadList;
    });

    super.initState();
  }

  List<DragAndDropList> _contents = List.generate(10, (index) {
    return DragAndDropList(children: [
      DragAndDropItem(
        canDrag: true,
        child: Text('$index.1'),
      ),
      DragAndDropItem(
        canDrag: true,
        child: Text('$index.99'),
      )
    ]);
  });

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: DragAndDropLists(
        children: _buildItem(_downloadList),
        onItemReorder: _onItemReorder,
        onListReorder: _onListReorder,
      ),
    );
  }

  List<DragAndDropList> _buildItem(List<DownloadEntity> anime) {
    return [
      DragAndDropList(children: [
        DragAndDropItem(
          child: Container(
            height: 200,
            child: Text('.1'),
          ),
        ),
        DragAndDropItem(
          child: Container(
            height: 200,
            child: Text('.1'),
          ),
        ),
        DragAndDropItem(
          child: Text('.1'),
        )
      ]),
      DragAndDropList(children: [
        DragAndDropItem(
          child: Text('.2'),
        )
      ]),
      DragAndDropList(children: [
        DragAndDropItem(
          child: Text('.3'),
        )
      ])
    ];
  }

  _onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      var movedItem = _contents[oldListIndex].children.removeAt(oldItemIndex);
      _contents[newListIndex].children.insert(newItemIndex, movedItem);
    });
  }

  _onListReorder(int oldListIndex, int newListIndex) {
    setState(() {
      var movedList = _contents.removeAt(oldListIndex);
      _contents.insert(newListIndex, movedList);
    });
  }
}
