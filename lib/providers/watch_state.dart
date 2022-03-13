import 'package:flutter/foundation.dart';

class WatchState with ChangeNotifier, DiagnosticableTreeMixin {
  String _title = "";

  String get title => _title;

  void setTitle(String title) {
    _title = title;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('title', title));
  }
}
