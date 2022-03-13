import 'package:flutter/foundation.dart';

class SearchState with ChangeNotifier, DiagnosticableTreeMixin {
  int _genreIndex = 0;

  int get genreIndex => _genreIndex;

  void setGenreIndex(int index) {
    _genreIndex = index;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('genreIndex', genreIndex));
  }
}
