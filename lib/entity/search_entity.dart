import 'dart:convert';

import 'package:hanime/generated/json/base/json_field.dart';
import 'package:hanime/generated/json/search_entity.g.dart';

@JsonSerializable()
class SearchEntity {
  late SearchGenre genre;
  late SearchTag tag;
  late SearchBrand brand;
  late SearchSort sort;
  late SearchDate date;
  late SearchDuration duration;
  late List<SearchVideo> video;
  late int page;

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
  late List<String> data;

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
  late List<SearchTagData> data;

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
class SearchTagData {
  late String label;
  late List<String> data;

  SearchTagData();

  factory SearchTagData.fromJson(Map<String, dynamic> json) =>
      $SearchTagDataFromJson(json);

  Map<String, dynamic> toJson() => $SearchTagDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class SearchBrand {
  late String label;
  late List<String> data;

  SearchBrand();

  factory SearchBrand.fromJson(Map<String, dynamic> json) =>
      $SearchBrandFromJson(json);

  Map<String, dynamic> toJson() => $SearchBrandToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class SearchSort {
  late String label;
  late List<String> data;

  SearchSort();

  factory SearchSort.fromJson(Map<String, dynamic> json) =>
      $SearchSortFromJson(json);

  Map<String, dynamic> toJson() => $SearchSortToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class SearchDate {
  late String label;
  late SearchDateData data;

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
class SearchDateData {
  late List<String> year;
  late List<String> month;

  SearchDateData();

  factory SearchDateData.fromJson(Map<String, dynamic> json) =>
      $SearchDateDataFromJson(json);

  Map<String, dynamic> toJson() => $SearchDateDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class SearchDuration {
  late String label;
  late List<String> data;

  SearchDuration();

  factory SearchDuration.fromJson(Map<String, dynamic> json) =>
      $SearchDurationFromJson(json);

  Map<String, dynamic> toJson() => $SearchDurationToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class SearchVideo {
  late String title;
  late String imgUrl;
  late String duration;
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
