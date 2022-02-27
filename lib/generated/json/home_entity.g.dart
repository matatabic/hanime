import 'package:hanime/entity/home_entity.dart';
import 'package:hanime/generated/json/base/json_convert_content.dart';

HomeEntity $HomeEntityFromJson(Map<String, dynamic> json) {
  final HomeEntity homeEntity = HomeEntity();
  final List<HomeSwiperList>? swiperList =
      jsonConvert.convertListNotNull<HomeSwiperList>(json['swiperList']);
  if (swiperList != null) {
    homeEntity.swiperList = swiperList;
  }
  final List<HomeList>? list =
      jsonConvert.convertListNotNull<HomeList>(json['List']);
  if (list != null) {
    homeEntity.list = list;
  }
  return homeEntity;
}

Map<String, dynamic> $HomeEntityToJson(HomeEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['swiperList'] = entity.swiperList.map((v) => v.toJson()).toList();
  data['List'] = entity.list.map((v) => v.toJson()).toList();
  return data;
}

HomeSwiperList $HomeSwiperListFromJson(Map<String, dynamic> json) {
  final HomeSwiperList homeSwiperList = HomeSwiperList();
  final String? imgUrl = jsonConvert.convert<String>(json['imgUrl']);
  if (imgUrl != null) {
    homeSwiperList.imgUrl = imgUrl;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    homeSwiperList.title = title;
  }
  final String? url = jsonConvert.convert<String>(json['url']);
  if (url != null) {
    homeSwiperList.url = url;
  }
  return homeSwiperList;
}

Map<String, dynamic> $HomeSwiperListToJson(HomeSwiperList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['imgUrl'] = entity.imgUrl;
  data['title'] = entity.title;
  data['url'] = entity.url;
  return data;
}

HomeList $HomeListFromJson(Map<String, dynamic> json) {
  final HomeList homeList = HomeList();
  final String? label = jsonConvert.convert<String>(json['label']);
  if (label != null) {
    homeList.label = label;
  }
  final List<HomeListData>? data =
      jsonConvert.convertListNotNull<HomeListData>(json['data']);
  if (data != null) {
    homeList.data = data;
  }
  return homeList;
}

Map<String, dynamic> $HomeListToJson(HomeList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['label'] = entity.label;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  return data;
}

HomeListData $HomeListDataFromJson(Map<String, dynamic> json) {
  final HomeListData homeListData = HomeListData();
  final String? imgUrl = jsonConvert.convert<String>(json['imgUrl']);
  if (imgUrl != null) {
    homeListData.imgUrl = imgUrl;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    homeListData.title = title;
  }
  final String? url = jsonConvert.convert<String>(json['url']);
  if (url != null) {
    homeListData.url = url;
  }
  return homeListData;
}

Map<String, dynamic> $HomeListDataToJson(HomeListData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['imgUrl'] = entity.imgUrl;
  data['title'] = entity.title;
  data['url'] = entity.url;
  return data;
}
