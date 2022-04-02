import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/common/common_image.dart';
import 'package:hanime/entity/home_entity.dart';

class HomeCard extends StatelessWidget {
  final HomeLatestVideoHomeLatestVideo data;
  const HomeCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Flex(direction: Axis.vertical, children: [
          Expanded(
              flex: 2,
              child: Stack(
                alignment: Alignment(-1, 1),
                children: [
                  ConstrainedBox(
                      child: CommonImages(
                        imgUrl:
                            'http://img5.mtime.cn/mt/2022/01/19/102417.23221502_1280X720X2.jpg',
                        // data.imgUrl
                      ),
                      constraints: new BoxConstraints.expand()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Adapt.px(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          Icon(Icons.access_alarm_outlined, size: Adapt.px(40)),
                          Text(data.created)
                        ]),
                        Text(data.duration)
                      ],
                    ),
                  )
                ],
              )),
          Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(Adapt.px(5)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data.title,
                        maxLines: 2,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        Container(
                            margin: EdgeInsets.only(right: Adapt.px(15)),
                            decoration: new BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2.0)),
                              border: new Border.all(
                                  width: 1, color: Colors.redAccent),
                            ),
                            child: Center(
                              child: Text(data.genre,
                                  style: TextStyle(
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.bold)),
                            )),
                        Text(
                          data.author,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ))
        ]));
  }
}
