import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/common/common_image.dart';
import 'package:hanime/entity/home_entity.dart';
import 'package:hanime/pages/home/swiper_screen.dart';
import 'package:hanime/pages/watch/watch_screen.dart';

class HomeHeaderScreen extends StatelessWidget {
  final List<HomeSwiper> swiperList;
  final String currentSwiperImage;

  const HomeHeaderScreen(
      {Key? key, required this.swiperList, required this.currentSwiperImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Adapt.px(520),
      child: Stack(children: [
        ConstrainedBox(
          constraints: new BoxConstraints.expand(),
          child: Stack(children: [
            Container(child: CommonImages(imgUrl: currentSwiperImage)),
            Container(
              child: new ClipRect(
                child: new BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Opacity(
                    opacity: 0.5,
                    child: new Container(
                      decoration: new BoxDecoration(
                        color: Colors.grey.shade500.withOpacity(0.3),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ]),
        ),
        Container(
          child: SwiperScreen(
              swiperList: swiperList,
              onTap: (HomeSwiper swiper) => {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) =>
                                WatchScreen(htmlUrl: swiper.htmlUrl)))
                  }),
          alignment: AlignmentDirectional.bottomStart,
        )
      ]),
    );
  }
}
