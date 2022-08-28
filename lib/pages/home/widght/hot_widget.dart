import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/hero_slide_page.dart';
import 'package:hanime/entity/home_entity.dart';
import 'package:hanime/pages/watch/watch_screen.dart';

import '../cover_photo.dart';

class HotWidget extends StatelessWidget {
  final HomeHot data;
  final Interval opacityCurve;

  HotWidget({Key? key, required this.data, required this.opacityCurve})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
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
      SizedBox(
          height: 200,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: data.video.length,
              itemBuilder: (BuildContext context, int index) {
                String heroTag = UniqueKey().toString();
                return CoverPhoto(
                  title: data.video[index].title,
                  imgUrl: data.video[index].imgUrl,
                  heroTag: heroTag,
                  width: 135,
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) =>
                              WatchScreen(htmlUrl: data.video[index].htmlUrl)),
                    );
                  },
                  onLongPress: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return AnimatedBuilder(
                            animation: animation,
                            builder: (context, child) {
                              return Opacity(
                                opacity:
                                    opacityCurve.transform(animation.value),
                                child: HeroSlidePage(
                                    heroTag: heroTag,
                                    url: data.video[index].imgUrl
                                    // 'http://img5.mtime.cn/mt/2022/01/19/102417.23221502_1280X720X2.jpg',
                                    ),
                              );
                            },
                          );
                        }));
                  },
                );
              }))
    ]);
  }
}
