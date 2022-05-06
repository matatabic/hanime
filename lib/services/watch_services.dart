import 'package:dio/dio.dart';
import 'package:hanime/utils/logUtil.dart';
import 'package:html/parser.dart' show parse;

Future getWatchData(url) async {
  print(url);
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
      "htmlUrl": commendElement.querySelector("a")!.attributes['href'],
      "duration": "",
      "author": "",
      "genre": "",
      "created": ""
    });
  }

  if (commendList.length == 0) {
    commendCount = 2;
    commendElements = document.querySelectorAll(
        "#related-tabcontent .related-video-width-horizontal");
    for (var commendElement in commendElements) {
      String createdString = commendElement
          .querySelector('.card-info-wrapper div:nth-child(5)')!
          .text;
      String created = createdString.split("•")[1].trim();

      commendList.add({
        "imgUrl": commendElement
            .querySelector(".video-card")!
            .attributes["data-poster"],
        "title": commendElement.querySelector("a")!.attributes['title'],
        "htmlUrl": commendElement.querySelector("a")!.attributes['href'],
        "author": commendElement
            .querySelector(".card-info-wrapper div:nth-child(3)")!
            .text,
        "duration": commendElement
            .querySelector("a .preview-wrapper div:nth-child(3)")!
            .text
            .trim(),
        "genre": "",
        "created": created,
      });
    }
  }
  // LogUtil.d(commendList);
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
      "htmlUrl": url,
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

Future translate(String prefixText, String expandableText) async {
  Response response1 = await Dio().get(
      'https://fanyi.youdao.com/translate?&doctype=json&type=JA2ZH_CN&i=$prefixText');
  // var res = json.decode(response1.data);
  String _prefixText = "";
  String _expandableText = "";
  List res1 = response1.data['translateResult'];

  for (var item in res1) {
    _prefixText = _prefixText + item[0]['tgt'];
  }

  Response response2 = await Dio().get(
      'https://fanyi.youdao.com/translate?&doctype=json&type=JA2ZH_CN&i=$expandableText');
  List res2 = response2.data['translateResult'];

  for (var item in res2) {
    _expandableText = _expandableText + item[0]['tgt'];
  }
  LogUtil.d(_prefixText);
  LogUtil.d(_expandableText);
}
