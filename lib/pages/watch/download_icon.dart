import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/common/permission.dart';
import 'package:hanime/entity/watch_entity.dart';
import 'package:hanime/providers/download_model.dart';
import 'package:hanime/utils/index.dart';
import 'package:provider/src/provider.dart';

class DownloadIcon extends StatelessWidget {
  final WatchInfo info;
  final String videoUrl;

  DownloadIcon({Key? key, required this.info, required this.videoUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widgetContext = context;
    return Container(
        width: Adapt.px(60),
        height: Adapt.px(60),
        alignment: Alignment.center,
        child: SizedBox(
            width: Adapt.px(60),
            height: Adapt.px(60),
            child: context.watch<DownloadModel>().downloadList.any((element) =>
                    element.htmlUrl == info.htmlUrl &&
                    (element.waitDownload ||
                        element.downloading ||
                        element.success))
                ? Container(
                    child: Icon(Icons.downloading,
                        size: Adapt.px(60), color: Colors.red))
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
                                    checkPermission().then((hasGranted) async {
                                      if (hasGranted) {
                                        String localVideoUrl =
                                            await findBasePath(info.htmlUrl);
                                        String downloadUrl;
                                        if (videoUrl.indexOf("m3u8") > -1) {
                                          downloadUrl =
                                              await getM3u8Url(videoUrl);
                                        } else {
                                          downloadUrl = videoUrl;
                                        }
                                        widgetContext
                                            .read<DownloadModel>()
                                            .addDownload(info, downloadUrl,
                                                localVideoUrl);
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
                    icon: Icon(Icons.downloading,
                        size: Adapt.px(60), color: Colors.grey),
                  )));
  }
}
