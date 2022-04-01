import 'package:hanime/entity/home_entity.dart';
import 'package:hanime/generated/json/base/json_convert_content.dart';

HomeEntity $HomeEntityFromJson(Map<String, dynamic> json) {
  final HomeEntity homeEntity = HomeEntity();
  final List<HomeSwiper>? swiper =
      jsonConvert.convertListNotNull<HomeSwiper>(json['swiper']);
  if (swiper != null) {
    homeEntity.swiper = swiper;
  }
  final HomeTop? top = jsonConvert.convert<HomeTop>(json['top']);
  if (top != null) {
    homeEntity.top = top;
  }
  final HomeLatest? latest = jsonConvert.convert<HomeLatest>(json['latest']);
  if (latest != null) {
    homeEntity.latest = latest;
  }
  final HomeFire? fire = jsonConvert.convert<HomeFire>(json['fire']);
  if (fire != null) {
    homeEntity.fire = fire;
  }
  final HomeTag? tag = jsonConvert.convert<HomeTag>(json['tag']);
  if (tag != null) {
    homeEntity.tag = tag;
  }
  final HomeHot? hot = jsonConvert.convert<HomeHot>(json['hot']);
  if (hot != null) {
    homeEntity.hot = hot;
  }
  final HomeWatch? watch = jsonConvert.convert<HomeWatch>(json['watch']);
  if (watch != null) {
    homeEntity.watch = watch;
  }
  return homeEntity;
}

Map<String, dynamic> $HomeEntityToJson(HomeEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['swiper'] = entity.swiper.map((v) => v.toJson()).toList();
  data['top'] = entity.top.toJson();
  data['latest'] = entity.latest.toJson();
  data['fire'] = entity.fire.toJson();
  data['tag'] = entity.tag.toJson();
  data['hot'] = entity.hot.toJson();
  data['watch'] = entity.watch.toJson();
  return data;
}

HomeSwiper $HomeSwiperFromJson(Map<String, dynamic> json) {
  final HomeSwiper homeSwiper = HomeSwiper();
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    homeSwiper.title = title;
  }
  final String? imgUrl = jsonConvert.convert<String>(json['imgUrl']);
  if (imgUrl != null) {
    homeSwiper.imgUrl = imgUrl;
  }
  final String? htmlUrl = jsonConvert.convert<String>(json['htmlUrl']);
  if (htmlUrl != null) {
    homeSwiper.htmlUrl = htmlUrl;
  }
  return homeSwiper;
}

Map<String, dynamic> $HomeSwiperToJson(HomeSwiper entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['title'] = entity.title;
  data['imgUrl'] = entity.imgUrl;
  data['htmlUrl'] = entity.htmlUrl;
  return data;
}

HomeTop $HomeTopFromJson(Map<String, dynamic> json) {
  final HomeTop homeTop = HomeTop();
  final dynamic? label = jsonConvert.convert<dynamic>(json['label']);
  if (label != null) {
    homeTop.label = label;
  }
  final dynamic? labelHtml = jsonConvert.convert<dynamic>(json['labelHtml']);
  if (labelHtml != null) {
    homeTop.labelHtml = labelHtml;
  }
  final List<HomeTopVideo>? video =
      jsonConvert.convertListNotNull<HomeTopVideo>(json['video']);
  if (video != null) {
    homeTop.video = video;
  }
  return homeTop;
}

Map<String, dynamic> $HomeTopToJson(HomeTop entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['label'] = entity.label;
  data['labelHtml'] = entity.labelHtml;
  data['video'] = entity.video.map((v) => v.toJson()).toList();
  return data;
}

HomeTopVideo $HomeTopVideoFromJson(Map<String, dynamic> json) {
  final HomeTopVideo homeTopVideo = HomeTopVideo();
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    homeTopVideo.title = title;
  }
  final String? imgUrl = jsonConvert.convert<String>(json['imgUrl']);
  if (imgUrl != null) {
    homeTopVideo.imgUrl = imgUrl;
  }
  final String? htmlUrl = jsonConvert.convert<String>(json['htmlUrl']);
  if (htmlUrl != null) {
    homeTopVideo.htmlUrl = htmlUrl;
  }
  final bool? latest = jsonConvert.convert<bool>(json['latest']);
  if (latest != null) {
    homeTopVideo.latest = latest;
  }
  return homeTopVideo;
}

