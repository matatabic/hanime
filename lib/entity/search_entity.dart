import 'dart:convert';

import 'package:hanime/generated/json/base/json_field.dart';
import 'package:hanime/generated/json/search_entity.g.dart';

@JsonSerializable()
class SearchEntity {
  late SearchGenre genre;
  late List<SearchTag> tag;
  late SearchDate date;
  late List<String> duration;
  late List<SearchVideo> video;

  SearchEntity();

  factory SearchEntity.fromJson(Map<String, dynamic> json) =>
      $SearchEntityFromJson(json);

  Map<String, dynamic> toJson() => $SearchEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class SearchGenre {
  late String label;
  late List<String> genre;

  SearchGenre();

  factory SearchGenre.fromJson(Map<String, dynamic> json) =>
      $SearchGenreFromJson(json);

  Map<String, dynamic> toJson() => $SearchGenreToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class SearchTag {
  late String label;
  late List<String> group;

  SearchTag();

  factory SearchTag.fromJson(Map<String, dynamic> json) =>
      $SearchTagFromJson(json);

  Map<String, dynamic> toJson() => $SearchTagToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class SearchDate {
  late List<String> year;
  late List<String> month;

  SearchDate();

  factory SearchDate.fromJson(Map<String, dynamic> json) =>
      $SearchDateFromJson(json);

  Map<String, dynamic> toJson() => $SearchDateToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class SearchVideo {
  late String title;
  late String imgUrl;
  late String htmlUrl;
  late String author;

  SearchVideo();

  factory SearchVideo.fromJson(Map<String, dynamic> json) =>
      $SearchVideoFromJson(json);

  Map<String, dynamic> toJson() => $SearchVideoToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
