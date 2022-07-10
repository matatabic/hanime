import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/entity/home_entity.dart';
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
            return Padding(
              padding: EdgeInsets.all(Adapt.px(6)),
              child: Column(
                children: [
                  HomeTagCard(
                      data: data.video[itemIndex][0],
                      index: 0,
                      onTap: () => {print(data.video)}),
                  HomeTagCard(
                      data: data.video[itemIndex][1],
                      index: 1,
                      onTap: () => {print("12321")})
                ],
              ),
            );
          },
        ),
      ),
    ]);
  }
}
