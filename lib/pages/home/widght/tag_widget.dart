import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/common/hero_slide_page.dart';
import 'package:hanime/entity/home_entity.dart';
import 'package:hanime/utils/index.dart';
import 'package:infinite_carousel/infinite_carousel.dart';

import '../home_tag_card.dart';

class TagWidget extends StatelessWidget {
  final HomeTag data;
  final Interval opacityCurve;

  TagWidget({Key? key, required this.data, required this.opacityCurve})
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
        height: Adapt.px(480),
        child: InfiniteCarousel.builder(
          itemCount: data.video.length,
          itemExtent: Adapt.screenW() / 2,
          center: false,
          anchor: 1,
          velocityFactor: 1,
          itemBuilder: (context, itemIndex, realIndex) {
            String heroTag = UniqueKey().toString();
            return Padding(
              padding: EdgeInsets.all(Adapt.px(6)),
              child: Column(
                children: [
                  HomeTagCard(
                      heroTag: 't$heroTag',
                      data: data.video[itemIndex][0],
                      onTap: () {
                        print(data.video[itemIndex][0].htmlUrl);
                        print(getUrlParamsByName(
                            data.video[itemIndex][0].htmlUrl, 'tag'));
                      },
                      onLongPress: () {
                        Navigator.of(context).push(PageRouteBuilder(
                            opaque: false,
                            pageBuilder:
                                (context, animation, secondaryAnimation) {
                              return AnimatedBuilder(
                                animation: animation,
                                builder: (context, child) {
                                  return Opacity(
                                    opacity:
                                        opacityCurve.transform(animation.value),
                                    child: HeroSlidePage(
                                      heroTag: 't$heroTag',
                                      url:
                                          'http://img5.mtime.cn/mt/2022/01/19/102417.23221502_1280X720X2.jpg',
                                    ),
                                  );
                                },
                              );
                            }));
                      }),
                  HomeTagCard(
                      heroTag: 'b$heroTag',
                      data: data.video[itemIndex][1],
                      onTap: () {
                        print(data.video[itemIndex][1].htmlUrl);
                        print(getUrlParamsByName(
                            data.video[itemIndex][1].htmlUrl, 'tag'));
                        List<String> tags = getUrlParamsByName(
                            data.video[itemIndex][1].htmlUrl, 'tag');
                        String url = urlAddAllTagParams(
                            "https://hanime1.me/search?query=&broad=on", tags);
                        print(url);
                      },
                      onLongPress: () {
                        Navigator.of(context).push(PageRouteBuilder(
                            opaque: false,
                            pageBuilder:
                                (context, animation, secondaryAnimation) {
                              return AnimatedBuilder(
                                animation: animation,
                                builder: (context, child) {
                                  return Opacity(
                                    opacity:
                                        opacityCurve.transform(animation.value),
                                    child: HeroSlidePage(
                                      heroTag: 'b$heroTag',
                                      url:
                                          'http://img5.mtime.cn/mt/2022/01/19/102417.23221502_1280X720X2.jpg',
                                    ),
                                  );
                                },
                              );
                            }));
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
