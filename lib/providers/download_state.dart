import 'package:flutter/foundation.dart';

class Downloading {
  late String htmlUrl;
  late double progress;
}

class Download {
  late String title;
  late String image;
  late String htmlUrl;
  late String saveDir;
  late String id;
  late double? progress;
  late bool success;
}

class DownloadState with ChangeNotifier, DiagnosticableTreeMixin {
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
  }
}
