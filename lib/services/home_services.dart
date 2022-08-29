import 'package:dio/dio.dart';
import 'package:hanime/entity/home_entity.dart';
import 'package:hanime/request/dio_manage.dart';
import 'package:html/parser.dart' show parse;

Future getHomeData(String url) async {
  Response? response = await DioManage.get(url);
  if (response == null) {
    return null;
  }
  final resHtml = response.data;
  return await homeHtml2Data(resHtml);
}

Future homeHtml2Data(String html) async {
  var document = parse(html);

  List temp = [];

  List topList = [];
  List latestList = [];
  List fireList = [];
  List tagList = [];
  List hotList = [];
  List watchList = [];

  List swiper = [
    {
      "title": "緣之空",
      "imgUrl":
          "https://cdn.jsdelivr.net/gh/bandoguru/bandoguru-h@latest/asset/thumbnail/8vLcXfoh.jpg",
      "htmlUrl": "https://hanime1.me/watch?v=4417",
    },
    {
      "title": "回復術士的重啟人生",
      "imgUrl":
          "https://cdn.jsdelivr.net/gh/furansutsukai/furansutsukai-h@latest/asset/thumbnail/pDTqnxcl.jpg",
      "htmlUrl": "https://hanime1.me/watch?v=19954",
    },
    {
      "title": "地味變!!～改變土妹子的純潔異性交往～",
      "imgUrl":
          "https://cdn.jsdelivr.net/gh/kochokochokaeru/kochokochokaeru-h@latest/asset/thumbnail/jl8TZR2h.jpg",
      "htmlUrl": "https://hanime1.me/watch?v=19494",
    },
    {
      "title": "異世界迷宮裡的後宮生活",
      "imgUrl": "https://i.imgur.com/MLuHHPPl.jpg",
      "htmlUrl": "https://hanime1.me/watch?v=38946",
    },
    {
      "title": "終末的後宮",
      "imgUrl":
          "https://cdn.jsdelivr.net/gh/tatakanuta/tatakanuta@v1.0.0/asset/thumbnail/thzo0Ilh.jpg",
      "htmlUrl": "https://hanime1.me/watch?v=401054",
    },
  ];

  // var videoElements = document.querySelectorAll(".owl-home-row a"); //第一个
  var contentElements = document.querySelectorAll(".content-padding-new");
  var videos = contentElements[0]
      .nextElementSibling!
      .querySelectorAll(".owl-carousel a");

  for (var videoElement in videos) {
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

  contentElements = document.querySelectorAll(".content-padding-new");
  videos = contentElements[1].querySelectorAll(".item");

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
    "label": contentElements[1].querySelector("h3")!.text,
    "labelHtml": contentElements[1]
        .querySelector(".home-rows-header")!
        .attributes['href'],
    "video": latestList,
  };

  videos = contentElements[2].nextElementSibling!.querySelectorAll("a");

  for (var video in videos) {
    fireList.add({
      'title': video.querySelector('.owl-home-rows-title')!.text,
      "imgUrl": video.querySelector("img")!.attributes['src'],
      'htmlUrl': video.attributes['href'],
    });
  }

  var fire = {
    "label": contentElements[2].querySelector("h3")!.text,
    "labelHtml": contentElements[2]
        .querySelector(".home-rows-header")!
        .attributes['href'],
    "video": fireList,
  };

  videos = contentElements[3].querySelectorAll(".item");
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
    "label": contentElements[3].querySelector("h3")!.text,
    "labelHtml": contentElements[3]
        .querySelector(".home-rows-header")!
        .attributes['href'],
    "video": tagList,
  };

  videos = contentElements[4].nextElementSibling!.querySelectorAll("a");
  for (var video in videos) {
    hotList.add({
      'title': video.querySelector('.owl-home-rows-title')!.text,
      "imgUrl": video.querySelector("img")!.attributes['src'],
      'htmlUrl': video.attributes['href'],
    });
  }

  var hot = {
    "label": contentElements[4].querySelector("h3")!.text,
    "labelHtml": contentElements[4]
        .querySelector(".home-rows-header")!
        .attributes['href'],
    "video": hotList,
  };

  videos = contentElements[5].querySelectorAll(".item .hover-lighter");
  for (var video in videos) {
    // var cards = video.querySelectorAll(".hover-lighter");
    // for (var card in cards) {
    watchList.add({
      'title': video.querySelector('.card-mobile-title')!.text,
      "imgUrl": video.querySelector("img:nth-child(3)")!.attributes['src'],
      'htmlUrl': video.querySelector('a')!.attributes['href'],
      'genre': video.querySelector('.card-mobile-genre-new')!.text,
      'author': video.querySelector('.card-mobile-user')!.text,
      'created': video.querySelector('.card-mobile-created-text')!.text,
      'duration': video.querySelector('.card-mobile-duration') != null
          ? video.querySelector('.card-mobile-duration')!.text.trim()
          : ""
    });
    // }
    // watchList.add(temp);
    // temp = [];
  }
  var watch = {
    "label": contentElements[5].querySelector("h3")!.text,
    "labelHtml": contentElements[5]
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
  // LogUtil.d(json.encode(homeData));
  return HomeEntity.fromJson(homeData);
}
