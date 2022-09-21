import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hanime/entity/favourite_entity.dart';
import 'package:hanime/entity/watch_entity.dart';
import 'package:hanime/utils/storage.dart';
import 'package:hanime/utils/utils.dart';

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

  void addAnimeByFavIndex(WatchInfo watchInfo, int favIndex) {
    print(watchInfo);
    _favouriteList[favIndex].children.insert(
        0,
        FavouriteChildren.fromJson({
          "name": "${watchInfo.title}",
          "children": [
            FavouriteChildrenChildren.fromJson({
              "id": Utils.getVideoId(watchInfo.htmlUrl),
              "imgUrl": watchInfo.imgUrl,
              "htmlUrl": watchInfo.htmlUrl,
              "title": watchInfo.shareTitle
            })
          ]
        }));

    notifyListeners();
  }

  void addAnime(WatchInfo watchInfo) {
    print(favouriteList);
    findFavouriteEpisodeIndex(watchInfo);
    // int episodeIndex = _favouriteList[favIndex]
    //     .children
    //     .indexWhere((element) => element.name == favourite.title);
    // _favouriteList[favIndex].children[episodeIndex].children.insert(
    //     0,
    //     FavouriteChildrenChildren.fromJson({
    //       "imageUrl": favourite.imgUrl,
    //       "htmlUrl": favourite.htmlUrl,
    //       "title": favourite.title
    //     }));
    // print(index);
    // print(favIndex);

    // int index = _favouriteList.indexOf(favourite);
    // _favouriteList[index].children.insert(0, anime);
    // saveData(_favouriteList);
    // notifyListeners();
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
      element.children.forEach((anime) {
        anime.children.removeWhere((episode) => episode.htmlUrl == htmlUrl);
      });
    });
    // saveData(_favouriteList);
    notifyListeners();
  }

  void getCache() async {
    var json = await StorageUtil.getCache("favouriteList");
    if (json != null) {
      _favouriteList = jsonDecode(json)
          .map<FavouriteEntity>((json) => FavouriteEntity.fromJson(json))
          .toList();
    }
  }

  dynamic findFavouriteEpisodeIndex(WatchInfo info) {
    for (var i = 0; i < _favouriteList.length; i++) {
      for (var j = 0; j < _favouriteList[i].children.length; j++) {
        if (_favouriteList[i].children[j].name == info.title) {
          for (var k = 0;
              k < _favouriteList[i].children[j].children.length;
              k++) {
            if (_favouriteList[i].children[j].children[k].htmlUrl ==
                info.htmlUrl) {
              return [i, j, k];
            }
          }
          print("找到了");
          print([i, j]);
          // return [i, j];
        }
      }
    }
  }

  //判断是否已经收藏
  bool isFavouriteEpisode(List<WatchEpisode> episodeList, WatchInfo info) {
    bool isFavourite = _favouriteList.any((element) =>
        element.children.any((element) => element.name == info.title));
    return isFavourite;
  }

  //判断是否已经收藏
  bool isFavouriteAnime(String htmlUrl) {
    bool isFavourite = _favouriteList.any((element) => element.children.any(
        (element) =>
            element.children.any((element) => element.htmlUrl == htmlUrl)));
    print(_favouriteList);
    print("判断是否已经收藏");
    return isFavourite;
  }

  saveData(List<FavouriteEntity> data) {
    StorageUtil.setFavouriteCache(data);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty('favouriteList', _favouriteList));
  }
}
