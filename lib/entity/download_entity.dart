import 'dart:convert';

import 'package:hanime/generated/json/base/json_field.dart';
import 'package:hanime/generated/json/download_entity.g.dart';

@JsonSerializable()
class DownloadEntity {
  late int id;
  late String title;
  late String imageUrl;
  late String htmlUrl;
  late String videoUrl;
  late String baseDir;
  late double progress;
  late bool success;
  late bool needDownload;

  DownloadEntity();

  factory DownloadEntity.fromJson(Map<String, dynamic> json) =>
      $DownloadEntityFromJson(json);

  Map<String, dynamic> toJson() => $DownloadEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
