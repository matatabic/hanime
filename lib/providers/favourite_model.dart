import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hanime/entity/favourite_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteModel with ChangeNotifier, DiagnosticableTreeMixin {
  List<FavouriteEntity> _favouriteList = [
    FavouriteEntity.fromJson({"name": "我的收藏夹", "children": []})
  ];

  List<FavouriteEntity> get favouriteList => _favouriteList;

  void orderItem(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    var movedItem =
        _favouriteList[oldListIndex].children.removeAt(oldItemIndex);
    _favouriteList[newListIndex].children.insert(newItemIndex, movedItem);
    saveData(_favouriteList);
    print(_favouriteList);
    notifyListeners();
  }

  void orderList(int oldListIndex, int newListIndex) {
    var movedList = _favouriteList.removeAt(oldListIndex);
    _favouriteList.insert(newListIndex, movedList);
    saveData(_favouriteList);
    notifyListeners();
  }

  void addList(String name) {
    _favouriteList
        .add(FavouriteEntity.fromJson({"name": "$name", "children": []}));
    saveData(_favouriteList);
    notifyListeners();
  }

  void saveAnime(FavouriteChildren anime, FavouriteEntity favourite) {
    int index = _favouriteList.indexOf(favourite);
    _favouriteList[index].children.insert(0, anime);
    saveData(_favouriteList);
    notifyListeners();
  }

  void removeList(FavouriteEntity favourite) {
    int index = _favouriteList.indexOf(favourite);
    _favouriteList.removeAt(index);
    saveData(_favouriteList);
    notifyListeners();
  }

  void removeItem(FavouriteChildren anime) {
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

  void getCache() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // var json = prefs.getString("favouriteList");
    // if (json != null) {
    //   _favouriteList = jsonDecode(json)
    //       .map<FavouriteEntity>((json) => FavouriteEntity.fromJson(json))
    //       .toList();
    // }
    _favouriteList = [
      FavouriteEntity.fromJson({
        "name": "我的收藏夹",
        "children": [
          {
            "title": "[JXH33] 早坂愛 [輝夜姬想讓人告白～天才們的戀愛頭腦戰～]",
            "imageUrl": "https://i.imgur.com/QHezhRL.jpg",
            "htmlUrl": "https://hanime1.me/watch?v=38240"
          },
          {
            "title": "[yuukis] 藤原千花 [輝夜姬想讓人告白～天才們的戀愛頭腦戰～]",
            "imageUrl": "https://i.imgur.com/QHezhRL.jpg",
            "htmlUrl": "https://hanime1.me/watch?v=38680"
          }
        ]
      })
    ];
  }

  saveData(List<FavouriteEntity> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
        "favouriteList", jsonEncode(data.map((v) => v.toJson()).toList()));
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty('favouriteList', _favouriteList));
  }
}