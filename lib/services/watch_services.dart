import 'package:dio/dio.dart';
import 'package:html/parser.dart' show parse;

Future getWatchData(url) async {
  print(url);
  Response response = await Dio().get(url);
  final res = response.data;
  var document = parse(res);

  List tagList = [];
  List commendList = [];
  List videoList = [];
  var tags = document
      .querySelectorAll(".video-show-panel-width .single-video-tag a[href]");
  for (var tag in tags) {
    tagList.add(tag.text);
  }
  print(tagList);
  var commendElements =
      document.querySelectorAll("#related-tabcontent .related-video-width");

  for (var commendElement in commendElements) {
    commendList.add({
      "imgUrl": commendElement.querySelector("img")!.attributes['src'],
      "title": commendElement.querySelector(".home-rows-videos-title")!.text,
      "url": commendElement.querySelector("a")!.attributes['href']
    });
  }
  print(commendList);

  var videoElements = document.querySelectorAll(
      ".hidden-md #video-playlist-wrapper #playlist-scroll .related-watch-wrap");
  for (var videoElement in videoElements) {
    videoList.add({
      "imgUrl": videoElement.querySelector("img[alt]")!.attributes['src'],
      "title": videoElement.querySelector("h4")!.text,
      "url": videoElement.querySelector("a")!.attributes['href']
    });
  }
  print(videoList);

  var playerElements = document.querySelectorAll("#player source");
  for (var playerElement in playerElements) {
    print(playerElement.attributes['size']);
    print(playerElement.attributes['src']);
  }

  RegExp playerReg = new RegExp(r'');
}
