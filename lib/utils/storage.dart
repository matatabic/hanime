import 'dart:convert';

import 'package:hanime/entity/download_entity.dart';
import 'package:hanime/entity/favourite_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 本地存储
class StorageUtil {
  static Future<dynamic> getFavouriteCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var json = prefs.getString("favouriteList");

    return json;
  }

  static Future<void> setFavouriteCache(List<FavouriteEntity> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
        "favouriteList", jsonEncode(data.map((v) => v.toJson()).toList()));
  }

  static Future<dynamic> getDownloadCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var json = prefs.getString("downloadList");

    return json;
  }

  static Future<void> setDownloadCache(List<DownloadEntity> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
        "downloadList", jsonEncode(data.map((v) => v.toCacheJson()).toList()));
  }
}
