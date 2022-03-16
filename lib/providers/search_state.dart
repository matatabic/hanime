import 'package:flutter/foundation.dart';

class SearchState with ChangeNotifier, DiagnosticableTreeMixin {
  String _htmlUrl = "";
  String _query = "";
  int _genreIndex = 0;
  int _sortIndex = 0;
  int _durationIndex = 0;
  dynamic _year;
  dynamic _month;
  bool _broad = false;
  List<String> _tagList = [];
  List<String> _brandList = [];

  String get query => _query;
  int get genreIndex => _genreIndex;
  int get sortIndex => _sortIndex;
  int get durationIndex => _durationIndex;
  dynamic get year => _year;
  dynamic get month => _month;
  bool get broad => _broad;
  List get tagList => _tagList;
  List get brandList => _brandList;

  void setQuery(String data) {
    _query = data;
    notifyListeners();
  }

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

  void setYear(String year) {
    _year = year;
    notifyListeners();
  }

  void setMonth(String month) {
    _month = month;
    notifyListeners();
  }

  void setBroadFlag(bool flag) {
    _broad = flag;
    notifyListeners();
  }

  void selectedTagHandle(String title) {
    if (_tagList.indexOf(title) > -1) {
      _tagList.remove(title);
    } else {
      _tagList.add(title);
    }

    notifyListeners();
  }

  void selectedBrandHandle(String title) {
    if (_brandList.indexOf(title) > -1) {
      _brandList.remove(title);
    } else {
      _brandList.add(title);
    }

    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('query', query));
    properties.add(IntProperty('genreIndex', genreIndex));
    properties.add(IntProperty('sortIndex', sortIndex));
    properties.add(IntProperty('durationIndex', durationIndex));
    properties.add(ObjectFlagProperty('year', year));
    properties.add(ObjectFlagProperty('month', month));
    properties.add(FlagProperty('broad', value: broad));
    properties.add(ObjectFlagProperty('tagList', tagList));
    properties.add(ObjectFlagProperty('brandList', brandList));
  }
}
