import 'package:app_settings/app_settings.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/custom_dialog.dart';
import 'package:hanime/common/permission.dart';
import 'package:hanime/entity/download_entity.dart';
import 'package:hanime/entity/watch_entity.dart';
import 'package:hanime/providers/download_model.dart';
import 'package:hanime/providers/watch_model.dart';
import 'package:hanime/utils/utils.dart';
import 'package:provider/src/provider.dart';

class DownloadWidget extends StatelessWidget {
  final WatchInfo info;
  final String videoUrl;

  DownloadWidget({Key? key, required this.info, required this.videoUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widgetContext = context;

    String currentHtml =
        context.select<WatchModel, String>((value) => value.currentHtml);
    String currentCover =
        context.select<WatchModel, String>((value) => value.currentCover);
    String currentVideoUrl =
        context.select<WatchModel, String>((value) => value.currentVideoUrl);
    String currentShareTitle =
        context.select<WatchModel, String>((value) => value.currentShareTitle);

    List<DownloadEntity> downloadList =
        context.watch<DownloadModel>().downloadList;

    String htmlUrl = currentHtml.length > 0 ? currentHtml : info.htmlUrl;
    String cover = currentCover.length > 0 ? currentCover : info.cover;
    String videoUrl =
        currentVideoUrl.length > 0 ? currentVideoUrl : this.videoUrl;
    String shareTitle =
        currentShareTitle.length > 0 ? currentShareTitle : info.shareTitle;

    bool isDownload = downloadList.any((element) =>
        element.htmlUrl == htmlUrl &&
        (element.waitDownload || element.downloading || element.success));

    return Container(
        width: 30,
        height: 30,
        alignment: Alignment.center,
        child: SizedBox(
            width: 30,
            height: 30,
            child: isDownload
                ? Container(
                    child: Icon(Icons.downloading, size: 30, color: Colors.red))
                : IconButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () async {
                      showCupertinoDialog(
                          context: context,
                          builder: (context) {
                            return CupertinoAlertDialog(
                              title: Text("是否下载该影片?"),
                              actions: <Widget>[
                                CupertinoDialogAction(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('取消'),
                                ),
                                CupertinoDialogAction(
                                  onPressed: () {
                                    print("下载");
                                    print(currentHtml);

                                    checkPermission().then((hasGranted) async {
                                      if (hasGranted) {
                                        String localVideoUrl =
                                            await Utils.findBasePath(htmlUrl);
                                        String downloadUrl;
                                        if (videoUrl.indexOf("m3u8") > -1) {
                                          downloadUrl =
                                              await Utils.getM3u8Url(videoUrl);
                                        } else {
                                          downloadUrl = videoUrl;
                                        }
                                        widgetContext
                                            .read<DownloadModel>()
                                            .addDownload(
                                                info
                                                  ..cover = cover
                                                  ..shareTitle = shareTitle
                                                  ..htmlUrl = htmlUrl,
                                                downloadUrl,
                                                localVideoUrl);
                                        BotToast.showSimpleNotification(
                                            title: "已经加入下载队列");
                                      } else {
                                        CustomDialog.showDialog(
                                            context, "请开启读写文件权限", () {
                                          AppSettings.openAppSettings();
                                        });
                                      }
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Text('确定'),
                                ),
                              ],
                            );
                          });
                    },
                    icon: Icon(Icons.downloading, size: 30, color: Colors.grey),
                  )));
  }
}