Map<String, dynamic> $HomeTopVideoToJson(HomeTopVideo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['title'] = entity.title;
  data['imgUrl'] = entity.imgUrl;
  data['htmlUrl'] = entity.htmlUrl;
  data['latest'] = entity.latest;
  return data;
}

HomeLatest $HomeLatestFromJson(Map<String, dynamic> json) {
  final HomeLatest homeLatest = HomeLatest();
  final String? label = jsonConvert.convert<String>(json['label']);
  if (label != null) {
    homeLatest.label = label;
  }
  final String? labelHtml = jsonConvert.convert<String>(json['labelHtml']);
  if (labelHtml != null) {
    homeLatest.labelHtml = labelHtml;
  }
  final List<List<HomeLatestVideoHomeLatestVideo>>? video = jsonConvert
      .convertListNotNull<List<HomeLatestVideoHomeLatestVideo>>(json['video']);
  if (video != null) {
    homeLatest.video = video;
  }
  return homeLatest;
}

Map<String, dynamic> $HomeLatestToJson(HomeLatest entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['label'] = entity.label;
  data['labelHtml'] = entity.labelHtml;
  data['video'] =
      entity.video.map((v) => v.map((val) => val.toJson())).toList();
  return data;
}

HomeLatestVideoHomeLatestVideo $HomeLatestVideoHomeLatestVideoFromJson(
    Map<String, dynamic> json) {
  final HomeLatestVideoHomeLatestVideo homeLatestVideoHomeLatestVideo =
      HomeLatestVideoHomeLatestVideo();
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    homeLatestVideoHomeLatestVideo.title = title;
  }
  final String? imgUrl = jsonConvert.convert<String>(json['imgUrl']);
  if (imgUrl != null) {
    homeLatestVideoHomeLatestVideo.imgUrl = imgUrl;
  }
  final String? htmlUrl = jsonConvert.convert<String>(json['htmlUrl']);
  if (htmlUrl != null) {
    homeLatestVideoHomeLatestVideo.htmlUrl = htmlUrl;
  }
  final String? genre = jsonConvert.convert<String>(json['genre']);
  if (genre != null) {
    homeLatestVideoHomeLatestVideo.genre = genre;
  }
  final String? author = jsonConvert.convert<String>(json['author']);
  if (author != null) {
    homeLatestVideoHomeLatestVideo.author = author;
  }
  final String? created = jsonConvert.convert<String>(json['created']);
  if (created != null) {
    homeLatestVideoHomeLatestVideo.created = created;
  }
  final String? duration = jsonConvert.convert<String>(json['duration']);
  if (duration != null) {
    homeLatestVideoHomeLatestVideo.duration = duration;
  }
  return homeLatestVideoHomeLatestVideo;
}

Map<String, dynamic> $HomeLatestVideoHomeLatestVideoToJson(
    HomeLatestVideoHomeLatestVideo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['title'] = entity.title;
  data['imgUrl'] = entity.imgUrl;
  data['htmlUrl'] = entity.htmlUrl;
  data['genre'] = entity.genre;
  data['author'] = entity.author;
  data['created'] = entity.created;
  data['duration'] = entity.duration;
  return data;
}

HomeFire $HomeFireFromJson(Map<String, dynamic> json) {
  final HomeFire homeFire = HomeFire();
  final String? label = jsonConvert.convert<String>(json['label']);
  if (label != null) {
    homeFire.label = label;
  }
  final String? labelHtml = jsonConvert.convert<String>(json['labelHtml']);
  if (labelHtml != null) {
    homeFire.labelHtml = labelHtml;
  }
  final List<HomeFireVideo>? video =
      jsonConvert.convertListNotNull<HomeFireVideo>(json['video']);
  if (video != null) {
    homeFire.video = video;
  }
  return homeFire;
}

