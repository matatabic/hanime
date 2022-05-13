import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hanime/entity/favourite.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteState with ChangeNotifier, DiagnosticableTreeMixin {
  List<Favourite> _favouriteList = [];

  List<Favourite> get favouriteList => _favouriteList;

  void orderItem(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    var movedItem =
        _favouriteList[oldListIndex].children.removeAt(oldItemIndex);
    _favouriteList[newListIndex].children.insert(newItemIndex, movedItem);
    saveData(_favouriteList);
    notifyListeners();
  }

  void orderList(int oldListIndex, int newListIndex) {
    var movedList = _favouriteList.removeAt(oldListIndex);
    _favouriteList.insert(newListIndex, movedList);
    saveData(_favouriteList);
    notifyListeners();
  }

  void addList(String name) {
    _favouriteList.add(Favourite(name: name, children: []));
    saveData(_favouriteList);
    notifyListeners();
  }

  void saveAnime(Anime anime, Favourite favourite) {
    int index = _favouriteList.indexOf(favourite);
    _favouriteList[index].children.insert(0, anime);
    saveData(_favouriteList);
    notifyListeners();
  }

  void removeList(Favourite favourite) {
    int index = _favouriteList.indexOf(favourite);
    _favouriteList.removeAt(index);
    saveData(_favouriteList);
    notifyListeners();
  }

  void removeItem(Anime anime) {
    int index = _favouriteList
        .indexWhere((favourite) => favourite.children.contains(anime));
    _favouriteList[index].children.remove(anime);
    saveData(_favouriteList);
    notifyListeners();
  }

  void removeItemByHtmlUrl(String htmlUrl) {
    _favouriteList.forEach((element) {
      element.children.removeWhere((element) => element.htmlUrl == htmlUrl);
    });
    saveData(_favouriteList);
    notifyListeners();
  }

  saveData(List<Favourite> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("favouriteList", json.encode(data.toList()));
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty('favouriteList', _favouriteList));
  }
}
