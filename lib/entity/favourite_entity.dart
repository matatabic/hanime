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
  late String title;
  late String imageUrl;
  late String htmlUrl;

  FavouriteChildren();

  factory FavouriteChildren.fromJson(Map<String, dynamic> json) =>
      $FavouriteChildrenFromJson(json);

  Map<String, dynamic> toJson() => $FavouriteChildrenToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}