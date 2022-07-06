import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hanime/entity/download_entity.dart';
import 'package:hanime/pages/my/download/download_item.dart';
import 'package:hanime/pages/watch/watch_screen.dart';
import 'package:hanime/providers/download_model.dart';
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

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final downloadList = context.watch<DownloadModel>().downloadList;
    // List<DownloadEntity> currentDynamic =
    //     context.select<DownloadModel, List<DownloadEntity>>(
    //         (dynamicDetail) => dynamicDetail.downloadList);
    return Scaffold(
      body: DragAndDropLists(
        contentsWhenEmpty: Center(
          child: Text(
            '暂无下载',
            textScaleFactor: 1.5,
          ),
        ),
        children: downloadList.length > 0 ? _buildItem(downloadList) : [],
        onItemReorder: _onItemReorder,
        onListReorder: _onListReorder,
      ),
    );
  }

  List<DragAndDropList> _buildItem(List<DownloadEntity> downloadEntity) {
    return [
      DragAndDropList(
          children: downloadEntity
              .map((item) => DragAndDropItem(
                  child: Slidable(
                      key: const ValueKey(1),
                      startActionPane: ActionPane(
                        motion: ScrollMotion(),
                        children: [
                          SlidableAction(
                            flex: 1,
                            onPressed: (BuildContext context) {
                              context
                                  .read<DownloadModel>()
                                  .removeItem(item.htmlUrl);
                            },
                            backgroundColor: Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: '删除',
                          )
                        ],
                      ),
                      child: InkWell(
                          onTap: () async {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        WatchScreen(htmlUrl: item.htmlUrl)));
                          },
                          child: DownloadItem(downloadEntity: item)))))
              .toList())
    ];
  }

  _onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {}

  _onListReorder(int oldListIndex, int newListIndex) {}
}

class FrontCover extends StatelessWidget {
  const FrontCover({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
