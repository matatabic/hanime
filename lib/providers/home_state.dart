import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class HomeState with ChangeNotifier, DiagnosticableTreeMixin {
  int _swiper_index = 0;

  int get swiper_index => _swiper_index;

  void setIndex(int index) {
    _swiper_index = index;
    notifyListeners();
  }

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('swiper_index', swiper_index));
  }
}
