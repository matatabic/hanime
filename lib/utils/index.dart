import 'dart:math';

import 'package:hanime/pages/search/menu/duration_menu.dart';
import 'package:hanime/pages/search/menu/genre_menu.dart';
import 'package:hanime/pages/search/menu/sort_menu.dart';

int randomNumber(int min, int max) {
  int res = min + Random().nextInt(max - min + 1);
  return res;
}

String joinHtml(
    String query,
    int genreIndex,
    int sortIndex,
    int durationIndex,
    dynamic year,
    dynamic month,
    bool broadFlag,
    List<String> tagList,
    List<String> brandList) {
  var htmlUrl =
      "https://hanime1.me/search?query=$query&genre=${genre.data[genreIndex]}&sort=${sort.data[sortIndex]}&duration=${duration.data[durationIndex]}";

  if (broadFlag) {
    htmlUrl = "$htmlUrl&broad=on";
  }

  if (year != null) {
    htmlUrl = "$htmlUrl&year=$year";
    if (month != null) {
      htmlUrl = "$htmlUrl&month=$month";
    }
  }

  if (tagList.length > 0) {
    for (String tag in tagList) {
      htmlUrl = "$htmlUrl&tags[]=$tag";
    }
  }

  if (brandList.length > 0) {
    for (String brand in brandList) {
      htmlUrl = "$htmlUrl&brands[]=$brand";
    }
  }

  return htmlUrl;
}
