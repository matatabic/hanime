import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/common/common_image.dart';
import 'package:hanime/entity/download_entity.dart';
import 'package:hanime/providers/download_model.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
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
    List<DownloadEntity> _downloadList =
        Provider.of<DownloadModel>(context).downloadList;
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
                          SizedBox(
                            width: Adapt.px(300),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: Adapt.px(200),
                                  child: CommonImages(
                                    imgUrl: item.imageUrl,
                                  ),
                                ),
                                LinearPercentIndicator(
                                  width: Adapt.px(300),
                                  animation: true,
                                  animateFromLastPercent: true,
                                  lineHeight: Adapt.px(200),
                                  animationDuration: 1000,
                                  percent: item.progress,
                                  padding: EdgeInsets.all(0),
                                  center: Text("${item.progress * 100}%"),
                                  linearStrokeCap: LinearStrokeCap.butt,
                                  backgroundColor: Colors.transparent,
                                  progressColor: Colors.red,
                                ),
                                IconButton(
                                  iconSize: Adapt.px(100),
                                  icon: Icon(Icons.cloud_download,
                                      color: Colors.white70),
                                  onPressed: () {},
                                )
                                // Material(
                                //   type: MaterialType.transparency,
                                //   child: InkWell(
                                //     onTap: () {
                                //       print("MaterialType");
                                //     },
                                //   ),
                                // )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                                padding: EdgeInsets.only(left: Adapt.px(20)),
                                child: Text(item.title,
                                    style: TextStyle(
                                        fontSize: Adapt.px(30),
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white))),
                          ),
                          // Expanded(
                          //     child: Flex(
                          //   direction: Axis.vertical,
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Container(
                          //         padding: EdgeInsets.only(left: Adapt.px(20)),
                          //         child: Text(item.title,
                          //             style: TextStyle(
                          //                 fontSize: Adapt.px(30),
                          //                 fontWeight: FontWeight.bold,
                          //                 color: Colors.white))),
                          //     Padding(
                          //       padding: EdgeInsets.only(right: Adapt.px(20)),
                          //       child: LinearPercentIndicator(
                          //         // width: 100,
                          //         animation: true,
                          //         animateFromLastPercent: true,
                          //         lineHeight: Adapt.px(40),
                          //         animationDuration: 1000,
                          //         percent: item.progress,
                          //         center: Text("${item.progress * 100}%"),
                          //         linearStrokeCap: LinearStrokeCap.roundAll,
                          //         progressColor: Colors.green,
                          //       ),
                          //     ),
                          //   ],
                          // ))
                        ],
                      ))))
              .toList())
    ];
  }

  _onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {}

  _onListReorder(int oldListIndex, int newListIndex) {}
}
