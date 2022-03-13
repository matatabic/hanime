import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/entity/search_entity.dart';

List tempTag = json.decode(
    '[{"label":"影片屬性：","data":["無碼","番劇","1080p","新番預告"]},{"label":"人物關係：","data":["近親","姐","妹","母","女兒","師生","情侶","青梅竹馬"]},{"label":"角色設定：","data":["JK","處女","御姐","熟女","人妻","老師","女醫護士","OL","大小姐","偶像","女僕","巫女","修女","風俗娘","公主","女戰士","魔法少女","異種族","妖精","魔物娘","獸娘","碧池","痴女","不良少女","傲嬌","病嬌","偽娘","扶他"]},{"label":"外貌身材：","data":["短髮","長髮","馬尾","雙馬尾","巨乳","貧乳","黑皮膚","眼鏡娘","獸耳","美人痣","肌肉女","白虎","大屌","水手服","體操服","泳裝","比基尼","和服","兔女郎","圍裙","啦啦隊","旗袍","絲襪","吊襪帶","熱褲","迷你裙","性感內衣","丁字褲","高跟鞋"]},{"label":"故事劇情：","data":["純愛","戀愛喜劇","後宮","開大車","公眾場合","NTR","精神控制","藥物","痴漢","阿嘿顏","精神崩潰","獵奇","BDSM","綑綁","眼罩","調教","肉便器","胃凸","強制","逆強制","女王樣","母女丼","凌辱","出軌","攝影","性轉換","百合","耽美","異世界","怪獸","世界末日"]},{"label":"性交體位：","data":["手交","指交","乳交","肛交","腳交","拳交","3P","群交","口交","口爆","吞精","爆精","舔蛋蛋","舔穴","69","自慰","毒龍鑽","腋下","內射","顏射","雙洞齊下","懷孕","噴奶","放尿","顏面騎乘","女陰摩擦","車震","性玩具","觸手","頸手枷"]}]');

class TagMenu extends StatelessWidget {
  const TagMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<SearchTag> tag = tempTag
        .map((dynamic e) => SearchTag.fromJson(e as Map<String, dynamic>))
        .toList();
    // print(SearchTag.fromJson(tag1));
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
        title: const Text('標籤'),
      ),
      body: ListView.builder(
          shrinkWrap: true,
          // scrollDirection: Axis.horizontal,
          itemCount: tag.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildTagWidget(tag[index]);
          }),
    );
  }
}

Widget _buildTagWidget(SearchTag tag) {
  List<Widget> tagWidgetList = [];
  for (String item in tag.data) {
    tagWidgetList.add(Container(
      padding: EdgeInsets.all(3.5),
      decoration: BoxDecoration(
          border: new Border.all(
        color: Colors.grey, //边框颜色
        width: Adapt.px(2), //边框粗细
      )),
      child: Text(
        item,
        style: TextStyle(fontSize: 17),
      ),
    ));
  }

  return Column(
    children: [
      Text(tag.label),
      Wrap(
        children: tagWidgetList,
        spacing: Adapt.px(20),
        runSpacing: Adapt.px(20),
      )
    ],
  );
}
