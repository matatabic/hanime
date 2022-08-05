import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
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
          height: Adapt.px(70),
          alignment: Alignment.topCenter,
          margin: EdgeInsets.only(left: Adapt.px(5)),
          child: Row(children: <Widget>[
            Text(
              data.label,
              style: TextStyle(fontSize: Adapt.px(38)),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: Adapt.px(36),
            )
          ]),
          width: double.infinity),
      SizedBox(
          height: Adapt.px(400),
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
                  width: Adapt.px(270),
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
