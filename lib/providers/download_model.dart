import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hanime/common/fijkplayer_skin/schema.dart';
import 'package:hanime/entity/download_entity.dart';
import 'package:hanime/entity/watch_entity.dart';
import 'package:hanime/utils/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DownloadModel with ChangeNotifier, DiagnosticableTreeMixin {
  List<DownloadEntity> _downloadList = [];

  List<DownloadEntity> get downloadList => _downloadList;

  void addDownload(WatchInfo info, String videoUrl, String localVideoUrl) {
    _downloadList.insert(
        0,
        DownloadEntity.fromJson({
          "id": getVideoId(info.htmlUrl),
          "title": info.shareTitle,
          "imageUrl": info.cover,
          "htmlUrl": info.htmlUrl,
          "videoUrl": videoUrl,
          "localVideoUrl": localVideoUrl,
          "progress": 0,
          "success": false,
          "downloading": false,
          "waitDownload": true,
          "reTry": false,
          "reTryTime": 0,
        }));
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
    if (localVideoUrl!.isNotEmpty) {
      _downloadList[index].localVideoUrl = localVideoUrl;
    }
    saveData(_downloadList);
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
    _downloadList[index].reTry = false;
    _downloadList[index].reTryTime = 0;

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

  void getCache() async {
    // List<DownloadEntity> data = [
    //   DownloadEntity.fromJson({
    //     "id": 38462,
    //     "title": "小さな蕾のその奥に…… ～妖しく齧る爛れた蕾……",
    //     "imageUrl":
    //         "https://cdn.jsdelivr.net/gh/guaishushukanlifan/Project-H@latest/asset/thumbnail/aH3xcyhl.jpg",
    //     "htmlUrl": "https://hanime1.me/watch?v=38462",
    //     "videoUrl":
    //         "https://vstream.hembed.com/hls/38462.m3u8?token=wzLwJmriR0A53qxMP34rqDq4GEo4y9KYJBW25NYx4BQ&expires=1656601202",
    //     "localVideoUrl": "",
    //     "progress": 0.0,
    //     "success": false,
    //     "downloading": false,
    //     "waitDownload": false,
    //     "reTry": false,
    //     "reTryTime": 0,
    //   }),
    //   DownloadEntity.fromJson({
    //     "id": 23177,
    //     "title": "なま LO Re：ふらちもの THE ANIMATION",
    //     "imageUrl":
    //         "https://cdn.jsdelivr.net/gh/guaishushukanlifan/Project-H@latest/asset/thumbnail/aH3xcyhl.jpg",
    //     "htmlUrl": "https://hanime1.me/watch?v=23177",
    //     "videoUrl":
    //         "https://vdownload-4.sb-cd.com/1/1/11712492-720p.mp4?secure=TK5LOSLX9OUWWeMTQZ7O8Q,1656561320&m=4&d=3&_tid=11712492",
    //     "localVideoUrl": "",
    //     "progress": 1,
    //     "success": true,
    //     "downloading": false,
    //     "waitDownload": false,
    //     "reTry": false,
    //     "reTryTime": 0,
    //   }),
    // ];
    // _downloadList = data;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var json = prefs.getString("downloadList");
    if (json != null) {
      _downloadList = jsonDecode(json)
          .map<DownloadEntity>((json) => DownloadEntity.fromJson(json))
          .toList();
      print(_downloadList);
    }
  }

  saveData(List<DownloadEntity> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
        "downloadList", jsonEncode(data.map((v) => v.toCacheJson()).toList()));
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty('downloadList', _downloadList));
  }
}
