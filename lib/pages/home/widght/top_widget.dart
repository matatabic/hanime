import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/common/slide_page.dart';
import 'package:hanime/entity/home_entity.dart';
import 'package:hanime/pages/watch/watch_screen.dart';

import '../cover_photo.dart';

class TopWidget extends StatelessWidget {
  final HomeTop data;

  TopWidget({Key? key, required this.data}) : super(key: key);

  static const opacityCurve = Interval(0.0, 1, curve: Curves.fastOutSlowIn);

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
          height: Adapt.px(400),
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: data.video.length,
              itemBuilder: (BuildContext context, int index) {
                String heroTag = UniqueKey().toString();
                return CoverPhoto(
                  heroTag: heroTag,
                  title: data.video[index].title,
                  imgUrl: data.video[index].imgUrl,
                  latest: data.video[index].latest,
                  width: Adapt.px(270),
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) =>
                              WatchScreen(htmlUrl: data.video[index].htmlUrl)),
                    );
                  },
                  onLongPress: () {
                    // Navigator.of(context).push(PageRouteBuilder<void>(
                    //     pageBuilder: (BuildContext context,
                    //         Animation<double> animation,
                    //         Animation<double> secondaryAnimation) {
                    //   // 创建一个 RoutePageBuilder
                    //   return AnimatedBuilder(
                    //       animation: animation,
                    //       builder: (context, child) {
                    //         /// 设置透明度组件
                    //         return Opacity(
                    //           /// 当前的透明度值 , 取值 0.0 ~ 1.0
                    //           opacity: opacityCurve.transform(animation.value),
                    //           // 主要显示的使用透明度控制的组件
                    //           // 页面 2 组件
                    //           child: SlidePage(
                    //             heroTag: heroTag,
                    //             url:
                    //                 'http://img5.mtime.cn/mt/2022/01/19/102417.23221502_1280X720X2.jpg',
                    //           ),
                    //         );
                    //       });
                    // }));
                    Navigator.of(context).push(PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return AnimatedBuilder(
                            animation: animation,
                            builder: (context, child) {
                              return Opacity(
                                opacity:
                                    opacityCurve.transform(animation.value),
                                child: SlidePage(
                                  heroTag: heroTag,
                                  url:
                                      'http://img5.mtime.cn/mt/2022/01/19/102417.23221502_1280X720X2.jpg',
                                ),
                              );
                            },
                          );
                        }));

                    // Navigator.push(
                    //     context,
                    //     FadeRouter(
                    //       child: SlidePage(
                    //         heroTag: heroTag,
                    //         url:
                    //             'http://img5.mtime.cn/mt/2022/01/19/102417.23221502_1280X720X2.jpg',
                    //       ),
                    //     ));
                  },
                );
              }))
    ]);
  }
}