Map<String, dynamic> $HomeFireToJson(HomeFire entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['label'] = entity.label;
  data['labelHtml'] = entity.labelHtml;
  data['video'] = entity.video.map((v) => v.toJson()).toList();
  return data;
}

HomeFireVideo $HomeFireVideoFromJson(Map<String, dynamic> json) {
  final HomeFireVideo homeFireVideo = HomeFireVideo();
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    homeFireVideo.title = title;
  }
  final String? imgUrl = jsonConvert.convert<String>(json['imgUrl']);
  if (imgUrl != null) {
    homeFireVideo.imgUrl = imgUrl;
  }
  final String? htmlUrl = jsonConvert.convert<String>(json['htmlUrl']);
  if (htmlUrl != null) {
    homeFireVideo.htmlUrl = htmlUrl;
  }
  return homeFireVideo;
}

Map<String, dynamic> $HomeFireVideoToJson(HomeFireVideo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['title'] = entity.title;
  data['imgUrl'] = entity.imgUrl;
  data['htmlUrl'] = entity.htmlUrl;
  return data;
}

HomeTag $HomeTagFromJson(Map<String, dynamic> json) {
  final HomeTag homeTag = HomeTag();
  final String? label = jsonConvert.convert<String>(json['label']);
  if (label != null) {
    homeTag.label = label;
  }
  final String? labelHtml = jsonConvert.convert<String>(json['labelHtml']);
  if (labelHtml != null) {
    homeTag.labelHtml = labelHtml;
  }
  final List<List<HomeTagVideoHomeTagVideo>>? video = jsonConvert
      .convertListNotNull<List<HomeTagVideoHomeTagVideo>>(json['video']);
  if (video != null) {
    homeTag.video = video;
  }
  return homeTag;
}

Map<String, dynamic> $HomeTagToJson(HomeTag entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['label'] = entity.label;
  data['labelHtml'] = entity.labelHtml;
  data['video'] =
      entity.video.map((v) => v.map((val) => val.toJson())).toList();
  return data;
}

HomeTagVideoHomeTagVideo $HomeTagVideoHomeTagVideoFromJson(
    Map<String, dynamic> json) {
  final HomeTagVideoHomeTagVideo homeTagVideoHomeTagVideo =
      HomeTagVideoHomeTagVideo();
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    homeTagVideoHomeTagVideo.title = title;
  }
  final String? imgUrl = jsonConvert.convert<String>(json['imgUrl']);
  if (imgUrl != null) {
    homeTagVideoHomeTagVideo.imgUrl = imgUrl;
  }
  final String? htmlUrl = jsonConvert.convert<String>(json['htmlUrl']);
  if (htmlUrl != null) {
    homeTagVideoHomeTagVideo.htmlUrl = htmlUrl;
  }
  final String? total = jsonConvert.convert<String>(json['total']);
  if (total != null) {
    homeTagVideoHomeTagVideo.total = total;
  }
  return homeTagVideoHomeTagVideo;
}

Map<String, dynamic> $HomeTagVideoHomeTagVideoToJson(
    HomeTagVideoHomeTagVideo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['title'] = entity.title;
  data['imgUrl'] = entity.imgUrl;
  data['htmlUrl'] = entity.htmlUrl;
  data['total'] = entity.total;
  return data;
}

HomeHot $HomeHotFromJson(Map<String, dynamic> json) {
  final HomeHot homeHot = HomeHot();
  final String? label = jsonConvert.convert<String>(json['label']);
  if (label != null) {
    homeHot.label = label;
  }
  final String? labelHtml = jsonConvert.convert<String>(json['labelHtml']);
  if (labelHtml != null) {
    homeHot.labelHtml = labelHtml;
  }
  final List<HomeHotVideo>? video =
      jsonConvert.convertListNotNull<HomeHotVideo>(json['video']);
  if (video != null) {
    homeHot.video = video;
  }
  return homeHot;
}

