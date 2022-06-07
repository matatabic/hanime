import 'package:flutter/foundation.dart';
import 'package:hanime/entity/download_entity.dart';
import 'package:hanime/entity/watch_entity.dart';
import 'package:hanime/utils/index.dart';

class DownloadState with ChangeNotifier, DiagnosticableTreeMixin {
  List<DownloadEntity> _downloadList = [];

  List<DownloadEntity> get downloadList => _downloadList;

  void addQueue(WatchInfo info, String baseDir, String videoUrl) {
    _downloadList.insert(
        0,
        DownloadEntity.fromJson({
          "id": getVideoId(info.htmlUrl),
          "title": info.title,
          "imageUrl": info.imgUrl,
          "htmlUrl": info.htmlUrl,
          "videoUrl": videoUrl,
          "baseDir": baseDir,
          "progress": 0,
          "success": false,
          "needDownload": true,
          "retest": false,
          "reTime": 0,
        }));

    notifyListeners();
  }

  bool getDownloadState(int id) {
    return _downloadList.any((item) => item.id == id && item.needDownload);
  }

  void changeDownloadState(DownloadEntity downloadEntity) {
    int index = _downloadList.indexOf(downloadEntity);
    _downloadList[index].needDownload = false;
    print("已下载");
  }

  void errorDownload(String errorMessage) {}

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty('downloadList', _downloadList));
  }
}
