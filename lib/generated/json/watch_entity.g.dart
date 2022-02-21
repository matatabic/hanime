import 'package:hanime/entity/watch_entity.dart';
import 'package:hanime/generated/json/base/json_convert_content.dart';

WatchEntity $WatchEntityFromJson(Map<String, dynamic> json) {
  final WatchEntity watchEntity = WatchEntity();
  final WatchInfo? info = jsonConvert.convert<WatchInfo>(json['info']);
  if (info != null) {
    watchEntity.info = info;
  }
  final WatchVideoData? videoData =
      jsonConvert.convert<WatchVideoData>(json['videoData']);
  if (videoData != null) {
    watchEntity.videoData = videoData;
  }
  final List<WatchVideoList>? videoList =
      jsonConvert.convertListNotNull<WatchVideoList>(json['videoList']);
  if (videoList != null) {
    watchEntity.videoList = videoList;
  }
  final List<String>? tagList =
      jsonConvert.convertListNotNull<String>(json['tagList']);
  if (tagList != null) {
    watchEntity.tagList = tagList;
  }
  final List<WatchCommendList>? commendList =
      jsonConvert.convertListNotNull<WatchCommendList>(json['commendList']);
  if (commendList != null) {
    watchEntity.commendList = commendList;
  }
  return watchEntity;
}

Map<String, dynamic> $WatchEntityToJson(WatchEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['info'] = entity.info.toJson();
  data['videoData'] = entity.videoData.toJson();
  data['videoList'] = entity.videoList.map((v) => v.toJson()).toList();
  data['tagList'] = entity.tagList;
  data['commendList'] = entity.commendList.map((v) => v.toJson()).toList();
  return data;
}

WatchInfo $WatchInfoFromJson(Map<String, dynamic> json) {
  final WatchInfo watchInfo = WatchInfo();
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    watchInfo.title = title;
  }
  final String? imgUrl = jsonConvert.convert<String>(json['imgUrl']);
  if (imgUrl != null) {
    watchInfo.imgUrl = imgUrl;
  }
  final String? countTitle = jsonConvert.convert<String>(json['countTitle']);
  if (countTitle != null) {
    watchInfo.countTitle = countTitle;
  }
  return watchInfo;
}

Map<String, dynamic> $WatchInfoToJson(WatchInfo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['title'] = entity.title;
  data['imgUrl'] = entity.imgUrl;
  data['countTitle'] = entity.countTitle;
  return data;
}

WatchVideoData $WatchVideoDataFromJson(Map<String, dynamic> json) {
  final WatchVideoData watchVideoData = WatchVideoData();
  final List<WatchVideoDataVideo>? video =
      jsonConvert.convertListNotNull<WatchVideoDataVideo>(json['video']);
  if (video != null) {
    watchVideoData.video = video;
  }
  return watchVideoData;
}

Map<String, dynamic> $WatchVideoDataToJson(WatchVideoData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['video'] = entity.video.map((v) => v.toJson()).toList();
  return data;
}

WatchVideoDataVideo $WatchVideoDataVideoFromJson(Map<String, dynamic> json) {
  final WatchVideoDataVideo watchVideoDataVideo = WatchVideoDataVideo();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    watchVideoDataVideo.name = name;
  }
  final List<WatchVideoDataVideoList>? list =
      jsonConvert.convertListNotNull<WatchVideoDataVideoList>(json['list']);
  if (list != null) {
    watchVideoDataVideo.list = list;
  }
  return watchVideoDataVideo;
}

Map<String, dynamic> $WatchVideoDataVideoToJson(WatchVideoDataVideo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['list'] = entity.list.map((v) => v.toJson()).toList();
  return data;
}

WatchVideoDataVideoList $WatchVideoDataVideoListFromJson(
    Map<String, dynamic> json) {
  final WatchVideoDataVideoList watchVideoDataVideoList =
      WatchVideoDataVideoList();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    watchVideoDataVideoList.name = name;
  }
  final String? url = jsonConvert.convert<String>(json['url']);
  if (url != null) {
    watchVideoDataVideoList.url = url;
  }
  return watchVideoDataVideoList;
}

Map<String, dynamic> $WatchVideoDataVideoListToJson(
    WatchVideoDataVideoList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['url'] = entity.url;
  return data;
}

WatchVideoList $WatchVideoListFromJson(Map<String, dynamic> json) {
  final WatchVideoList watchVideoList = WatchVideoList();
  final String? imgUrl = jsonConvert.convert<String>(json['imgUrl']);
  if (imgUrl != null) {
    watchVideoList.imgUrl = imgUrl;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    watchVideoList.title = title;
  }
  final String? htmlUrl = jsonConvert.convert<String>(json['htmlUrl']);
  if (htmlUrl != null) {
    watchVideoList.htmlUrl = htmlUrl;
  }
  return watchVideoList;
}

Map<String, dynamic> $WatchVideoListToJson(WatchVideoList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['imgUrl'] = entity.imgUrl;
  data['title'] = entity.title;
  data['htmlUrl'] = entity.htmlUrl;
  return data;
}

WatchCommendList $WatchCommendListFromJson(Map<String, dynamic> json) {
  final WatchCommendList watchCommendList = WatchCommendList();
  final String? imgUrl = jsonConvert.convert<String>(json['imgUrl']);
  if (imgUrl != null) {
    watchCommendList.imgUrl = imgUrl;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    watchCommendList.title = title;
  }
  final String? url = jsonConvert.convert<String>(json['url']);
  if (url != null) {
    watchCommendList.url = url;
  }
  return watchCommendList;
}

Map<String, dynamic> $WatchCommendListToJson(WatchCommendList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['imgUrl'] = entity.imgUrl;
  data['title'] = entity.title;
  data['url'] = entity.url;
  return data;
}
