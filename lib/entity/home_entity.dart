import 'dart:convert';

import 'package:hanime/generated/json/base/json_field.dart';
import 'package:hanime/generated/json/home_entity.g.dart';

@JsonSerializable()
class HomeEntity {
  late List<HomeSwiper> swiper;
  late List<HomeVideo> video;

  HomeEntity();

  factory HomeEntity.fromJson(Map<String, dynamic> json) =>
      $HomeEntityFromJson(json);

  Map<String, dynamic> toJson() => $HomeEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class HomeSwiper {
  late String imgUrl;
  late String title;
  late String url;

  HomeSwiper();

  factory HomeSwiper.fromJson(Map<String, dynamic> json) =>
      $HomeSwiperFromJson(json);

  Map<String, dynamic> toJson() => $HomeSwiperToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class HomeVideo {
  late String label;
  late List<HomeVideoData> data;

  HomeVideo();

  factory HomeVideo.fromJson(Map<String, dynamic> json) =>
      $HomeVideoFromJson(json);

  Map<String, dynamic> toJson() => $HomeVideoToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class HomeVideoData {
  late String imgUrl;
  late String title;
  late String url;

  HomeVideoData();

  factory HomeVideoData.fromJson(Map<String, dynamic> json) =>
      $HomeVideoDataFromJson(json);

  Map<String, dynamic> toJson() => $HomeVideoDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
