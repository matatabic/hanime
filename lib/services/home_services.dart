import 'package:dio/dio.dart';
import 'package:html/parser.dart' show parse;

class Anime {
  String url;
  String imgUrl;
  String title;
  Anime(this.url, this.imgUrl, this.title);
}

class HomeList {
  String label;
  List<Anime> data;
  HomeList(this.label, this.data);
}

class HomeData {
  List<Anime> swiperList;
  List<HomeList> dataList;
  HomeData(this.swiperList, this.dataList);
}

Future getHomeList() async {
  Response response = await Dio().get("https://hanime1.me");
  final res = response.data;
  var document = parse(res);
  List dataList = [];
  List swiperList = [];
  List tempData = [];
  List labels = document.querySelectorAll("#home-rows-wrapper h3");
  labels = labels.map((v) => v.firstChild.text).toList();

  List titles = document.querySelectorAll(".home-rows-videos-title");

  var groupCount = titles.length / labels.length;
  List images = document.querySelectorAll(".home-rows-videos-div img");

  List urls = document.querySelectorAll(".home-rows-videos-wrapper a");

  var tempNum = 0;
  var addSwiper = false;
  for (var image in images) {
    var imgUrl = image.attributes['src'];
    var temp = {
      "imgUrl": imgUrl,
      "title": titles[tempNum].text,
      "url": urls[tempNum].attributes['href']
    };
    if (addSwiper) {
      swiperList.add(temp);
      addSwiper = false;
    }
    if (imgUrl!.indexOf("E6mSQA2") == -1) {
      tempData.add(temp);
      tempNum++;
    } else {
      addSwiper = true;
    }
    if (tempData.length == groupCount) {
      dataList.add({"label": labels[dataList.length], "data": tempData});
      tempData = [];
    }
  }

  return {"swiperList": swiperList, "dataList": dataList};
}
