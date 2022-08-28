import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/hero_slide_page.dart';
import 'package:hanime/component/anime_2card.dart';
import 'package:hanime/entity/home_entity.dart';
import 'package:hanime/pages/watch/watch_screen.dart';

class WatchWidget extends StatelessWidget {
  final HomeWatch data;
  final Interval opacityCurve;

  WatchWidget({Key? key, required this.data, required this.opacityCurve})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            height: 35,
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(left: 2.5),
            child: Row(children: <Widget>[
              Text(
                data.label,
                style: TextStyle(fontSize: 19),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 18,
              )
            ]),
            width: double.infinity),
        GridView.builder(
          shrinkWrap: true,
          physics: new NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(top: 0),
          itemCount: data.video.length,
          //调整间距
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //横轴元素个数
              crossAxisCount: 2,
              //纵轴间距
              mainAxisSpacing: 5,
              //横轴间距
              crossAxisSpacing: 5,
              //子组件宽高长度比例
              childAspectRatio: 1.05),
          itemBuilder: (BuildContext context, int index) {
            String heroTag = UniqueKey().toString();
            return Anime2Card(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) =>
                            WatchScreen(htmlUrl: data.video[index].htmlUrl)));
              },
              onLongPress: () {
                Navigator.of(context).push(PageRouteBuilder(
                    opaque: false,
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return AnimatedBuilder(
                        animation: animation,
                        builder: (context, child) {
                          return Opacity(
                            opacity: opacityCurve.transform(animation.value),
                            child: HeroSlidePage(
                                heroTag: heroTag, url: data.video[index].imgUrl
                                // 'http://img5.mtime.cn/mt/2022/01/19/102417.23221502_1280X720X2.jpg',
                                ),
                          );
                        },
                      );
                    }));
              },
              heroTag: heroTag,
              htmlUrl: data.video[index].htmlUrl,
              title: data.video[index].title,
              imgUrl: data.video[index].imgUrl,
              duration: data.video[index].duration,
              genre: data.video[index].genre,
              author: data.video[index].author,
              created: data.video[index].created,
            );
          },
          //加载内容
        ),
      ],
    );
  }
}
