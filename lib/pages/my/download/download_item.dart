import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/common_image.dart';
import 'package:hanime/common/custom_dialog.dart';
import 'package:hanime/component/loading_cover.dart';
import 'package:hanime/entity/download_entity.dart';
import 'package:hanime/providers/download_model.dart';
import 'package:hanime/request/dio_range_download_manage.dart';
import 'package:hanime/utils/utils.dart';
import 'package:m3u8_downloader/m3u8_downloader.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/src/provider.dart';

class DownloadItem extends StatelessWidget {
  final DownloadEntity downloadEntity;

  DownloadItem({Key? key, required this.downloadEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widgetContext = context;
    Widget _widget;
    List<Widget> ws = [];
    if (downloadEntity.success) {
      _widget = Stack(alignment: Alignment.center, children: ws);
      ws.add(Container(
        height: 100,
        child: CommonImage(
          imgUrl: downloadEntity.imageUrl,
        ),
      ));
    } else {
      _widget = InkWell(
          onTap: () {
            if (downloadEntity.waitDownload) {
              CustomDialog.showDialog(context, "确认暂停下载?", () {
                widgetContext
                    .read<DownloadModel>()
                    .pause(downloadEntity.htmlUrl);
                Navigator.pop(widgetContext);
              });
              return;
            }

            if (downloadEntity.downloading) {
              CustomDialog.showDialog(context, "确认暂停下载?", () {
                widgetContext
                    .read<DownloadModel>()
                    .pause(downloadEntity.htmlUrl);
                if (downloadEntity.videoUrl.contains("m3u8")) {
                  M3u8Downloader.pause(downloadEntity.videoUrl);
                } else {
                  DioRangeDownloadManage.cancelDownload(
                      downloadEntity.videoUrl);
                }
                Navigator.pop(widgetContext);
              });
            } else {
              CustomDialog.showDialog(context, "确认开始下载?", () {
                widgetContext
                    .read<DownloadModel>()
                    .download(downloadEntity.htmlUrl);
                Navigator.pop(widgetContext);
              });
            }
          },
          child: Stack(alignment: Alignment.center, children: ws));
      ws.add(Container(
        height: 100,
        child: CommonImage(
          imgUrl: downloadEntity.imageUrl,
        ),
      ));
      if (!downloadEntity.downloading && !downloadEntity.waitDownload) {
        ws.add(Icon(Icons.cloud_download, size: 50, color: Colors.green));
      }
    }

    if (downloadEntity.downloading) {
      ws.add(LinearPercentIndicator(
        animation: true,
        isRTL: true,
        animateFromLastPercent: true,
        lineHeight: 100,
        animationDuration: 1000,
        percent: Utils.progress2showProgress(downloadEntity.progress),
        padding: EdgeInsets.all(0),
        linearStrokeCap: LinearStrokeCap.butt,
        backgroundColor: Colors.transparent,
        progressColor: Colors.black87,
      ));
      ws.add(Icon(Icons.pause_circle_filled, size: 50, color: Colors.grey));
      ws.add(Align(
          alignment: Alignment.bottomRight,
          child:
              Text("${(downloadEntity.progress * 100).toStringAsFixed(1)}%")));
    }

    if (downloadEntity.waitDownload) {
      ws.add(LoadingCover(
        width: 150,
        height: 100,
      ));
    }

    return Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        color: Color.fromRGBO(58, 60, 63, 1),
        height: 110,
        child: Row(
          children: [
            SizedBox(
              width: 150,
              child: _widget,
            ),
            Expanded(
              child: Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(downloadEntity.title,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white))),
            )
          ],
        ));
  }
}
