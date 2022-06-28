import 'dart:math';

import 'package:dio/dio.dart';

int randomNumber(int min, int max) {
  int res = min + Random().nextInt(max - min + 1);
  return res;
}

String getVideoId(String htmlUrl) {
  String url = htmlUrl.substring("https://hanime1.me/watch?v=".length);
  return url;
}

Future<String> getM3u8Url(String url) async {
  Response response = await Dio().get(url);
  final res = response.data;

  if (res.contains("EXTINF")) {
    return url;
  } else {
    String baseUrl = url.substring(0, url.lastIndexOf("/") + 1);
    List<String> resList = res.split("\n");
    String tempM3u8 = resList.firstWhere(
        (element) => !element.contains("#") || element.contains("m3u8"));
    return baseUrl + tempM3u8;
  }
}

double doubleRemoveDecimal(double data, int offset) {
  String tempData = data.toStringAsFixed(offset);
  return double.parse(tempData);
}

double progress2showProgress(double data) {
  return 1 - data;
}
