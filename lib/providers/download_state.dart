import 'package:flutter/foundation.dart';
import 'package:hanime/entity/download_entity.dart';

class Downloading {}

class DownloadState with ChangeNotifier, DiagnosticableTreeMixin {
  List<int> _downloadQueueList = [];
  List<DownloadEntity> _downloadList = [];

  List<int> get downloadQueueList => _downloadQueueList;
  List<DownloadEntity> get downloadList => _downloadList;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
  }
}
