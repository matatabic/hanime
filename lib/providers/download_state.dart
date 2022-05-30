import 'package:flutter/foundation.dart';
import 'package:hanime/entity/download_entity.dart';
import 'package:hanime/entity/watch_entity.dart';
import 'package:hanime/utils/index.dart';

class Downloading {
  String id;
  String videoUrl;
  bool ongoing;
  Downloading(this.id, this.videoUrl, this.ongoing);
}

class DownloadState with ChangeNotifier, DiagnosticableTreeMixin {
  List<Downloading> _downloadQueueList = [];
  List<DownloadEntity> _downloadList = [];

  List<Downloading> get downloadQueueList => _downloadQueueList;
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
          "retest": 0,
          "success": false,
          "needDownload": true
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

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty('downloadList', _downloadList));
  }
}