Map<String, dynamic> $HomeHotToJson(HomeHot entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['label'] = entity.label;
  data['labelHtml'] = entity.labelHtml;
  data['video'] = entity.video.map((v) => v.toJson()).toList();
  return data;
}

HomeHotVideo $HomeHotVideoFromJson(Map<String, dynamic> json) {
  final HomeHotVideo homeHotVideo = HomeHotVideo();
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    homeHotVideo.title = title;
  }
  final String? imgUrl = jsonConvert.convert<String>(json['imgUrl']);
  if (imgUrl != null) {
    homeHotVideo.imgUrl = imgUrl;
  }
  final String? htmlUrl = jsonConvert.convert<String>(json['htmlUrl']);
  if (htmlUrl != null) {
    homeHotVideo.htmlUrl = htmlUrl;
  }
  return homeHotVideo;
}

Map<String, dynamic> $HomeHotVideoToJson(HomeHotVideo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['title'] = entity.title;
  data['imgUrl'] = entity.imgUrl;
  data['htmlUrl'] = entity.htmlUrl;
  return data;
}

HomeWatch $HomeWatchFromJson(Map<String, dynamic> json) {
  final HomeWatch homeWatch = HomeWatch();
  final String? label = jsonConvert.convert<String>(json['label']);
  if (label != null) {
    homeWatch.label = label;
  }
  final String? labelHtml = jsonConvert.convert<String>(json['labelHtml']);
  if (labelHtml != null) {
    homeWatch.labelHtml = labelHtml;
  }
  final List<List<HomeWatchVideoHomeWatchVideo>>? video = jsonConvert
      .convertListNotNull<List<HomeWatchVideoHomeWatchVideo>>(json['video']);
  if (video != null) {
    homeWatch.video = video;
  }
  return homeWatch;
}

Map<String, dynamic> $HomeWatchToJson(HomeWatch entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['label'] = entity.label;
  data['labelHtml'] = entity.labelHtml;
  data['video'] =
      entity.video.map((v) => v.map((val) => val.toJson())).toList();
  return data;
}

HomeWatchVideoHomeWatchVideo $HomeWatchVideoHomeWatchVideoFromJson(
    Map<String, dynamic> json) {
  final HomeWatchVideoHomeWatchVideo homeWatchVideoHomeWatchVideo =
      HomeWatchVideoHomeWatchVideo();
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    homeWatchVideoHomeWatchVideo.title = title;
  }
  final String? imgUrl = jsonConvert.convert<String>(json['imgUrl']);
  if (imgUrl != null) {
    homeWatchVideoHomeWatchVideo.imgUrl = imgUrl;
  }
  final String? htmlUrl = jsonConvert.convert<String>(json['htmlUrl']);
  if (htmlUrl != null) {
    homeWatchVideoHomeWatchVideo.htmlUrl = htmlUrl;
  }
  final String? genre = jsonConvert.convert<String>(json['genre']);
  if (genre != null) {
    homeWatchVideoHomeWatchVideo.genre = genre;
  }
  final String? author = jsonConvert.convert<String>(json['author']);
  if (author != null) {
    homeWatchVideoHomeWatchVideo.author = author;
  }
  final String? created = jsonConvert.convert<String>(json['created']);
  if (created != null) {
    homeWatchVideoHomeWatchVideo.created = created;
  }
  final String? duration = jsonConvert.convert<String>(json['duration']);
  if (duration != null) {
    homeWatchVideoHomeWatchVideo.duration = duration;
  }
  return homeWatchVideoHomeWatchVideo;
}

Map<String, dynamic> $HomeWatchVideoHomeWatchVideoToJson(
    HomeWatchVideoHomeWatchVideo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['title'] = entity.title;
  data['imgUrl'] = entity.imgUrl;
  data['htmlUrl'] = entity.htmlUrl;
  data['genre'] = entity.genre;
  data['author'] = entity.author;
  data['created'] = entity.created;
  data['duration'] = entity.duration;
  return data;
}
