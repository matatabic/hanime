import 'package:dio/dio.dart';
import 'package:html/parser.dart' show parse;

Future getWatchData(url) async {
  Response response = await Dio().get(url);
  final resHtml = response.data;
  var document = parse(resHtml);

  List tagList = [];
  List commendList = [];
  List videoList = [];
  List playerList = [];
  List sizeList = [];

  var titleElement = document.querySelector("meta[property='og:title']");
  var title = titleElement!.attributes['content'];
  var shareTitle = document.querySelector("#shareBtn-title")!.text;

  var currentPlayer;
  RegExp playerReg = RegExp(r'(?<="contentUrl": ")(.*)(?=",)');
  var match = playerReg.firstMatch(resHtml);
  if (match != null) {
    currentPlayer = match.group(0)!;
  }

  var watchImg = document
      .querySelector(".hidden-md #video-playlist-wrapper img")!
      .attributes['src'];

  var watchTitleElements =
      document.querySelectorAll(".hidden-md #video-playlist-wrapper h4");
  var watchTitle = watchTitleElements[0].text;
  var watchCountTitle = watchTitleElements[1].text;

  var descriptionElement =
      document.querySelector("meta[property='og:description']");
  var description = descriptionElement!.attributes['content'];

  String? aa = document.querySelector("#caption")!.firstChild!.text;
  description = description!.replaceFirst(aa!, "");

  var currentVideo = [
    {"name": title, 'url': currentPlayer}
  ];

  var tags = document
      .querySelectorAll(".video-show-panel-width .single-video-tag a[href]");
  for (var tag in tags) {
    tagList.add({
      "title": tag.text,
      "htmlUrl": "https://hanime1.me${tag.attributes['href']}"
    });
  }

  var commendElements =
      document.querySelectorAll("#related-tabcontent .related-video-width");
  var commendCount = 3;
  for (var commendElement in commendElements) {
    commendList.add({
      "imgUrl": commendElement.querySelector("img")!.attributes["src"],
      "title": commendElement.querySelector(".home-rows-videos-title")!.text,
      "url": commendElement.querySelector("a")!.attributes['href']
    });
  }

  if (commendList.length == 0) {
    commendCount = 2;
    commendElements = document.querySelectorAll(
        "#related-tabcontent .related-video-width-horizontal");
    print(commendElements.length);
    for (var commendElement in commendElements) {
      commendList.add({
        "imgUrl": commendElement
            .querySelector(".video-card")!
            .attributes["data-poster"],
        "title": commendElement.querySelector("a")!.attributes['title'],
        "url": commendElement.querySelector("a")!.attributes['href']
      });
    }
  }

  var videoElements = document.querySelectorAll(
      ".hidden-md #video-playlist-wrapper #playlist-scroll .related-watch-wrap");
  // var currentElement = document.querySelector(
  //     '.hidden-md #video-playlist-wrapper #playlist-scroll .related-watch-wrap img[style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; filter: brightness(15%);"]');
  // var currentImgUrl = currentElement!.attributes['src'];
  var videoIndex;
  for (var videoElement in videoElements) {
    var imgUrl = videoElement.querySelector("img[alt]")!.attributes['src'];
    var title = videoElement.querySelector("h4")!.text;
    var htmlUrl = videoElement.querySelector("a")!.attributes['href'];
    videoList.add({
      "imgUrl": imgUrl,
      "title": title,
      "htmlUrl": htmlUrl,
    });
    if (htmlUrl == url) {
      videoIndex = videoElements.length - videoList.length;
    }
  }
  // var playerElements = document.querySelectorAll("#player source"); //多分辨率
  // for (var playerElement in playerElements) {
  //   // var size = playerElement.attributes['size'];
  //   // var url = playerElement.attributes['src'];
  //   playerList.add({
  //     'url': playerElement.attributes['src'],
  //     'name': playerElement.attributes['name']
  //   });
  // }

  return {
    "info": {
      "title": watchTitle,
      "imgUrl": watchImg,
      "videoIndex": videoIndex,
      "shareTitle": shareTitle,
      "countTitle": watchCountTitle,
      "description": description,
    },
    "videoData": {
      "video": [
        {"name": "选集", "list": currentVideo},
      ]
    },
    "episode": videoList.reversed.toList(),
    "tag": tagList,
    "commendCount": commendCount,
    "commend": commendList
  };
}
