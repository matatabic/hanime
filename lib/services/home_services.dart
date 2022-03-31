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

  var videoElements = document.querySelectorAll(".owl-home-top-row a"); //第一个

  for (var videoElement in videoElements) {
    temp.add({
      "title": videoElement.querySelector(".owl-home-rows-title")!.text,
      "imgUrl": videoElement.querySelector("img")!.attributes['src'],
      "htmlUrl": videoElement.attributes['href'],
      'latest ':
          videoElement.querySelector("ribbon-top-left") != null ? true : false,
    });
  }
  groupList.add(temp);

  var contentElements = document.querySelectorAll(".content-padding-new");
  var videos = contentElements[0].querySelectorAll(".item a");
  for (var video in videos) {
    temp.add({
      'title': video.querySelector('.owl-home-rows-title')!.text,
      "imgUrl": video.querySelector("img:nth-child(3)")!.attributes['src'],
      'htmlUrl': video.attributes['href'],
    });
  }

  groupList.add({
    "label": contentElements[0].querySelector(".home-rows-header h3")!.text,
    "labelHtml": contentElements[0]
        .querySelector(".home-rows-header")!
        .attributes['src'],
  });
  // for (var videoElement in videoElements) {
  //   var videos = videoElement.querySelectorAll("a");
  //   print("5555");
  //   for (var video in videos) {
  //     if (video.querySelector('.owl-home-rows-title') != null) {
  //       temp.add({
  //         'title': video.querySelector('.owl-home-rows-title')!.text,
  //         "imgUrl": video.querySelector("img")!.attributes['src'],
  //         'htmlUrl': video.attributes['href'],
  //         'latest ':
  //             video.querySelector("ribbon-top-left") != null ? true : false,
  //       });
  //     } else if (video.querySelector('.card-mobile-title') != null) {
  //       temp.add({
  //         'title': video.querySelector('.card-mobile-title')!.text,
  //         "htmlUrl": video.attributes['href'],
  //       });
  //     } else if (video.querySelector('.home-tags-title') != null) {
  //       temp.add({
  //         'title': video.querySelector('.home-tags-title')!.text,
  //         "htmlUrl": video.attributes['href'],
  //       });
  //     }
  //     groupList.add(temp);
  //     //   print(video.querySelector('.owl-home-rows-title').text);
  //     // } else {
  //     //   print(video.querySelector('.card-mobile-title').text);
  //     // }
  //
  //   }
  //   LogUtil.d(groupList);
  //   // print("videos.length");
  //   // print(videos.length);
  //   // if (videos.length == 0) {
  //   //   List items = videoElement.querySelectorAll("a");
  //   //   print("items.length");
  //   //   print(items.length);
  //   //   for (var item in items) {
  //   //     print(item.attributes['href']);
  //   //   }
  //   // }
  // }
  // List videoElements = document.querySelectorAll(".owl-home-top-row a");
  //
  // for (var videoElement in videoElements) {
  //   videoList.add({
  //     "title": videoElement.querySelector(".owl-home-rows-title")!.text,
  //     "imgUrl": videoElement.querySelector("img")!.attributes['src'],
  //     "htmlUrl": videoElement.attributes['href']
  //   });
  // }
//+.owl-home-row
//   List groupElements =
//       document.querySelectorAll(".content-padding-new:not(.hidden-sm)");

  // for (var groupElement in groupElements) {
  //   List aa = groupElement.querySelectorAll("a");
  //   for (var groupElement1 in aa) {
  //     print(groupElement1.attributes['href']);
  //   }
  // }

  // return {"swiper": swiperList, "video": dataList};
}
