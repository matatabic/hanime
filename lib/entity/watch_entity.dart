import 'dart:convert';

import 'package:hanime/generated/json/base/json_field.dart';
import 'package:hanime/generated/json/watch_entity.g.dart';

@JsonSerializable()
class WatchEntity {
  late WatchInfo info;
  late WatchVideoData videoData;
  late List<WatchVideoList> videoList;
  late List<String> tagList;
  late List<WatchCommendList> commendList;

  WatchEntity();

  factory WatchEntity.fromJson(Map<String, dynamic> json) =>
      $WatchEntityFromJson(json);

  Map<String, dynamic> toJson() => $WatchEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class WatchInfo {
  late String title;
  late String imgUrl;
  late String countTitle;

  WatchInfo();

  factory WatchInfo.fromJson(Map<String, dynamic> json) =>
      $WatchInfoFromJson(json);

  Map<String, dynamic> toJson() => $WatchInfoToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class WatchVideoData {
  late List<WatchVideoDataVideo> video;

  WatchVideoData();

  factory WatchVideoData.fromJson(Map<String, dynamic> json) =>
      $WatchVideoDataFromJson(json);

  Map<String, dynamic> toJson() => $WatchVideoDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class WatchVideoDataVideo {
  late String name;
  late List<WatchVideoDataVideoList> list;

  WatchVideoDataVideo();

  factory WatchVideoDataVideo.fromJson(Map<String, dynamic> json) =>
      $WatchVideoDataVideoFromJson(json);

  Map<String, dynamic> toJson() => $WatchVideoDataVideoToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class WatchVideoDataVideoList {
  late String name;
  late String url;

  WatchVideoDataVideoList();

  factory WatchVideoDataVideoList.fromJson(Map<String, dynamic> json) =>
      $WatchVideoDataVideoListFromJson(json);

  Map<String, dynamic> toJson() => $WatchVideoDataVideoListToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class WatchVideoList {
  late String imgUrl;
  late String title;
  late String htmlUrl;

  WatchVideoList();

  factory WatchVideoList.fromJson(Map<String, dynamic> json) =>
      $WatchVideoListFromJson(json);

  Map<String, dynamic> toJson() => $WatchVideoListToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class WatchCommendList {
  late String imgUrl;
  late String title;
  late String url;

  WatchCommendList();

  factory WatchCommendList.fromJson(Map<String, dynamic> json) =>
      $WatchCommendListFromJson(json);

  Map<String, dynamic> toJson() => $WatchCommendListToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
