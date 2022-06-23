import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/common/common_image.dart';
import 'package:hanime/entity/download_entity.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

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
    // WidgetsBinding.instance!.addPostFrameCallback((_) {
    //   List<DownloadEntity> downloadList =
    //       Provider.of<DownloadModel>(context, listen: false).downloadList;
    //   print("获取数据");
    //   setState(() {
    //     _downloadList = downloadList;
    //   });
    // });
    // print("initState");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // List<DownloadEntity> _downloadList =
    //     Provider.of<DownloadState>(context).downloadList;
    // List<DownloadEntity> currentDynamic =
    //     context.select<DownloadModel, List<DownloadEntity>>(
    //         (dynamicDetail) => dynamicDetail.downloadList);
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
                            onTap: () {},
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
                          Expanded(
                              child: Flex(
                            direction: Axis.vertical,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  padding: EdgeInsets.only(left: Adapt.px(20)),
                                  child: Text(item.title,
                                      style: TextStyle(
                                          fontSize: Adapt.px(30),
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white))),
                              Padding(
                                padding: EdgeInsets.only(right: Adapt.px(20)),
                                child: LinearPercentIndicator(
                                  // width: 100,
                                  animation: true,
                                  lineHeight: Adapt.px(40),
                                  animationDuration: 1000,
                                  percent: item.progress,
                                  center: Text("${item.progress * 100}%"),
                                  linearStrokeCap: LinearStrokeCap.roundAll,
                                  progressColor: Colors.green,
                                ),
                              ),
                            ],
                          ))
                        ],
                      ))))
              .toList())
    ];
  }

  _onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {}

  _onListReorder(int oldListIndex, int newListIndex) {}
}
