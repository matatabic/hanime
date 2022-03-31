import 'package:dio/dio.dart';
import 'package:hanime/entity/search_entity.dart';
import 'package:html/parser.dart';

SearchGenre genre = SearchGenre.fromJson({
  "label": "影片類型",
  "data": ["全部", "裏番", "泡麵番", "3D動畫", "同人作品", "Cosplay"]
});

SearchTag searchTag = SearchTag.fromJson({
  "label": "内容標籤",
  "data": [
    {
      "label": "影片屬性：",
      "data": ["無碼", "番劇", "1080p", "新番預告"]
    },
    {
      "label": "人物關係：",
      "data": [
        "近親",
        "姐",
        "妹",
        "母",
        "女兒",
        "師生",
        "情侶",
        "青梅竹馬",
      ]
    },
    {
      "label": "角色設定：",
      "data": [
        "JK",
        "處女",
        "御姐",
        "熟女",
        "人妻",
        "老師",
        "女醫護士",
        "OL",
        "大小姐",
        "偶像",
        "女僕",
        "巫女",
        "修女",
        "風俗娘",
        "公主",
        "女戰士",
        "魔法少女",
        "異種族",
        "妖精",
        "魔物娘",
        "獸娘",
        "碧池",
        "痴女",
        "不良少女",
        "傲嬌",
        "病嬌",
        "偽娘",
        "扶他"
      ],
    },
    {
      "label": "外貌身材：",
      "data": [
        "短髮",
        "長髮",
        "馬尾",
        "雙馬尾",
        "巨乳",
        "貧乳",
        "黑皮膚",
        "眼鏡娘",
        "獸耳",
        "美人痣",
        "肌肉女",
        "白虎",
        "大屌",
        "水手服",
        "體操服",
        "泳裝",
        "比基尼",
        "和服",
        "兔女郎",
        "圍裙",
        "啦啦隊",
        "旗袍",
        "絲襪",
        "吊襪帶",
        "熱褲",
        "迷你裙",
        "性感內衣",
        "丁字褲",
        "高跟鞋"
      ]
    },
    {
      "label": "故事劇情：",
      "data": [
        "純愛",
        "戀愛喜劇",
        "後宮",
        "開大車",
        "公眾場合",
        "NTR",
        "精神控制",
        "藥物",
        "痴漢",
        "阿嘿顏",
        "精神崩潰",
        "獵奇",
        "BDSM",
        "綑綁",
        "眼罩",
        "調教",
        "肉便器",
        "胃凸",
        "強制",
        "逆強制",
        "女王樣",
        "母女丼",
        "凌辱",
        "出軌",
        "攝影",
        "性轉換",
        "百合",
        "耽美",
        "異世界",
        "怪獸",
        "世界末日"
      ]
    },
    {
      "label": "性交體位：",
      "data": [
        "手交",
        "指交",
        "乳交",
        "肛交",
        "腳交",
        "拳交",
        "3P",
        "群交",
        "口交",
        "口爆",
        "吞精",
        "爆精",
        "舔蛋蛋",
        "舔穴",
        "69",
        "自慰",
        "毒龍鑽",
        "腋下",
        "內射",
        "顏射",
        "雙洞齊下",
        "懷孕",
        "噴奶",
        "放尿",
        "顏面騎乘",
        "女陰摩擦",
        "車震",
        "性玩具",
        "觸手",
        "頸手枷",
      ]
    },
  ]
});

