import 'dart:convert';

import 'package:hanime/entity/download_entity.dart';
import 'package:hanime/entity/favourite_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 本地存储
class StorageUtil {
  static getCache(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(name);
    // print("getCache: $json");
    // return json;
  }

  static Future<void> setFavouriteCache(List<FavouriteEntity> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
        "favouriteList", jsonEncode(data.map((v) => v.toJson()).toList()));
  }

  static Future<void> setDownloadCache(List<DownloadEntity> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
        "downloadList", jsonEncode(data.map((v) => v.toCacheJson()).toList()));
  }
}
