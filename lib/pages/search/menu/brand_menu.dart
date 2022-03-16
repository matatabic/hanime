import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/entity/search_entity.dart';
import 'package:hanime/providers/search_state.dart';
import 'package:provider/src/provider.dart';

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

class BrandMenu extends StatelessWidget {
  const BrandMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> tagWidgetList = [];
    for (String title in brand.data) {
      tagWidgetList.add(BrandDetail(
          onTap: () {
            context.read<SearchState>().selectedBrandHandle(title);
          },
          title: title,
          selected:
              context.watch<SearchState>().brandList.indexOf(title) > -1));
    }

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
          title: Text(brand.label),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: Adapt.px(10)),
                  child: Text(
                    brand.label,
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
          ),
        ));
  }
}

class BrandDetail extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final bool selected;

  const BrandDetail(
      {Key? key,
      required this.onTap,
      required this.title,
      required this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(Adapt.px(10)),
        decoration: BoxDecoration(
            color: selected ? Colors.orange : Colors.black,
            borderRadius: BorderRadius.all(
              Radius.circular(Adapt.px(15)),
            ),
            border: new Border.all(
              color: Colors.grey, //边框颜色
              width: Adapt.px(5), //边框粗细
            )),
        child: Text(
          title,
          style: TextStyle(fontSize: 17),
        ),
      ),
    );
  }
}
