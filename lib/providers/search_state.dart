import 'package:flutter/foundation.dart';

class Search {
  late String query;
  late int genreIndex;
  late int sortIndex;
  late int durationIndex;
  late dynamic year;
  late dynamic month;
  late bool broad;
  late List<String> tagList;
  late List<String> brandList;
  late String htmlUrl;

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
  // int _genreIndex = 0;
  int _sortIndex = 0;
  int _durationIndex = 0;
  dynamic _year;
  dynamic _month;
  bool _broad = false;
  List<String> _tagList = [];
  List<String> _brandList = [];
  int _currentScreen = 0;

  String get htmlUrl => _htmlUrl;
  String get query => _query;
  // int get genreIndex => _genreIndex;
  int get sortIndex => _sortIndex;
  int get durationIndex => _durationIndex;
  dynamic get year => _year;
  dynamic get month => _month;
  bool get broad => _broad;
  List get tagList => _tagList;
  List get brandList => _brandList;
  List get searchList => _searchList;
  int get currentScreen => _currentScreen;

  List<Search> _searchList = [
    Search("", 0, 0, 0, null, null, false, [], [],
        "https://hanime1.me/search?query=")
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

  void setHtmlUrl(int currentScreen, String data) {
    _searchList[currentScreen].htmlUrl = data;
    notifyListeners();
  }

  void setQuery(int currentScreen, String data) {
    _searchList[currentScreen].query = data;
    notifyListeners();
  }

  void setGenreIndex(int currentScreen, int index) {
    _searchList[currentScreen].genreIndex = index;
    notifyListeners();
  }

  void setSortIndex(int currentScreen, int index) {
    _searchList[currentScreen].sortIndex = index;
    notifyListeners();
  }

  void setDurationIndex(int currentScreen, int index) {
    _searchList[currentScreen].durationIndex = index;
    notifyListeners();
  }

  void setYear(int currentScreen, String year) {
    _searchList[currentScreen].year = year;
    notifyListeners();
  }

  void setMonth(int currentScreen, String month) {
    _searchList[currentScreen].month = month;
    notifyListeners();
  }

  void setBroadFlag(int currentScreen, bool flag) {
    _searchList[currentScreen].broad = flag;
    notifyListeners();
  }

  void selectedTagHandle(int currentScreen, String title) {
    if (_searchList[currentScreen].tagList.indexOf(title) > -1) {
      _searchList[currentScreen].tagList.remove(title);
    } else {
      _searchList[currentScreen].tagList.add(title);
    }

    notifyListeners();
  }

  void selectedBrandHandle(int currentScreen, String title) {
    if (_searchList[currentScreen].brandList.indexOf(title) > -1) {
      _searchList[currentScreen].brandList.remove(title);
    } else {
      _searchList[currentScreen].brandList.add(title);
    }

    notifyListeners();
  }

  void addSearchList(String tag, String htmlUrl) {
    _searchList.add(Search("", 0, 0, 0, null, null, false, [tag], [], htmlUrl));
    _currentScreen = _currentScreen + 1;
    notifyListeners();
  }

  void removeSearchList() {
    _searchList.removeLast();
    _currentScreen = _currentScreen - 1;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty('searchList', searchList));
  }
}
