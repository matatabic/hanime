import 'package:flutter/foundation.dart';

class HomeModel with ChangeNotifier, DiagnosticableTreeMixin {
  int _swiperIndex = 0;

  int get swiperIndex => _swiperIndex;

  void setIndex(int index) {
    _swiperIndex = index;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('swiperIndex', swiperIndex));
  }
}
