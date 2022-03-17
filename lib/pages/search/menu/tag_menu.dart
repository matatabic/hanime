import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/entity/search_entity.dart';
import 'package:hanime/providers/search_state.dart';
import 'package:provider/src/provider.dart';

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

class TagMenu extends StatelessWidget {
  const TagMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: new AppBar(
          centerTitle: true,
          backgroundColor: Colors.orange,
          leading: IconButton(
            icon: Icon(Icons.close_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(searchTag.label),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Column(
              children: [
                Container(
                  color: Color.fromRGBO(51, 51, 51, 1),
                  padding: EdgeInsets.symmetric(
                      horizontal: Adapt.px(32), vertical: Adapt.px(15)),
                  height: Adapt.px(220),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "廣泛配對",
                            style: TextStyle(
                                fontSize: Adapt.px(45),
                                fontWeight: FontWeight.bold),
                          ),
                          Switch(
                            value: context.watch<SearchState>().broad,
                            activeColor: Colors.orange,
                            onChanged: (value) {
                              context.read<SearchState>().setBroadFlag(value);
                            },
                          ),
                        ],
                      ),
                      Container(
                          child: Text("較多結果，較不精準。配對所有包含任何一個選擇的標籤的影片，而非全部標籤。"))
                    ],
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: searchTag.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return TagContainer(
                          searchTagData: searchTag.data[index].data,
                          onTap: (String title) {
                            context
                                .read<SearchState>()
                                .selectedTagHandle(title);
                          });
                    }),
              ],
            ),
          ),
        ));
  }
}

class TagContainer extends StatelessWidget {
  final List<String> searchTagData;
  final Function(String title) onTap;

  const TagContainer(
      {Key? key, required this.searchTagData, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> tagWidgetList = [];
    for (String title in searchTagData) {
      tagWidgetList.add(InkWell(
        onTap: () {
          onTap(title);
        },
        child: TagDetail(
          title: title,
          color: context.watch<SearchState>().tagList.indexOf(title) > -1
              ? Colors.orange
              : Colors.black,
        ),
      ));
    }

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Adapt.px(32), vertical: Adapt.px(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: Adapt.px(10)),
            child: Text(
              searchTag.label,
              style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: Adapt.px(40)),
            ),
          ),
          Wrap(
            children: tagWidgetList,
            spacing: Adapt.px(20),
            runSpacing: Adapt.px(20),
          )
        ],
      ),
    );
  }
}

class TagDetail extends StatelessWidget {
  final String title;
  final Color color;

  const TagDetail({Key? key, required this.title, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Adapt.px(10)),
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(
            Radius.circular(Adapt.px(15)),
          ),
          border: new Border.all(
            color: Colors.grey, //边框颜色
            width: Adapt.px(5), //边框粗细
          )),
      child: Text(
        title,
        style: TextStyle(fontSize: Adapt.px(34)),
      ),
    );
  }
}
