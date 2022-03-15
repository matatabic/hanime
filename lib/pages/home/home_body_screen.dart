import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/entity/home_entity.dart';
import 'package:hanime/pages/watch/watch_screen.dart';

import 'cover_photo.dart';

Widget getGroupContainer(HomeVideo item) {
  return Column(children: <Widget>[
    Container(
      height: Adapt.px(70),
      alignment: Alignment.topCenter,
      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: Row(children: <Widget>[
        Text(
          item.label,
          style: TextStyle(fontSize: Adapt.px(38)),
        ),
        Icon(
          Icons.arrow_forward_ios,
          size: Adapt.px(36),
        )
      ]),
      width: double.infinity,
    ),
    Container(
        height: Adapt.px(380),
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: item.data.length,
            itemBuilder: (BuildContext context, int index) {
              return CoverPhoto(
                data: item.data[index],
                width: Adapt.px(260),
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => WatchScreen(
                              htmlUrl: item.data[index].url,
                            )),
                  );
                },
              );
            }))
  ]);
}
