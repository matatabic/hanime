import 'package:hanime/entity/download_entity.dart';
import 'package:hanime/generated/json/base/json_convert_content.dart';

DownloadEntity $DownloadEntityFromJson(Map<String, dynamic> json) {
  final DownloadEntity downloadEntity = DownloadEntity();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    downloadEntity.id = id;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    downloadEntity.title = title;
  }
  final String? imageUrl = jsonConvert.convert<String>(json['imageUrl']);
  if (imageUrl != null) {
    downloadEntity.imageUrl = imageUrl;
  }
  final String? htmlUrl = jsonConvert.convert<String>(json['htmlUrl']);
  if (htmlUrl != null) {
    downloadEntity.htmlUrl = htmlUrl;
  }
  final String? saveDir = jsonConvert.convert<String>(json['saveDir']);
  if (saveDir != null) {
    downloadEntity.saveDir = saveDir;
  }
  final double? progress = jsonConvert.convert<double>(json['progress']);
  if (progress != null) {
    downloadEntity.progress = progress;
  }
  final bool? success = jsonConvert.convert<bool>(json['success']);
  if (success != null) {
    downloadEntity.success = success;
  }
  return downloadEntity;
}

Map<String, dynamic> $DownloadEntityToJson(DownloadEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['title'] = entity.title;
  data['imageUrl'] = entity.imageUrl;
  data['htmlUrl'] = entity.htmlUrl;
  data['saveDir'] = entity.saveDir;
  data['progress'] = entity.progress;
  data['success'] = entity.success;
  return data;
}
