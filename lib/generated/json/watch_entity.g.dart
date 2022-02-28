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
  final List<WatchEpisode>? episode =
      jsonConvert.convertListNotNull<WatchEpisode>(json['episode']);
  if (episode != null) {
    watchEntity.episode = episode;
  }
  final List<WatchTag>? tag =
      jsonConvert.convertListNotNull<WatchTag>(json['tag']);
  if (tag != null) {
    watchEntity.tag = tag;
  }
  final int? commendCount = jsonConvert.convert<int>(json['commendCount']);
  if (commendCount != null) {
    watchEntity.commendCount = commendCount;
  }
  final List<WatchCommend>? commend =
      jsonConvert.convertListNotNull<WatchCommend>(json['commend']);
  if (commend != null) {
    watchEntity.commend = commend;
  }
  return watchEntity;
}

Map<String, dynamic> $WatchEntityToJson(WatchEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['info'] = entity.info.toJson();
  data['videoData'] = entity.videoData.toJson();
  data['episode'] = entity.episode.map((v) => v.toJson()).toList();
  data['tag'] = entity.tag.map((v) => v.toJson()).toList();
  data['commendCount'] = entity.commendCount;
  data['commend'] = entity.commend.map((v) => v.toJson()).toList();
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
  final int? videoIndex = jsonConvert.convert<int>(json['videoIndex']);
  if (videoIndex != null) {
    watchInfo.videoIndex = videoIndex;
  }
  final String? shareTitle = jsonConvert.convert<String>(json['shareTitle']);
  if (shareTitle != null) {
    watchInfo.shareTitle = shareTitle;
  }
  final String? countTitle = jsonConvert.convert<String>(json['countTitle']);
  if (countTitle != null) {
    watchInfo.countTitle = countTitle;
  }
  final String? description = jsonConvert.convert<String>(json['description']);
  if (description != null) {
    watchInfo.description = description;
  }
  return watchInfo;
}

Map<String, dynamic> $WatchInfoToJson(WatchInfo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['title'] = entity.title;
  data['imgUrl'] = entity.imgUrl;
  data['videoIndex'] = entity.videoIndex;
  data['shareTitle'] = entity.shareTitle;
  data['countTitle'] = entity.countTitle;
  data['description'] = entity.description;
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

WatchEpisode $WatchEpisodeFromJson(Map<String, dynamic> json) {
  final WatchEpisode watchEpisode = WatchEpisode();
  final String? imgUrl = jsonConvert.convert<String>(json['imgUrl']);
  if (imgUrl != null) {
    watchEpisode.imgUrl = imgUrl;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    watchEpisode.title = title;
  }
  final String? htmlUrl = jsonConvert.convert<String>(json['htmlUrl']);
  if (htmlUrl != null) {
    watchEpisode.htmlUrl = htmlUrl;
  }
  return watchEpisode;
}

Map<String, dynamic> $WatchEpisodeToJson(WatchEpisode entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['imgUrl'] = entity.imgUrl;
  data['title'] = entity.title;
  data['htmlUrl'] = entity.htmlUrl;
  return data;
}

WatchTag $WatchTagFromJson(Map<String, dynamic> json) {
  final WatchTag watchTag = WatchTag();
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    watchTag.title = title;
  }
  final String? htmlUrl = jsonConvert.convert<String>(json['htmlUrl']);
  if (htmlUrl != null) {
    watchTag.htmlUrl = htmlUrl;
  }
  final String? htle = jsonConvert.convert<String>(json['htle']);
  if (htle != null) {
    watchTag.htle = htle;
  }
  return watchTag;
}

Map<String, dynamic> $WatchTagToJson(WatchTag entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['title'] = entity.title;
  data['htmlUrl'] = entity.htmlUrl;
  data['htle'] = entity.htle;
  return data;
}

WatchCommend $WatchCommendFromJson(Map<String, dynamic> json) {
  final WatchCommend watchCommend = WatchCommend();
  final String? imgUrl = jsonConvert.convert<String>(json['imgUrl']);
  if (imgUrl != null) {
    watchCommend.imgUrl = imgUrl;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    watchCommend.title = title;
  }
  final String? url = jsonConvert.convert<String>(json['url']);
  if (url != null) {
    watchCommend.url = url;
  }
  return watchCommend;
}

Map<String, dynamic> $WatchCommendToJson(WatchCommend entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['imgUrl'] = entity.imgUrl;
  data['title'] = entity.title;
  data['url'] = entity.url;
  return data;
}
