import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/common_image.dart';
import 'package:hanime/entity/home_entity.dart';
import 'package:hanime/pages/home/swiper_screen.dart';
import 'package:hanime/pages/watch/watch_screen.dart';
import 'package:hanime/providers/home_model.dart';
import 'package:provider/src/provider.dart';

class HomeHeaderScreen extends StatelessWidget {
  final List<HomeSwiper> swiperList;

  const HomeHeaderScreen({Key? key, required this.swiperList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int swiperIndex =
        context.select<HomeModel, int>((value) => value.swiperIndex);

    return Container(
      height: 260,
      child: Stack(children: [
        ConstrainedBox(
          constraints: new BoxConstraints.expand(),
          child: Stack(children: [
            Container(
                child: CommonImage(imgUrl: swiperList[swiperIndex].imgUrl)),
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
