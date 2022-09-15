import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hanime/entity/favourite_entity.dart';
import 'package:hanime/entity/watch_entity.dart';
import 'package:hanime/utils/storage.dart';

class FavouriteModel with ChangeNotifier, DiagnosticableTreeMixin {
  // List<FavouriteEntity> _favouriteList = [
  //   FavouriteEntity.fromJson({
  //     "name": "我的收藏夹",
  //     "children": [
  //       {
  //         "imageUrl": "https://i.imgur.com/NeeUy2W.jpg",
  //         "htmlUrl": "12412412412",
  //         "title": "12412412412",
  //       },
  //       {
  //         "imageUrl": "https://i.imgur.com/NeeUy2W.jpg",
  //         "htmlUrl": "12412412412",
  //         "title": "12412412412",
  //       },
  //       {
  //         "imageUrl": "https://i.imgur.com/NeeUy2W.jpg",
  //         "htmlUrl": "12412412412",
  //         "title": "12412412412",
  //       }
  //     ]
  //   })
  // ];

  List<FavouriteEntity> _favouriteList = [
    FavouriteEntity.fromJson({
      "name": "我的收藏夹",
      "children": [
        {
          "name": "剧集1",
          "children": [
            {
              "imgUrl": "https://i.imgur.com/NeeUy2W.jpg",
              "htmlUrl": "124124162412",
              "title": "111111111",
            },
            {
              "imgUrl": "https://i.imgur.com/NeeUy2W.jpg",
              "htmlUrl": "124124124152",
              "title": "2222222222222",
            }
          ]
        },
        {
          "name": "剧集2",
          "children": [
            {
              "imgUrl": "https://i.imgur.com/NeeUy2W.jpg",
              "htmlUrl": "https://hanime1.me/watch?v=39231",
              "title": "33333333333333",
            },
          ]
        },
      ]
    })
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

  void saveAnime(List<WatchEpisode> episodeList, FavouriteEntity favourite) {
    // int index = _favouriteList.indexOf(favourite);
    // _favouriteList[index].children.insert(0, anime);
    // saveData(_favouriteList);
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
    // _favouriteList.forEach((element) {
    //   element.children.removeWhere((element) => element.htmlUrl == htmlUrl);
    // });
    saveData(_favouriteList);
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

  //判断是否已经收藏
  bool isFavouriteEpisode(List<WatchEpisode> episodeList) {
    return _favouriteList.any((element) => element.children.any((element) =>
        element.children.any((element) =>
            episodeList.any((episode) => episode.htmlUrl == element.htmlUrl))));
    // print(
    //     "isFavouriteisFavouriteisFavouriteisFavouriteisFavouriteisFavouriteisFavourite");
    // print(isFavourite);
    // print(
    //     "isFavouriteisFavouriteisFavouriteisFavouriteisFavouriteisFavouriteisFavourite");

    // _favouriteList.forEach((element) {
    //   element.children.removeWhere((element) => element.htmlUrl == htmlUrl);
    // });
    // saveData(_favouriteList);
    // notifyListeners();
  }

  //判断是否已经收藏
  void isFavouriteAnime(String htmlUrl, List<WatchEpisode> episodeList) {
    episodeList.any((element) => element.htmlUrl == htmlUrl);
    bool isFavourite = _favouriteList.any((element) => element.children.any(
        (element) =>
            element.children.any((element) => element.htmlUrl == htmlUrl)));
    print(
        "isFavouriteisFavouriteisFavouriteisFavouriteisFavouriteisFavouriteisFavourite");
    print(isFavourite);
    print(
        "isFavouriteisFavouriteisFavouriteisFavouriteisFavouriteisFavouriteisFavourite");
    // _favouriteList.forEach((element) {
    //   element.children.removeWhere((element) => element.htmlUrl == htmlUrl);
    // });
    // saveData(_favouriteList);
    // notifyListeners();
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
