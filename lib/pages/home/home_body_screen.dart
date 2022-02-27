import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/modal_bottom_route.dart';
import 'package:hanime/entity/home_entity.dart';
import 'package:hanime/pages/watch/watch_screen.dart';

import 'cover_photo.dart';

Widget getGroupContainer(HomeList item) {
  return Column(children: <Widget>[
    Container(
      height: 35,
      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: Row(children: <Widget>[
        Text(
          item.label,
          style: TextStyle(fontSize: 18),
        ),
        Icon(
          Icons.arrow_forward_ios,
          size: 18,
        )
      ]),
      width: double.infinity,
    ),
    Container(
        height: 190,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: item.data.length,
            itemBuilder: (BuildContext context, int index) {
              return CoverPhoto(
                data: item.data[index],
                width: 130,
                onTap: () {
                  Navigator.push(
                      context,
                      Right2LeftRouter(
                          child: WatchScreen(
                        htmlUrl: item.data[index].url,
                      )));
                },
              );
            }))
  ]);
}
