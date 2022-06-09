import 'package:flutter/foundation.dart';
import 'package:hanime/entity/download_entity.dart';
import 'package:hanime/entity/watch_entity.dart';
import 'package:hanime/utils/index.dart';

class DownloadState with ChangeNotifier, DiagnosticableTreeMixin {
  List<DownloadEntity> _downloadList = [];

  List<DownloadEntity> get downloadList => _downloadList;

  void addQueue(WatchInfo info, String videoUrl) {
    _downloadList.insert(
        0,
        DownloadEntity.fromJson({
          "id": getVideoId(info.htmlUrl),
          "title": info.title,
          "imageUrl": info.imgUrl,
          "htmlUrl": info.htmlUrl,
          "videoUrl": videoUrl,
          "progress": 0,
          "success": false,
          "needDownload": true,
          "reTest": false,
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

  void errorDownload(String errorMessage) {
    for (var i = 0; i < _downloadList.length; i++) {
      if (errorMessage.indexOf(_downloadList[i].videoUrl) > -1) {
        // if (_downloadList[i].reTest) {
        //   print("已经重试一次");
        // } else {
        //   print("还没重试");
        // }
        // print(DateTime.now().microsecondsSinceEpoch);
        // print(_downloadList[i].reTime);
        // if (DateTime.now().microsecondsSinceEpoch - _downloadList[i].reTime >
        //     50000) {
        //   print("时间够");
        // } else {
        //   print("时间不够");
        // }
        if (!_downloadList[i].reTest &&
            DateTime.now().microsecondsSinceEpoch - _downloadList[i].reTime >
                50000) {
          _downloadList[i].needDownload = true;
          _downloadList[i].reTest = true;
          _downloadList[i].reTime = DateTime.now().microsecondsSinceEpoch;
        }
        break;
      }
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty('downloadList', _downloadList));
  }
}
