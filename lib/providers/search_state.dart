import 'package:flutter/foundation.dart';

class SearchState with ChangeNotifier, DiagnosticableTreeMixin {
  int _genreIndex = 0;
  List<String> _selectedTag = [];

  int get genreIndex => _genreIndex;

  void setGenreIndex(int index) {
    _genreIndex = index;
    notifyListeners();
  }

  List get selectedTag => _selectedTag;

  void selectedTagHandle(String title) {
    if (_selectedTag.indexOf(title) > -1) {
      _selectedTag.remove(title);
    } else {
      _selectedTag.add(title);
    }

    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('genreIndex', genreIndex));
    properties.add(ObjectFlagProperty('selectedTag', selectedTag));
  }
}
