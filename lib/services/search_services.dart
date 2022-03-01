import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hanime/utils/logUtil.dart';
import 'package:html/parser.dart';

Future getSearchData() async {
  Response response = await Dio().get("https://hanime1.me/search");
  final resHtml = response.data;
  var document = parse(resHtml);
  var a = [];
  var data = document.querySelectorAll(".checkmark");

  for (var item in data) {
    a.add(item.text);
  }
  LogUtil.d(json.encode(a));
  var genre = {
    "label": "影片類型",
    "genre": ["H動漫", "3D動畫", "同人作品", "Cosplay"]
  };

  var tag = [
    {
      "label": "影片屬性：",
      "group": ["無碼", "番劇", "1080p", "新番預告"]
    },
    {
      "label": "人物關係：",
      "group": [
        "近親",
        "姐",
        "妹",
        "母",
        "女兒",
        "師生",
        "情侶",
        "青梅竹馬",
      ] //H漫畫
    },
    {
      "label": "角色設定：",
      "group": [
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
      "group": [
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
      ] //H漫畫
    },
    {
      "label": "故事劇情：",
      "group": [
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
      ] //H漫畫
    },
    {
      "label": "故事劇情：",
      "group": [
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
  ];
}
