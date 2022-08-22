import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

import '../request/dio_manage.dart';

class Utils {
  static int randomNumber(int min, int max) {
    int res = min + Random().nextInt(max - min + 1);
    return res;
  }

  static Future<String> findBasePath(String htmlUrl) async {
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

  static Future<dynamic> deleteVideo(String htmlUrl) async {
    final directory = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();

    String baseDir =
        directory!.path + '/video/' + getVideoId(htmlUrl).toString();

    Directory root = Directory(baseDir);
    if (root.existsSync()) {
      await root.delete(recursive: true);
    }
  }

  static int getVideoId(String htmlUrl) {
    String id = htmlUrl.substring("https://hanime1.me/watch?v=".length);
    return int.parse(id);
  }

  static Future<String> getM3u8Url(String url) async {
    Response? response = await DioManage.get(url);
    final res = response?.data;

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

  static double doubleRemoveDecimal(dynamic data, int offset) {
    String tempData = data.toStringAsFixed(offset);
    return double.parse(tempData);
  }

  static double progress2showProgress(double data) {
    return 1 - data;
  }

  static List<String> getUrlParamsByName(String url, String name) {
    List<String> res = [];
    if (url.contains("?")) {
      String temp = url.substring(url.indexOf("?") + 1);
      List<String> tempList = temp.split("&");
      for (String item in tempList) {
        if (item.contains(name)) {
          res.add(item.substring(item.indexOf("=") + 1));
        }
      }
    }
    return res;
  }

  static String urlAddAllTagParams(String url, List<String> tagList) {
    String res = url;
    for (String tag in tagList) {
      res = res + "&tags[]=" + tag;
    }
    return res;
  }

  static Function debounce(
    Function func, [
    Duration delay = const Duration(milliseconds: 1000),
  ]) {
    Timer? timer;
    Function target = () {
      if (timer?.isActive ?? false) {
        timer?.cancel();
      }
      timer = Timer(delay, () {
        func.call();
      });
    };
    return target;
  }
}

class CommonUtil {
  static const deFaultDurationTime = 5000;
  static Timer? timer;

  // 防抖函数
  static debounce(Function doSomething, {durationTime = deFaultDurationTime}) {
    timer?.cancel();
    timer = new Timer(Duration(milliseconds: durationTime), () {
      doSomething.call();
      timer = null;
    });
  }

  // 节流函数
  static const String deFaultThrottleId = 'DeFaultThrottleId';
  static Map<String, int> startTimeMap = {deFaultThrottleId: 0};
  static throttle(Function doSomething,
      {String throttleId = deFaultThrottleId,
      durationTime = deFaultDurationTime,
      Function? continueClick}) {
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    if (currentTime - (startTimeMap[throttleId] ?? 0) > durationTime) {
      doSomething.call();
      startTimeMap[throttleId] = DateTime.now().millisecondsSinceEpoch;
    } else {
      continueClick?.call();
    }
  }
}
