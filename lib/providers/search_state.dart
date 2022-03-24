import 'package:flutter/foundation.dart';

class Search {
  final String query;
  final int genreIndex;
  final int sortIndex;
  final int durationIndex;
  final dynamic year;
  final dynamic month;
  final bool broad;
  final List<String> tagList;
  final List<String> brandList;
  final String htmlUrl;

  Search(
      this.query,
      this.genreIndex,
      this.sortIndex,
      this.durationIndex,
      this.year,
      this.month,
      this.broad,
      this.tagList,
      this.brandList,
      this.htmlUrl);
}

class SearchState with ChangeNotifier, DiagnosticableTreeMixin {
  String _htmlUrl =
      "https://hanime1.me/search?query=&genre=全部&sort=无&duration=全部";
  String _query = "";
  int _genreIndex = 0;
  int _sortIndex = 0;
  int _durationIndex = 0;
  dynamic _year;
  dynamic _month;
  bool _broad = false;
  List<String> _tagList = [];
  List<String> _brandList = [];

  String get htmlUrl => _htmlUrl;
  String get query => _query;
  int get genreIndex => _genreIndex;
  int get sortIndex => _sortIndex;
  int get durationIndex => _durationIndex;
  dynamic get year => _year;
  dynamic get month => _month;
  bool get broad => _broad;
  List get tagList => _tagList;
  List get brandList => _brandList;
  List get searchList => _searchList;

  List<Search> _searchList = [
    Search("", 0, 0, 0, null, null, false, [], [],
        "https://hanime1.me/search?query=&genre=全部&sort=无&duration=全部")
    // {
    //   "query": "",
    //   "genreIndex": 0,
    //   "sortIndex": 0,
    //   "durationIndex": 0,
    //   "year": null,
    //   "month": null,
    //   "broad": false,
    //   "tagList": [],
    //   "brandList": []
    // }
  ];
  // .map((e) => Search("", 0, 0, 0, null, null, false, [], [], "")).toList();

  void setHtmlUrl(String data) {
    _htmlUrl = data;
    notifyListeners();
  }

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
    properties.add(StringProperty('htmlUrl', htmlUrl));
    properties.add(StringProperty('query', query));
    properties.add(IntProperty('genreIndex', genreIndex));
    properties.add(IntProperty('sortIndex', sortIndex));
    properties.add(IntProperty('durationIndex', durationIndex));
    properties.add(ObjectFlagProperty('year', year));
    properties.add(ObjectFlagProperty('month', month));
    properties.add(FlagProperty('broad', value: broad));
    properties.add(ObjectFlagProperty('tagList', tagList));
    properties.add(ObjectFlagProperty('brandList', brandList));
    properties.add(ObjectFlagProperty('searchList', searchList));
  }
}
