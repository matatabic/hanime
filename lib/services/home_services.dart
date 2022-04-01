import 'package:dio/dio.dart';
import 'package:html/parser.dart' show parse;

Future getHomeData() async {
  Response response = await Dio().get("https://hanime1.me");
  final res = response.data;
  var document = parse(res);

  List temp = [];

  List topList = [];
  List latestList = [];
  List fireList = [];
  List tagList = [];
  List hotList = [];
  List watchList = [];

  List swiper = [
    {
      "title": "[yuukis] 亞絲娜 [刀劍神域]",
      "imgUrl": "https://i.imgur.com/meKHvP3l.png",
      "htmlUrl": "https://hanime1.me/watch?v=37460",
    },
    {
      "title": "[JXH33] 早坂愛 [輝夜姬想讓人告白～天才們的戀愛頭腦戰～]",
      "imgUrl": "https://i.imgur.com/vZWIadjl.png",
      "htmlUrl": "https://hanime1.me/watch?v=38240",
    },
    {
      "title": "[akinoya] 阿爾托莉雅·潘德拉貢 [Fate/stay night]",
      "imgUrl": "https://i.imgur.com/AnWHF7xl.png",
      "htmlUrl": "https://hanime1.me/watch?v=38258",
    },
    {
      "title": "菜月昴君和愛蜜莉雅碳",
      "imgUrl": "https://i.imgur.com/PzHQqSHl.png",
      "htmlUrl": "https://hanime1.me/watch?v=211",
    },
    {
      "title": "[Kamuo] 優菈 [原神]",
      "imgUrl": "https://i.imgur.com/PnmtcyQl.png",
      "htmlUrl": "https://hanime1.me/watch?v=36679",
    },
  ];

  var videoElements = document.querySelectorAll(".owl-home-top-row a"); //第一个
  for (var videoElement in videoElements) {
    topList.add({
      "title": videoElement.querySelector(".owl-home-rows-title")!.text,
      "imgUrl": videoElement.querySelector("img")!.attributes['src'],
      "htmlUrl": videoElement.attributes['href'],
      'latest': videoElement.nextElementSibling != null ? true : false
    });
  }
  var top = {
    "label": "置頂推薦",
    "labelHtml": "https://hanime1.me/search",
    "video": topList,
  };

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
        'duration': card.querySelector('.card-mobile-duration') != null
            ? card.querySelector('.card-mobile-duration')!.text.trim()
            : ""
      });
    }
    latestList.add(temp);
    temp = [];
  }

  var latest = {
    "label": contentElements[0].querySelector("h3")!.text,
    "labelHtml": contentElements[0]
        .querySelector(".home-rows-header")!
        .attributes['href'],
    "video": latestList,
  };

  videos = contentElements[1].nextElementSibling!.querySelectorAll("a");
  for (var video in videos) {
    fireList.add({
      'title': video.querySelector('.owl-home-rows-title')!.text,
      "imgUrl": video.querySelector("img")!.attributes['src'],
      'htmlUrl': video.attributes['href'],
    });
  }

  var fire = {
    "label": contentElements[1].querySelector("h3")!.text,
    "labelHtml": contentElements[1]
        .querySelector(".home-rows-header")!
        .attributes['href'],
    "video": fireList,
  };

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
    tagList.add(temp);
    temp = [];
  }
  var tag = {
    "label": contentElements[2].querySelector("h3")!.text,
    "labelHtml": contentElements[2]
        .querySelector(".home-rows-header")!
        .attributes['href'],
    "video": tagList,
  };

  videos = contentElements[3].nextElementSibling!.querySelectorAll("a");
  for (var video in videos) {
    hotList.add({
      'title': video.querySelector('.owl-home-rows-title')!.text,
      "imgUrl": video.querySelector("img")!.attributes['src'],
      'htmlUrl': video.attributes['href'],
    });
  }

  var hot = {
    "label": contentElements[3].querySelector("h3")!.text,
    "labelHtml": contentElements[3]
        .querySelector(".home-rows-header")!
        .attributes['href'],
    "video": hotList,
  };

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
        'duration': card.querySelector('.card-mobile-duration') != null
            ? card.querySelector('.card-mobile-duration')!.text.trim()
            : ""
      });
    }
    watchList.add(temp);
    temp = [];
  }
  var watch = {
    "label": contentElements[4].querySelector("h3")!.text,
    "labelHtml": contentElements[4]
        .querySelector(".home-rows-header")!
        .attributes['href'],
    "video": watchList,
  };

  var homeData = {
    "swiper": swiper,
    "top": top,
    "latest": latest,
    "fire": fire,
    "tag": tag,
    "hot": hot,
    "watch": watch
  };

  return homeData;
}
