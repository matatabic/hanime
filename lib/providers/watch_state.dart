import 'package:flutter/foundation.dart';

class WatchState with ChangeNotifier, DiagnosticableTreeMixin {
  String _title = "";
  dynamic _videoIndex;
  bool _loading = false;

  dynamic get videoIndex => _videoIndex;
  String get title => _title;
  bool get loading => _loading;

  void setTitle(String title) {
    _title = title;
    notifyListeners();
  }

  void setVideoIndex(int index) {
    _videoIndex = index;
    notifyListeners();
  }

  void setLoading(bool flag) {
    _loading = flag;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('title', title));
    properties.add(ObjectFlagProperty('videoIndex', videoIndex));
    properties.add(ObjectFlagProperty('loading', loading));
  }
}
