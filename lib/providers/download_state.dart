import 'package:flutter/foundation.dart';
import 'package:hanime/entity/download_entity.dart';
import 'package:hanime/entity/watch_entity.dart';

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
    downloadList.insert(
        0,
        DownloadEntity.fromJson({
          "id": info.htmlUrl,
          "title": info.title,
          "imageUrl": info.imgUrl,
          "htmlUrl": info.htmlUrl,
          "videoUrl": videoUrl,
          "baseDir": baseDir,
          "progress": 0,
          "success": false,
          "needDownload": true
        }));
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
  }
}
