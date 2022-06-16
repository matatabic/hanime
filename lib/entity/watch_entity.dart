import 'dart:convert';

import 'package:hanime/generated/json/base/json_field.dart';
import 'package:hanime/generated/json/watch_entity.g.dart';

@JsonSerializable()
class WatchEntity {
  late WatchInfo info;
  late WatchVideoData videoData;
  late List<WatchEpisode> episode;
  late List<WatchTag> tag;
  late int commendCount;
  late List<WatchCommend> commend;

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
  late String htmlUrl;
  late String cover;
  late int videoIndex;
  late String shareTitle;
  late String countTitle;
  late String description;

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
class WatchEpisode {
  late String imgUrl;
  late String title;
  late String htmlUrl;

  WatchEpisode();

  factory WatchEpisode.fromJson(Map<String, dynamic> json) =>
      $WatchEpisodeFromJson(json);

  Map<String, dynamic> toJson() => $WatchEpisodeToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class WatchTag {
  late String title;
  late String htmlUrl;

  WatchTag();

  factory WatchTag.fromJson(Map<String, dynamic> json) =>
      $WatchTagFromJson(json);

  Map<String, dynamic> toJson() => $WatchTagToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class WatchCommend {
  late String title;
  late String imgUrl;
  late String duration;
  late String htmlUrl;
  late String author;
  late String genre;
  late String created;

  WatchCommend();

  factory WatchCommend.fromJson(Map<String, dynamic> json) =>
      $WatchCommendFromJson(json);

  Map<String, dynamic> toJson() => $WatchCommendToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
