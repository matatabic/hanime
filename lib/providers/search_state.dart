import 'package:flutter/foundation.dart';

class SearchState with ChangeNotifier, DiagnosticableTreeMixin {
  int _genreIndex = 0;
  int _sortIndex = 0;
  int _durationIndex = 0;
  List<String> _selectedTag = [];
  List<String> _selectedBrand = [];

  int get genreIndex => _genreIndex;
  int get sortIndex => _sortIndex;
  int get durationIndex => _durationIndex;
  List get selectedTag => _selectedTag;
  List get selectedBrand => _selectedBrand;

  void setGenreIndex(int index) {
    _genreIndex = index;
    notifyListeners();
  }

  void setSortIndex(int index) {
    _sortIndex = index;
    notifyListeners();
  }

  void setDurationIndex(int index) {
    _durationIndex = index;
    notifyListeners();
  }

  void selectedTagHandle(String title) {
    if (_selectedTag.indexOf(title) > -1) {
      _selectedTag.remove(title);
    } else {
      _selectedTag.add(title);
    }

    notifyListeners();
  }

  void selectedBrandHandle(String title) {
    if (_selectedBrand.indexOf(title) > -1) {
      _selectedBrand.remove(title);
    } else {
      _selectedBrand.add(title);
    }

    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('genreIndex', genreIndex));
    properties.add(IntProperty('sortIndex', sortIndex));
    properties.add(IntProperty('durationIndex', durationIndex));
    properties.add(ObjectFlagProperty('selectedTag', selectedTag));
    properties.add(ObjectFlagProperty('selectedBrand', selectedBrand));
  }
}
