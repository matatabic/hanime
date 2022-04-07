import 'dart:convert';

import 'package:hanime/generated/json/base/json_field.dart';
import 'package:hanime/generated/json/home_entity.g.dart';

@JsonSerializable()
class HomeEntity {
  late List<HomeSwiper> swiper;
  late HomeTop top;
  late HomeLatest latest;
  late HomeFire fire;
  late HomeTag tag;
  late HomeHot hot;
  late HomeWatch watch;

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
  late String title;
  late String imgUrl;
  late String htmlUrl;

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
class HomeTop {
  late dynamic label;
  late dynamic labelHtml;
  late List<HomeTopVideo> video;

  HomeTop();

  factory HomeTop.fromJson(Map<String, dynamic> json) => $HomeTopFromJson(json);

  Map<String, dynamic> toJson() => $HomeTopToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class HomeTopVideo {
  late String title;
  late String imgUrl;
  late String htmlUrl;
  late bool latest;

  HomeTopVideo();

  factory HomeTopVideo.fromJson(Map<String, dynamic> json) =>
      $HomeTopVideoFromJson(json);

  Map<String, dynamic> toJson() => $HomeTopVideoToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class HomeLatest {
  late String label;
  late String labelHtml;
  late List<List<HomeLatestVideo>> video;

  HomeLatest();

  factory HomeLatest.fromJson(Map<String, dynamic> json) =>
      $HomeLatestFromJson(json);

  Map<String, dynamic> toJson() => $HomeLatestToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class HomeLatestVideo {
  late String title;
  late String imgUrl;
  late String htmlUrl;
  late String genre;
  late String author;
  late String created;
  late String duration;

  HomeLatestVideo();

  factory HomeLatestVideo.fromJson(Map<String, dynamic> json) =>
      $HomeLatestVideoFromJson(json);

  Map<String, dynamic> toJson() => $HomeLatestVideoToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class HomeFire {
  late String label;
  late String labelHtml;
  late List<HomeFireVideo> video;

  HomeFire();

  factory HomeFire.fromJson(Map<String, dynamic> json) =>
      $HomeFireFromJson(json);

  Map<String, dynamic> toJson() => $HomeFireToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class HomeFireVideo {
  late String title;
  late String imgUrl;
  late String htmlUrl;

  HomeFireVideo();

  factory HomeFireVideo.fromJson(Map<String, dynamic> json) =>
      $HomeFireVideoFromJson(json);

  Map<String, dynamic> toJson() => $HomeFireVideoToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class HomeTag {
  late String label;
  late String labelHtml;
  late List<List<HomeTagVideo>> video;

  HomeTag();

  factory HomeTag.fromJson(Map<String, dynamic> json) => $HomeTagFromJson(json);

  Map<String, dynamic> toJson() => $HomeTagToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class HomeTagVideo {
  late String title;
  late String imgUrl;
  late String htmlUrl;
  late String total;

  HomeTagVideo();

  factory HomeTagVideo.fromJson(Map<String, dynamic> json) =>
      $HomeTagVideoFromJson(json);

  Map<String, dynamic> toJson() => $HomeTagVideoToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class HomeHot {
  late String label;
  late String labelHtml;
  late List<HomeHotVideo> video;

  HomeHot();

  factory HomeHot.fromJson(Map<String, dynamic> json) => $HomeHotFromJson(json);

  Map<String, dynamic> toJson() => $HomeHotToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class HomeHotVideo {
  late String title;
  late String imgUrl;
  late String htmlUrl;

  HomeHotVideo();

  factory HomeHotVideo.fromJson(Map<String, dynamic> json) =>
      $HomeHotVideoFromJson(json);

  Map<String, dynamic> toJson() => $HomeHotVideoToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class HomeWatch {
  late String label;
  late String labelHtml;
  late List<HomeWatchVideo> video;

  HomeWatch();

  factory HomeWatch.fromJson(Map<String, dynamic> json) =>
      $HomeWatchFromJson(json);

  Map<String, dynamic> toJson() => $HomeWatchToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class HomeWatchVideo {
  late String title;
  late String imgUrl;
  late String htmlUrl;
  late String genre;
  late String author;
  late String created;
  late String duration;

  HomeWatchVideo();

  factory HomeWatchVideo.fromJson(Map<String, dynamic> json) =>
      $HomeWatchVideoFromJson(json);

  Map<String, dynamic> toJson() => $HomeWatchVideoToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
