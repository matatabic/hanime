import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/common/common_image.dart';
import 'package:hanime/common/custom_dialog.dart';
import 'package:hanime/common/loading_cover.dart';
import 'package:hanime/entity/download_entity.dart';
import 'package:hanime/providers/download_model.dart';
import 'package:hanime/utils/dio_range_download_manage.dart';
import 'package:hanime/utils/index.dart';
import 'package:m3u8_downloader/m3u8_downloader.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/src/provider.dart';

class DownloadItem extends StatelessWidget {
  final DownloadEntity downloadEntity;

  DownloadItem({Key? key, required this.downloadEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("BuildContextbuild${downloadEntity.title}");
    Widget _widget;
    List<Widget> ws = [];
    if (downloadEntity.success || downloadEntity.waitDownload) {
      _widget = Stack(alignment: Alignment.center, children: ws);
      ws.add(Container(
        height: Adapt.px(200),
        child: CommonImages(
          imgUrl: downloadEntity.imageUrl,
        ),
      ));
    } else {
      _widget = InkWell(
          onTap: () {
            if (downloadEntity.downloading) {
              CustomDialog.showDialog(
                  context,
                  "确认暂停下载?",
                  (dialogContext) => {
                        context.read<DownloadModel>().pause(downloadEntity.id),
                        if (downloadEntity.videoUrl.contains("m3u8"))
                          {M3u8Downloader.pause(downloadEntity.videoUrl)}
                        else
                          {
                            DioRangeDownloadManage.cancelDownload(
                                downloadEntity.videoUrl)
                          },
                        Navigator.pop(dialogContext)
                      });
            } else {
              CustomDialog.showDialog(
                  context,
                  "确认开始下载?",
                  (dialogContext) => {
                        context
                            .read<DownloadModel>()
                            .download(downloadEntity.id),
                        Navigator.pop(dialogContext)
                      });
            }
          },
          child: Stack(alignment: Alignment.center, children: ws));
      ws.add(Container(
        height: Adapt.px(200),
        child: CommonImages(
          imgUrl: downloadEntity.imageUrl,
        ),
      ));
      if (!downloadEntity.downloading) {
        ws.add(Icon(Icons.cloud_download,
            size: Adapt.px(100), color: Colors.green));
      }
    }

    if (downloadEntity.downloading) {
      ws.add(LinearPercentIndicator(
        animation: true,
        isRTL: true,
        animateFromLastPercent: true,
        lineHeight: Adapt.px(200),
        animationDuration: 1000,
        percent: progress2showProgress(downloadEntity.progress),
        padding: EdgeInsets.all(0),
        linearStrokeCap: LinearStrokeCap.butt,
        backgroundColor: Colors.transparent,
        progressColor: Colors.black87,
      ));
      ws.add(Icon(Icons.pause_circle_filled,
          size: Adapt.px(100), color: Colors.grey));
      ws.add(Align(
          alignment: Alignment.bottomRight,
          child:
              Text("${(downloadEntity.progress * 100).toStringAsFixed(1)}%")));
    }

    if (downloadEntity.waitDownload) {
      ws.add(LoadingCover());
    }
    return Container(
        padding: EdgeInsets.symmetric(
            vertical: Adapt.px(10), horizontal: Adapt.px(10)),
        color: Color.fromRGBO(58, 60, 63, 1),
        height: Adapt.px(220),
        child: Row(
          children: [
            SizedBox(
              width: Adapt.px(300),
              child: _widget,
            ),
            Expanded(
              child: Container(
                  padding: EdgeInsets.only(left: Adapt.px(20)),
                  child: Text(downloadEntity.title,
                      style: TextStyle(
                          fontSize: Adapt.px(30),
                          fontWeight: FontWeight.bold,
                          color: Colors.white))),
            )
          ],
        ));
  }
}
