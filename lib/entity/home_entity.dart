import 'dart:convert';

import 'package:hanime/generated/json/base/json_field.dart';
import 'package:hanime/generated/json/home_entity.g.dart';

@JsonSerializable()
class HomeHomeEntity {
  late String title;
  late String imgUrl;
  late String htmlUrl;
  late bool latest;

  HomeHomeEntity();

  factory HomeHomeEntity.fromJson(Map<String, dynamic> json) =>
      $HomeHomeEntityFromJson(json);

  Map<String, dynamic> toJson() => $HomeHomeEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
