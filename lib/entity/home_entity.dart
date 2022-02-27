import 'dart:convert';

import 'package:hanime/generated/json/base/json_field.dart';
import 'package:hanime/generated/json/home_entity.g.dart';

@JsonSerializable()
class HomeEntity {
  late List<HomeSwiperList> swiperList;
  @JSONField(name: "List")
  late List<HomeList> list;

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
class HomeSwiperList {
  late String imgUrl;
  late String title;
  late String url;

  HomeSwiperList();

  factory HomeSwiperList.fromJson(Map<String, dynamic> json) =>
      $HomeSwiperListFromJson(json);

  Map<String, dynamic> toJson() => $HomeSwiperListToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class HomeList {
  late String label;
  late List<HomeListData> data;

  HomeList();

  factory HomeList.fromJson(Map<String, dynamic> json) =>
      $HomeListFromJson(json);

  Map<String, dynamic> toJson() => $HomeListToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class HomeListData {
  late String imgUrl;
  late String title;
  late String url;

  HomeListData();

  factory HomeListData.fromJson(Map<String, dynamic> json) =>
      $HomeListDataFromJson(json);

  Map<String, dynamic> toJson() => $HomeListDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
