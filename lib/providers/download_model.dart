import 'package:flutter/foundation.dart';
import 'package:hanime/entity/download_entity.dart';
import 'package:hanime/entity/watch_entity.dart';
import 'package:hanime/utils/index.dart';

class DownloadModel with ChangeNotifier, DiagnosticableTreeMixin {
  List<DownloadEntity> _downloadList = [];

  List<DownloadEntity> get downloadList => _downloadList;

  void addDownload(WatchInfo info, String videoUrl) {
    _downloadList.insert(
        0,
        DownloadEntity.fromJson({
          "id": getVideoId(info.htmlUrl),
          "title": info.title,
          "imageUrl": info.cover,
          "htmlUrl": info.htmlUrl,
          "videoUrl": videoUrl,
          "progress": 0,
          "success": false,
          "downloading": false,
          "waitDownload": true,
          "reTry": false,
          "reTryTime": 0,
        }));

    notifyListeners();
  }

  bool getDownloadState(int id) {
    return _downloadList.any((item) => item.id == id && item.waitDownload);
  }

  void changeDownloadState(DownloadEntity downloadEntity) {
    int index = _downloadList.indexOf(downloadEntity);
    _downloadList[index].waitDownload = false;
    _downloadList[index].downloading = true;
  }

  void changeDownloadProgress(int id, double progress) {
    int index = _downloadList.indexWhere((element) => element.id == id);
    _downloadList[index].progress = progress;
    notifyListeners();
  }

  void downloadSuccess(int id) {
    int index = _downloadList.indexWhere((element) => element.id == id);
    _downloadList[index].success = true;
    _downloadList[index].downloading = false;
    notifyListeners();
  }

  void pause(int id) {
    int index = _downloadList.indexWhere((element) => element.id == id);
    _downloadList[index].downloading = false;
    notifyListeners();
  }

  void download(int id) {
    int index = _downloadList.indexWhere((element) => element.id == id);
    _downloadList[index].waitDownload = true;
    notifyListeners();
  }

  void errorDownload(String errorMessage) {
    for (var i = 0; i < _downloadList.length; i++) {
      if (errorMessage.indexOf(_downloadList[i].videoUrl) > -1) {
        if (!_downloadList[i].reTry &&
            DateTime.now().microsecondsSinceEpoch - _downloadList[i].reTryTime >
                50000) {
          _downloadList[i].waitDownload = true;
          _downloadList[i].reTry = true;
          _downloadList[i].reTryTime = DateTime.now().microsecondsSinceEpoch;
        }
        break;
      }
    }
  }

  void getCache() {
    List<DownloadEntity> data = [
      DownloadEntity.fromJson({
        "id": 38462,
        "title": "小さな蕾のその奥に…… ～妖しく齧る爛れた蕾……",
        "imageUrl":
            "https://cdn.jsdelivr.net/gh/guaishushukanlifan/Project-H@latest/asset/thumbnail/aH3xcyhl.jpg",
        "htmlUrl": "https://hanime1.me/watch?v=38462",
        "videoUrl":
            "https://vdownload-34.sb-cd.com/1/1/11668133-1080p.mp4?secure=RuqVXFYER4WC6fkYmpQelg,1656551779&m=34&d=2&_tid=11668133",
        "progress": 0.0,
        "success": false,
        "downloading": false,
        "waitDownload": false,
        "reTry": false,
        "reTryTime": 0,
      }),
      DownloadEntity.fromJson({
        "id": 23177,
        "title": "なま LO Re：ふらちもの THE ANIMATION",
        "imageUrl":
            "https://cdn.jsdelivr.net/gh/guaishushukanlifan/Project-H@latest/asset/thumbnail/aH3xcyhl.jpg",
        "htmlUrl": "https://hanime1.me/watch?v=23177",
        "videoUrl":
            "https://vdownload-4.sb-cd.com/1/1/11712492-720p.mp4?secure=TK5LOSLX9OUWWeMTQZ7O8Q,1656561320&m=4&d=3&_tid=11712492",
        "progress": 1,
        "success": true,
        "downloading": false,
        "waitDownload": false,
        "reTry": false,
        "reTryTime": 0,
      }),
    ];

    _downloadList = data;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty('downloadList', _downloadList));
  }
}
