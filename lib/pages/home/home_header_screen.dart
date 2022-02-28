import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/common_image.dart';
import 'package:hanime/entity/home_entity.dart';
import 'package:hanime/pages/home/swiper_screen.dart';

class HomeHeaderScreen extends StatelessWidget {
  final List<HomeSwiper> swiperList;
  final String current_swiper_image;

  const HomeHeaderScreen(
      {Key? key, required this.swiperList, required this.current_swiper_image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      child: Stack(children: [
        ConstrainedBox(
          constraints: new BoxConstraints.expand(),
          child: Stack(children: [
            Container(
                child: CommonImages(
              imgUrl:
                  'http://img5.mtime.cn/mt/2022/01/19/102417.23221502_1280X720X2.jpg',
              // current_swiper_image,
            )),
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
          child: SwiperScreen(swiperList: swiperList),
          alignment: AlignmentDirectional.bottomStart,
        )
      ]),
    );
  }
}
