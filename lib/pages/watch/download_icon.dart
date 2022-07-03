import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/entity/watch_entity.dart';
import 'package:hanime/providers/download_model.dart';
import 'package:hanime/utils/index.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/src/provider.dart';

class DownloadIcon extends StatefulWidget {
  final WatchInfo info;
  final String videoUrl;

  DownloadIcon({Key? key, required this.info, required this.videoUrl})
      : super(key: key);

  @override
  _DownloadIconState createState() => _DownloadIconState();
}

class _DownloadIconState extends State<DownloadIcon> {
  Future<bool> _checkPermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();
    }
    return status.isGranted;
  }

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
            child: context
                    .watch<DownloadModel>()
                    .downloadList
                    .any((element) => element.htmlUrl == widget.info.htmlUrl)
                ? Container(
                    child: Icon(Icons.downloading,
                        size: Adapt.px(60), color: Colors.red))
                : InkWell(
                    onTap: () async {
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
                                    _checkPermission().then((hasGranted) async {
                                      if (hasGranted) {
                                        String downloadUrl;
                                        if (widget.videoUrl.indexOf("m3u8") >
                                            -1) {
                                          downloadUrl =
                                              await getM3u8Url(widget.videoUrl);
                                        } else {
                                          downloadUrl = widget.videoUrl;
                                        }
                                        widgetContext
                                            .read<DownloadModel>()
                                            .addDownload(
                                                widget.info, downloadUrl);
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
                    child: Icon(Icons.downloading,
                        size: Adapt.px(60), color: Colors.grey),
                  )));
  }
}
