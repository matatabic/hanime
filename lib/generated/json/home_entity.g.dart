import 'package:hanime/entity/home_entity.dart';
import 'package:hanime/generated/json/base/json_convert_content.dart';

HomeEntity $HomeEntityFromJson(Map<String, dynamic> json) {
  final HomeEntity homeEntity = HomeEntity();
  final List<HomeSwiper>? swiper =
      jsonConvert.convertListNotNull<HomeSwiper>(json['swiper']);
  if (swiper != null) {
    homeEntity.swiper = swiper;
  }
  final List<HomeVideo>? video =
      jsonConvert.convertListNotNull<HomeVideo>(json['video']);
  if (video != null) {
    homeEntity.video = video;
  }
  return homeEntity;
}

Map<String, dynamic> $HomeEntityToJson(HomeEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['swiper'] = entity.swiper.map((v) => v.toJson()).toList();
  data['video'] = entity.video.map((v) => v.toJson()).toList();
  return data;
}

HomeSwiper $HomeSwiperFromJson(Map<String, dynamic> json) {
  final HomeSwiper homeSwiper = HomeSwiper();
  final String? imgUrl = jsonConvert.convert<String>(json['imgUrl']);
  if (imgUrl != null) {
    homeSwiper.imgUrl = imgUrl;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    homeSwiper.title = title;
  }
  final String? url = jsonConvert.convert<String>(json['url']);
  if (url != null) {
    homeSwiper.url = url;
  }
  return homeSwiper;
}

Map<String, dynamic> $HomeSwiperToJson(HomeSwiper entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['imgUrl'] = entity.imgUrl;
  data['title'] = entity.title;
  data['url'] = entity.url;
  return data;
}

HomeVideo $HomeVideoFromJson(Map<String, dynamic> json) {
  final HomeVideo homeVideo = HomeVideo();
  final String? label = jsonConvert.convert<String>(json['label']);
  if (label != null) {
    homeVideo.label = label;
  }
  final List<HomeVideoData>? data =
      jsonConvert.convertListNotNull<HomeVideoData>(json['data']);
  if (data != null) {
    homeVideo.data = data;
  }
  return homeVideo;
}

Map<String, dynamic> $HomeVideoToJson(HomeVideo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['label'] = entity.label;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  return data;
}

HomeVideoData $HomeVideoDataFromJson(Map<String, dynamic> json) {
  final HomeVideoData homeVideoData = HomeVideoData();
  final String? imgUrl = jsonConvert.convert<String>(json['imgUrl']);
  if (imgUrl != null) {
    homeVideoData.imgUrl = imgUrl;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    homeVideoData.title = title;
  }
  final String? url = jsonConvert.convert<String>(json['url']);
  if (url != null) {
    homeVideoData.url = url;
  }
  return homeVideoData;
}

Map<String, dynamic> $HomeVideoDataToJson(HomeVideoData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['imgUrl'] = entity.imgUrl;
  data['title'] = entity.title;
  data['url'] = entity.url;
  return data;
}
