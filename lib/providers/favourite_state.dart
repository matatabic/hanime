import 'package:flutter/foundation.dart';

class FavouriteState with ChangeNotifier, DiagnosticableTreeMixin {
  List _favList = ["默认收藏夹f", "默认收藏夹a", "默认收藏夹w"];

  List get favList => _favList;

  void setFavList(int index) {
    _favList = [];
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty('favList', favList));
  }
}
