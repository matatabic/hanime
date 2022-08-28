import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/hero_slide_page.dart';
import 'package:hanime/entity/home_entity.dart';
import 'package:hanime/pages/search/search_screen.dart';
import 'package:hanime/utils/utils.dart';
import 'package:infinite_carousel/infinite_carousel.dart';

import '../home_tag_card.dart';

class TagWidget extends StatefulWidget {
  final HomeTag data;
  final Interval opacityCurve;

  TagWidget({Key? key, required this.data, required this.opacityCurve})
      : super(key: key);

  @override
  State<TagWidget> createState() => _TagWidgetState();
}

class _TagWidgetState extends State<TagWidget> {
  late InfiniteScrollController controller;
  bool autoPlay = true;
  dynamic _timer;

  @override
  void initState() {
    super.initState();
    controller = InfiniteScrollController();
    _timer = Timer.periodic(Duration(milliseconds: 5000), (_) {
      if (autoPlay) {
        controller.nextItem();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer.isActive) {
      _timer.cancel();
    }
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
          height: 35,
          alignment: Alignment.topCenter,
          margin: EdgeInsets.only(left: 2.5),
          child: Row(children: <Widget>[
            Text(
              widget.data.label,
              style: TextStyle(fontSize: 19),
            ),
            Icon(Icons.arrow_forward_ios, size: 18)
          ]),
          width: double.infinity),
      SizedBox(
        height: 240,
        child: InfiniteCarousel.builder(
          itemCount: widget.data.video.length,
          itemExtent: MediaQueryData.fromWindow(window).size.width / 2,
          controller: controller,
          center: false,
          anchor: 1,
          velocityFactor: 1,
          itemBuilder: (context, itemIndex, realIndex) {
            String heroTag = UniqueKey().toString();
            return Padding(
              padding: EdgeInsets.all(3),
              child: Column(
                children: [
                  HomeTagCard(
                      heroTag: 't$heroTag',
                      data: widget.data.video[itemIndex][0],
                      onTap: () {
                        List<String> tagList = Utils.getUrlParamsByName(
                            widget.data.video[itemIndex][0].htmlUrl, 'tag');
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => SearchScreen(
                                    tagList: tagList,
                                  )),
                        );
                      },
                      onLongPress: () {
                        autoPlay = false;
                        Navigator.of(context)
                            .push(PageRouteBuilder(
                                opaque: false,
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return AnimatedBuilder(
                                    animation: animation,
                                    builder: (context, child) {
                                      return Opacity(
                                        opacity: widget.opacityCurve
                                            .transform(animation.value),
                                        child: HeroSlidePage(
                                            heroTag: 't$heroTag',
                                            url: widget
                                                .data.video[itemIndex][0].imgUrl
                                            // 'http://img5.mtime.cn/mt/2022/01/19/102417.23221502_1280X720X2.jpg',
                                            ),
                                      );
                                    },
                                  );
                                }))
                            .then((value) => autoPlay = true);
                      }),
                  HomeTagCard(
                      heroTag: 'b$heroTag',
                      data: widget.data.video[itemIndex][1],
                      onTap: () {
                        List<String> tagList = Utils.getUrlParamsByName(
                            widget.data.video[itemIndex][1].htmlUrl, 'tag');
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => SearchScreen(
                                    tagList: tagList,
                                  )),
                        );
                      },
                      onLongPress: () {
                        autoPlay = false;
                        Navigator.of(context)
                            .push(PageRouteBuilder(
                                opaque: false,
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return AnimatedBuilder(
                                    animation: animation,
                                    builder: (context, child) {
                                      return Opacity(
                                        opacity: widget.opacityCurve
                                            .transform(animation.value),
                                        child: HeroSlidePage(
                                            heroTag: 'b$heroTag',
                                            url: widget
                                                .data.video[itemIndex][1].imgUrl
                                            // 'http://img5.mtime.cn/mt/2022/01/19/102417.23221502_1280X720X2.jpg',
                                            ),
                                      );
                                    },
                                  );
                                }))
                            .then((value) => autoPlay = true);
                      })
                ],
              ),
            );
          },
        ),
      ),
    ]);
  }
}
