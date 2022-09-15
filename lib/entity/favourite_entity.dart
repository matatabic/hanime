import 'dart:convert';

import 'package:hanime/generated/json/base/json_field.dart';
import 'package:hanime/generated/json/favourite_entity.g.dart';

@JsonSerializable()
class FavouriteEntity {
  late String name;
  late List<FavouriteChildren> children;

  FavouriteEntity();

  factory FavouriteEntity.fromJson(Map<String, dynamic> json) =>
      $FavouriteEntityFromJson(json);

  Map<String, dynamic> toJson() => $FavouriteEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class FavouriteChildren {
  late String name;
  late List<FavouriteChildrenChildren> children;

  FavouriteChildren();

  factory FavouriteChildren.fromJson(Map<String, dynamic> json) =>
      $FavouriteChildrenFromJson(json);

  Map<String, dynamic> toJson() => $FavouriteChildrenToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class FavouriteChildrenChildren {
  late String title;
  late String htmlUrl;
  late String imgUrl;

  FavouriteChildrenChildren();

  factory FavouriteChildrenChildren.fromJson(Map<String, dynamic> json) =>
      $FavouriteChildrenChildrenFromJson(json);

  Map<String, dynamic> toJson() => $FavouriteChildrenChildrenToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
