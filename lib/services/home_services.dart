import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hanime/utils/logUtil.dart';
import 'package:html/parser.dart' show parse;

Future getHomeData() async {
  Response response = await Dio().get("https://hanime1.me");
  final res = response.data;
  var document = parse(res);
  List tempList = [];
  List videoList = [];
  List groupList = [];
  List temp = [];

  var videoElements = document.querySelectorAll(".owl-home-top-row a"); //第一个
  for (var videoElement in videoElements) {
    print(videoElement.nextElementSibling);
    tempList.add({
      "title": videoElement.querySelector(".owl-home-rows-title")!.text,
      "imgUrl": videoElement.querySelector("img")!.attributes['src'],
      "htmlUrl": videoElement.attributes['href'],
      'latest ': videoElement.nextElementSibling != null ? true : false
    });
  }
  groupList.add(tempList);
  groupList
      .add({"label": null, "labelHtml": null, "video": tempList, "type": 0});
  tempList = [];

  var contentElements = document.querySelectorAll(".content-padding-new");
  var videos = contentElements[0].querySelectorAll(".item");
  for (var video in videos) {
    var cards = video.querySelectorAll(".hover-lighter");
    for (var card in cards) {
      temp.add({
        'title': card.querySelector('.card-mobile-title')!.text,
        "imgUrl": card.querySelector("img:nth-child(3)")!.attributes['src'],
        'htmlUrl': card.querySelector('a')!.attributes['href'],
        'genre': card.querySelector('.card-mobile-genre-new')!.text,
        'author': card.querySelector('.card-mobile-user')!.text,
        'created': card.querySelector('.card-mobile-created-text')!.text,
        'duration': card.querySelector('.card-mobile-duration')!.text.trim()
      });
    }
    tempList.add(temp);
    temp = [];
  }

  groupList.add({
    "label": contentElements[0].querySelector("h3")!.text,
    "labelHtml": contentElements[0]
        .querySelector(".home-rows-header")!
        .attributes['href'],
    "video": tempList,
    "type": 1
  });
  tempList = [];

  videos = contentElements[1].nextElementSibling!.querySelectorAll("a");
  for (var video in videos) {
    tempList.add({
      'title': video.querySelector('.owl-home-rows-title')!.text,
      "imgUrl": video.querySelector("img")!.attributes['src'],
      'htmlUrl': video.attributes['href'],
    });
  }

  groupList.add({
    "label": contentElements[1].querySelector("h3")!.text,
    "labelHtml": contentElements[1]
        .querySelector(".home-rows-header")!
        .attributes['href'],
    "video": tempList,
    "type": 0
  });
  tempList = [];

  videos = contentElements[2].querySelectorAll(".item");
  for (var video in videos) {
    var cards = video.querySelectorAll(".hover-lighter");
    for (var card in cards) {
      temp.add({
        'title': card.querySelector('.home-tags-title')!.text,
        "imgUrl": card.querySelector("img:nth-child(3)")!.attributes['src'],
        'htmlUrl': card.querySelector('a')!.attributes['href'],
        'total': card.querySelector('.home-tags-total')!.text,
      });
    }
    tempList.add(temp);
    temp = [];
  }

  groupList.add({
    "label": contentElements[2].querySelector("h3")!.text,
    "labelHtml": contentElements[2]
        .querySelector(".home-rows-header")!
        .attributes['href'],
    "video": tempList,
    "type": 1
  });
  tempList = [];

  videos = contentElements[3].nextElementSibling!.querySelectorAll("a");
  for (var video in videos) {
    tempList.add({
      'title': video.querySelector('.owl-home-rows-title')!.text,
      "imgUrl": video.querySelector("img")!.attributes['src'],
      'htmlUrl': video.attributes['href'],
    });
  }

  groupList.add({
    "label": contentElements[3].querySelector("h3")!.text,
    "labelHtml": contentElements[3]
        .querySelector(".home-rows-header")!
        .attributes['href'],
    "video": tempList,
    "type": 0
  });
  tempList = [];

  videos = contentElements[4].querySelectorAll(".item");
  for (var video in videos) {
    var cards = video.querySelectorAll(".hover-lighter");
    for (var card in cards) {
      temp.add({
        'title': card.querySelector('.card-mobile-title')!.text,
        "imgUrl": card.querySelector("img:nth-child(3)")!.attributes['src'],
        'htmlUrl': card.querySelector('a')!.attributes['href'],
        'genre': card.querySelector('.card-mobile-genre-new')!.text,
        'author': card.querySelector('.card-mobile-user')!.text,
        'created': card.querySelector('.card-mobile-created-text')!.text,
        'duration': card.querySelector('.card-mobile-duration')!.text.trim()
      });
    }
    tempList.add(temp);
    temp = [];
  }

  groupList.add({
    "label": contentElements[4].querySelector("h3")!.text,
    "labelHtml": contentElements[4]
        .querySelector(".home-rows-header")!
        .attributes['href'],
    "video": tempList,
    "type": 1
  });

  LogUtil.d(json.encode(groupList));
  // return {"swiper": swiperList, "video": dataList};
}
