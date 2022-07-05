import 'package:hanime/entity/download_entity.dart';
import 'package:hanime/generated/json/base/json_convert_content.dart';

DownloadEntity $DownloadEntityFromJson(Map<String, dynamic> json) {
  final DownloadEntity downloadEntity = DownloadEntity();
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
  final String? videoUrl = jsonConvert.convert<String>(json['videoUrl']);
  if (videoUrl != null) {
    downloadEntity.videoUrl = videoUrl;
  }
  final String? localVideoUrl =
      jsonConvert.convert<String>(json['localVideoUrl']);
  if (localVideoUrl != null) {
    downloadEntity.localVideoUrl = localVideoUrl;
  }
  final double? progress = jsonConvert.convert<double>(json['progress']);
  if (progress != null) {
    downloadEntity.progress = progress;
  }
  final bool? success = jsonConvert.convert<bool>(json['success']);
  if (success != null) {
    downloadEntity.success = success;
  }
  final bool? downloading = jsonConvert.convert<bool>(json['downloading']);
  if (downloading != null) {
    downloadEntity.downloading = downloading;
  }
  final bool? waitDownload = jsonConvert.convert<bool>(json['waitDownload']);
  if (waitDownload != null) {
    downloadEntity.waitDownload = waitDownload;
  }
  final bool? reTry = jsonConvert.convert<bool>(json['reTry']);
  if (reTry != null) {
    downloadEntity.reTry = reTry;
  }
  final int? reTryTime = jsonConvert.convert<int>(json['reTryTime']);
  if (reTryTime != null) {
    downloadEntity.reTryTime = reTryTime;
  }
  return downloadEntity;
}

Map<String, dynamic> $DownloadEntityToJson(DownloadEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['title'] = entity.title;
  data['imageUrl'] = entity.imageUrl;
  data['htmlUrl'] = entity.htmlUrl;
  data['videoUrl'] = entity.videoUrl;
  data['localVideoUrl'] = entity.localVideoUrl;
  data['progress'] = entity.progress;
  data['success'] = entity.success;
  data['downloading'] = entity.downloading;
  data['waitDownload'] = entity.waitDownload;
  data['reTry'] = entity.reTry;
  data['reTryTime'] = entity.reTryTime;
  return data;
}

Map<String, dynamic> $DownloadEntityToCacheJson(DownloadEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['title'] = entity.title;
  data['imageUrl'] = entity.imageUrl;
  data['htmlUrl'] = entity.htmlUrl;
  data['videoUrl'] = entity.videoUrl;
  data['localVideoUrl'] = entity.localVideoUrl;
  data['progress'] = entity.progress;
  data['success'] = entity.success;
  data['downloading'] = false;
  data['waitDownload'] = false;
  data['reTry'] = false;
  data['reTryTime'] = 0;
  return data;
}
