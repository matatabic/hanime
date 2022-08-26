import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hanime/common/fijkplayer_skin/schema.dart';
import 'package:hanime/entity/download_entity.dart';
import 'package:hanime/entity/watch_entity.dart';
import 'package:hanime/utils/storage.dart';
import 'package:hanime/utils/utils.dart';

class DownloadModel with ChangeNotifier, DiagnosticableTreeMixin {
  List<DownloadEntity> _downloadList = [];

  List<DownloadEntity> get downloadList => _downloadList;

  void addDownload(WatchInfo info, String videoUrl, String localVideoUrl) {
    int index =
        _downloadList.indexWhere((element) => element.htmlUrl == info.htmlUrl);
    if (index > -1) {
      if (!_downloadList[index].success) {
        _downloadList[index].waitDownload = true;
      }
    } else {
      _downloadList.insert(
          0,
          DownloadEntity.fromJson({
            "title": info.shareTitle,
            "imageUrl": info.cover,
            "htmlUrl": info.htmlUrl,
            "videoUrl": videoUrl,
            "localVideoUrl":
                '$localVideoUrl/${Utils.getVideoId(info.htmlUrl)}.mp4',
            "progress": 0,
            "success": false,
            "downloading": false,
            "waitDownload": true,
            "reTry": false,
            "reTryTime": 0,
          }));
      saveData(_downloadList);
    }

    notifyListeners();
  }

  void removeItem(String htmlUrl) {
    int index =
        _downloadList.indexWhere((element) => element.htmlUrl == htmlUrl);
    _downloadList.removeAt(index);
    Utils.deleteVideo(htmlUrl);
    saveData(_downloadList);
    notifyListeners();
  }

  bool isCacheVideo(String htmlUrl) {
    return _downloadList.indexWhere(
            (element) => element.htmlUrl == htmlUrl && element.success) >
        -1;
  }

  VideoSourceFormat getCacheVideoUrl(String htmlUrl) {
    int index = _downloadList
        .indexWhere((element) => element.htmlUrl == htmlUrl && element.success);
    return VideoSourceFormat.fromJson({
      "video": [
        {
          "name": "选集",
          "list": [
            {
              "name": _downloadList[index].title,
              'url': _downloadList[index].localVideoUrl
            }
          ]
        },
      ]
    });
  }

  void changeDownloadState(DownloadEntity downloadEntity) {
    int index = _downloadList.indexOf(downloadEntity);
    _downloadList[index].waitDownload = false;
    _downloadList[index].downloading = true;
  }

  void changeDownloadProgress(String videoUrl, double progress) {
    int index =
        _downloadList.indexWhere((element) => element.videoUrl == videoUrl);
    _downloadList[index].progress = progress;
    saveData(_downloadList);
    notifyListeners();
  }

  void downloadSuccess(String videoUrl, {String? localVideoUrl}) {
    int index =
        _downloadList.indexWhere((element) => element.videoUrl == videoUrl);
    _downloadList[index].success = true;
    _downloadList[index].downloading = false;
    if (localVideoUrl != null) {
      _downloadList[index].localVideoUrl = localVideoUrl;
    }
    saveData(_downloadList);
    notifyListeners();
  }

  void pause(String htmlUrl) {
    int index =
        _downloadList.indexWhere((element) => element.htmlUrl == htmlUrl);
    if (_downloadList[index].waitDownload) {
      _downloadList[index].waitDownload = false;
    } else if (_downloadList[index].downloading) {
      _downloadList[index].downloading = false;
    } else {
      _downloadList[index].waitDownload = false;
    }

    notifyListeners();
  }

  void download(String htmlUrl) {
    int index =
        _downloadList.indexWhere((element) => element.htmlUrl == htmlUrl);
    _downloadList[index].waitDownload = true;
    _downloadList[index].reTry = false;
    _downloadList[index].reTryTime = 0;

    notifyListeners();
  }

  void errorDownload(String errorMessage) {
    print(errorMessage);
    for (var i = 0; i < _downloadList.length; i++) {
      print(_downloadList[i].videoUrl);
      if (errorMessage.indexOf(_downloadList[i].videoUrl) > -1) {
        print("errorDownload");
        if (!_downloadList[i].reTry &&
            DateTime.now().microsecondsSinceEpoch - _downloadList[i].reTryTime >
                50000) {
          print("reTryreTryreTryreTry");
          _downloadList[i].waitDownload = true;
          _downloadList[i].downloading = false;
          _downloadList[i].reTry = true;
          _downloadList[i].reTryTime = DateTime.now().microsecondsSinceEpoch;
        } else {
          print("停止下载");
          _downloadList[i].downloading = false;
          _downloadList[i].downloading = false;
          _downloadList[i].reTry = false;
          _downloadList[i].reTryTime = 0;
        }
        notifyListeners();
        break;
      }
    }
  }

  void getCache() async {
    var json = await StorageUtil.getCache("downloadList");
    if (json != null) {
      _downloadList = jsonDecode(json)
          .map<DownloadEntity>((json) => DownloadEntity.fromJson(json))
          .toList();
    }
  }

  saveData(List<DownloadEntity> data) {
    StorageUtil.setDownloadCache(data);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty('downloadList', _downloadList));
  }
}
