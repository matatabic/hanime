import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class WatchState with ChangeNotifier, DiagnosticableTreeMixin {
  String _title = "";

  String get title => _title;

  void setTitle(String title) {
    _title = title;
    notifyListeners();
  }

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('title', title));
  }
}
