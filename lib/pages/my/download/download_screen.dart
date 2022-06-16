import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/common/common_image.dart';
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

  // late List<DragAndDropList> _contents;
  List<DownloadEntity> _downloadList = [];

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      List<DownloadEntity> downloadList =
          Provider.of<DownloadState>(context, listen: false).downloadList;
      print("获取数据");
      setState(() {
        _downloadList = downloadList;
      });
    });
    print("initState");
    super.initState();
  }

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

  List<DragAndDropList> _buildItem(List<DownloadEntity> downloadEntity) {
    return [
      DragAndDropList(
          children: downloadEntity
              .map((item) => DragAndDropItem(
                  child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: Adapt.px(10), horizontal: Adapt.px(10)),
                      color: Color.fromRGBO(58, 60, 63, 1),
                      height: Adapt.px(220),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              // Navigator.of(context).push(NoAnimRouter(
                              //   HeroPhotoViewRouteWrapper(
                              //     randomNum: randomTag,
                              //     minScale: 1.0,
                              //     maxScale: 1.8,
                              //     imageProvider: NetworkImage(anime.imageUrl),
                              //   ),
                              // ));
                            },
                            child: ClipOval(
                              child: Container(
                                width: Adapt.px(140),
                                height: Adapt.px(140),
                                child: CommonImages(
                                  imgUrl: item.imageUrl,
                                ),
                              ),
                            ),
                          ),
                          // Expanded(
                          //   child: Container(
                          //       height: Adapt.px(200),
                          //     color: Colors.red,
                          //     padding: EdgeInsets.only(left: Adapt.px(20)),
                          //     child: Text(item.title,
                          //         style: TextStyle(
                          //             fontSize: Adapt.px(30),
                          //             fontWeight: FontWeight.bold,
                          //             color: Colors.white))),
                          // ),
                          Expanded(
                              child: Column(
                            children: [
                              Container(
                                  height: Adapt.px(200),
                                  color: Colors.red,
                                  padding: EdgeInsets.only(left: Adapt.px(20)),
                                  child: Text(item.title,
                                      style: TextStyle(
                                          fontSize: Adapt.px(30),
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white))),
                            ],
                          ))
                        ],
                      ))))
              .toList())

      // DragAndDropList(children:
      //   DragAndDropItem(
      //     child: Container(
      //       height: 200,
      //       child: Text('.1'),
      //     ),
      //   ),
      //   DragAndDropItem(
      //     child: Container(
      //       height: 200,
      //       child: Text('.1'),
      //     ),
      //   ),
      //   DragAndDropItem(
      //     child: Text('.1'),
      //   )
      // ]),
      // DragAndDropList(children: [
      //   DragAndDropItem(
      //     child: Text('.2'),
      //   )
      // ]),
      // DragAndDropList(children: [
      //   DragAndDropItem(
      //     child: Text('.3'),
      //   )
      // ])
    ];
  }

  _onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {}

  _onListReorder(int oldListIndex, int newListIndex) {}
}
