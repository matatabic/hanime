import 'package:dio/dio.dart';
import 'package:hanime/entity/home_entity.dart';
import 'package:hanime/request/dio_manage.dart';
import 'package:html/parser.dart' show parse;

Future getHomeData() async {
  print("getHomeData");
  Response? response = await DioManage.get("https://hanime1.me");
  print(response);
  if (response == null) {
    return null;
  }
  final res = response.data;
  // print(res);
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
  return homeData;
}

Future getHome(String data) async {
  var document = parse(data);

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
