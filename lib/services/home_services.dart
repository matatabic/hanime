import 'package:dio/dio.dart';
import 'package:html/parser.dart' show parse;

Future getHomeData() async {
  Response response = await Dio().get("https://hanime1.me");
  final res = response.data;
  var document = parse(res);
  List dataList = [];
  List videoList = [];
  List groupList = [];
  List temp = [];

  List videoElements = document.querySelectorAll(".owl-home-top-row a");

  for (var videoElement in videoElements) {
    videoList.add({
      "title": videoElement.querySelector(".owl-home-rows-title")!.text,
      "imgUrl": videoElement.querySelector("img")!.attributes['src'],
      "htmlUrl": videoElement.attributes['href']
    });
  }
//+.owl-home-row
  List groupElements =
      document.querySelectorAll(".content-padding-new:not(.hidden-sm)");
  // print(groupElements);
  // for (var groupElement in groupElements) {
  //   List aa = groupElement.querySelectorAll("a");
  //   for (var groupElement1 in aa) {
  //     print(groupElement1.attributes['href']);
  //   }
  // }
  for (var groupElement in groupElements) {
    groupList.add({"label": groupElement.querySelector("h3")!.text});
    List contentElements = groupElement.querySelectorAll(".card-mobile-panel");

    if (contentElements.length > 0) {
      for (var contentElement in contentElements) {
        // print(contentElement.querySelector("a").attributes['href']);
      }
    } else if (groupElement.querySelector("+.owl-home-row") > 0) {}
  }
  // print(groupList);
  // return {"swiper": swiperList, "video": dataList};
}
