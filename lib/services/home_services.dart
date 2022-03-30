import 'package:dio/dio.dart';
import 'package:html/parser.dart' show parse;

Future getHomeData() async {
  Response response = await Dio().get("https://hanime1.me");
  final res = response.data;
  var document = parse(res);
  List dataList = [];
  List videoList = [];
  List groupList = [];

  List videoElements = document.querySelectorAll(".owl-home-top-row a");

  for (var videoElement in videoElements) {
    videoList.add({
      "title": videoElement.querySelector(".owl-home-rows-title")!.text,
      "imgUrl": videoElement.querySelector("img")!.attributes['src'],
      "htmlUrl": videoElement.attributes['href']
    });
  }

  List groupElements =
      document.querySelectorAll(".hidden-ms.home-rows-margin-top");
  for (var groupElement in groupElements) {
    groupList.add({"label": groupElement.querySelector("h3")!.text});
  }
  print(groupList);
  // return {"swiper": swiperList, "video": dataList};
}