SearchBrand brand = SearchBrand.fromJson({
  "label": "製作公司",
  "data": [
    "妄想実現めでぃあ",
    "メリー・ジェーン",
    "ピンクパイナップル",
    "ばにぃうぉ～か～",
    "Queen Bee",
    "PoRO",
    "せるふぃっしゅ",
    "鈴木みら乃",
    "ショーテン",
    "GOLD BEAR",
    "ZIZ",
    "EDGE",
    "Collaboration Works",
    "BOOTLEG",
    "BOMB!CUTE!BOMB!",
    "nur",
    "あんてきぬすっ",
    "魔人",
    "ルネ",
    "Princess Sugar",
    "パシュミナ",
    "White Bear",
    "AniMan",
    "chippai",
    "トップマーシャル",
    "erozuki",
    "サークルトリビュート",
    "spermation",
    "Milky",
    "King Bee",
    "PashminaA",
    "じゅうしぃまんご～",
    "Hills",
    "妄想専科",
    "ディスカバリー",
    "ひまじん",
    "37℃",
    "schoolzone",
    "GREEN BUNNY",
    "バニラ",
    "L.",
    "PIXY",
    "こっとんど～る",
    "ANIMAC",
    "Celeb",
    "MOON ROCK",
    "Dream",
    "ミンク",
    "オズ・インク",
    "サン出版",
    "ポニーキャニオン",
    "わるきゅ～れ＋＋",
    "株式会社虎の穴",
    "エンゼルフィッシュ",
    "UNION-CHO",
    "TOHO",
    "ミルクセーキ",
    "2匹目のどぜう",
    "じゅうしぃまんご～",
    "ツクルノモリ",
    "サークルトリビュート",
    "トップマーシャル",
    "サークルトリビュート"
  ]
});

SearchSort sort = SearchSort.fromJson({
  "label": "排序方式",
  "data": ["无", "本日排行", "最新內容", "最新上傳", "觀看次數"]
});

SearchDate date = SearchDate.fromJson({
  "label": "發佈日期",
  "data": {
    "year": [
      "全部",
      "2021",
      "2020",
      "2019",
      "2018",
      "2017",
      "2016",
      "2015",
      "2014",
      "2013",
      "2012",
      "2011",
      "2010",
      "2009",
      "2008",
      "2007",
      "2006",
      "2005",
      "2004",
      "2003",
      "2002",
      "2001",
      "2000",
      "1999",
      "1998",
      "1997",
      "1996",
      "1995",
      "1994",
      "1993",
      "1992",
      "1991",
      "1990",
    ],
    "month": [
      "全部",
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9",
      "10",
      "11",
      "12",
    ],
  }
});

SearchDuration duration = SearchDuration.fromJson({
  "label": "片長",
  "data": [
    "全部",
    "短片（4 分鐘內）",
    "中長片（4 至 20 分鐘）",
    "長片（20 分鐘以上）",
  ]
});

Future getSearchData(_htmlUrl) async {
  Response response = await Dio().get(_htmlUrl);

  final resHtml = response.data;
  var document = parse(resHtml);
  var videoList = [];
  var page;
  RegExp pageReg = RegExp(r"(?<=\) < )(.*?)(?=- 1)");

  var match = pageReg.firstMatch(resHtml);
  if (match != null) {
    page = int.parse(match.group(0)!);
  }

  var videoElements = document.querySelectorAll(".card-mobile-panel");
  print(videoElements.length);
  if (videoElements.length > 0) {
    for (var videoElement in videoElements) {
      var durationElement = videoElement.querySelector(".card-mobile-duration");
      String duration = durationElement != null ? durationElement.text : "";
      videoList.add({
        "title": videoElement.querySelector(".card-mobile-title")!.text,
        "imgUrl": videoElement.querySelector("img:nth-child(3)"),
        "htmlUrl": videoElement.querySelector("a")!.attributes['href'],
        "duration": duration,
        "author": videoElement.querySelector(".card-mobile-user")!.text
      });
    }
  } else {
    var videoElements =
        document.querySelectorAll(".home-rows-videos-wrapper a");
    for (var videoElement in videoElements) {
      videoList.add({
        "title": videoElement.querySelector(".home-rows-videos-title")!.text,
        "imgUrl": videoElement.querySelector("img")!.attributes['src'],
        "htmlUrl": videoElement.attributes['href'],
        "duration": "",
        "author": ""
      });
    }
  }
  // LogUtil.d(videoList);
  return {"video": videoList, "page": page};
}
