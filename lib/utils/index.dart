import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

import 'dio_manage.dart';

int randomNumber(int min, int max) {
  int res = min + Random().nextInt(max - min + 1);
  return res;
}

Future<String> findBasePath(String htmlUrl) async {
  final directory = Platform.isAndroid
      ? await getExternalStorageDirectory()
      : await getApplicationDocumentsDirectory();

  String baseDir = directory!.path + '/video/';

  Directory root = Directory(baseDir);
  if (!root.existsSync()) {
    await root.create();
  }
  baseDir = baseDir + getVideoId(htmlUrl).toString();

  root = Directory(baseDir);
  if (!root.existsSync()) {
    await root.create();
  }

  return baseDir;
}

int getVideoId(String htmlUrl) {
  String id = htmlUrl.substring("https://hanime1.me/watch?v=".length);
  return int.parse(id);
}

Future<String> getM3u8Url(String url) async {
  Response response = await DioManage.get(url);
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

double doubleRemoveDecimal(dynamic data, int offset) {
  String tempData = data.toStringAsFixed(offset);
  return double.parse(tempData);
}

double progress2showProgress(double data) {
  return 1 - data;
}
