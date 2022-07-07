import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/common/hero_photo.dart';
import 'package:hanime/common/modal_bottom_route.dart';
import 'package:hanime/entity/home_entity.dart';
import 'package:hanime/pages/watch/watch_screen.dart';
import 'package:infinite_carousel/infinite_carousel.dart';

import '../home_card.dart';

class LatestWidget extends StatelessWidget {
  final HomeLatest data;
  LatestWidget({Key? key, required this.data}) : super(key: key);

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
        height: Adapt.px(760),
        child: InfiniteCarousel.builder(
          itemCount: data.video.length,
          itemExtent: Adapt.screenW() / 2,
          center: false,
          anchor: 1,
          velocityFactor: 1,
          itemBuilder: (context, itemIndex, realIndex) {
            String heroTag = UniqueKey().toString();
            return Padding(
              padding: EdgeInsets.all(3),
              child: Column(
                children: [
                  HomeCard(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => WatchScreen(
                                  htmlUrl: data.video[itemIndex][0].htmlUrl)));
                    },
                    onLongPress: () {
                      Navigator.of(context).push(NoAnimRouter(
                        HeroPhotoViewRouteWrapper(
                          heroTag: 'l$heroTag',
                          maxScale: 1.5,
                          imageProvider:
                              NetworkImage(data.video[itemIndex][0].imgUrl),
                        ),
                      ));
                    },
                    heroTag: 'l$heroTag',
                    htmlUrl: data.video[itemIndex][0].htmlUrl,
                    imgUrl: data.video[itemIndex][0].imgUrl,
                    duration: data.video[itemIndex][0].duration,
                    title: data.video[itemIndex][0].title,
                    author: data.video[itemIndex][0].author,
                    genre: data.video[itemIndex][0].genre,
                    created: data.video[itemIndex][0].created,
                  ),
                  HomeCard(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => WatchScreen(
                                  htmlUrl: data.video[itemIndex][1].htmlUrl)));
                    },
                    onLongPress: () {
                      Navigator.of(context).push(NoAnimRouter(
                        HeroPhotoViewRouteWrapper(
                          heroTag: 'r$heroTag',
                          maxScale: 1.5,
                          imageProvider:
                              NetworkImage(data.video[itemIndex][1].imgUrl),
                        ),
                      ));
                    },
                    heroTag: 'r$heroTag',
                    htmlUrl: data.video[itemIndex][1].htmlUrl,
                    imgUrl: data.video[itemIndex][1].imgUrl,
                    duration: data.video[itemIndex][1].duration,
                    title: data.video[itemIndex][1].title,
                    author: data.video[itemIndex][1].author,
                    genre: data.video[itemIndex][1].genre,
                    created: data.video[itemIndex][1].created,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    ]);
  }
}
