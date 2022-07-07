import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/common/hero_photo.dart';
import 'package:hanime/common/modal_bottom_route.dart';
import 'package:hanime/component/anime_2card.dart';
import 'package:hanime/entity/home_entity.dart';
import 'package:hanime/pages/watch/watch_screen.dart';

class WatchWidget extends StatelessWidget {
  final HomeWatch data;

  WatchWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
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
        GridView.builder(
          shrinkWrap: true,
          physics: new NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(top: 0),
          itemCount: data.video.length,
          //调整间距
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //横轴元素个数
              crossAxisCount: 2,
              //纵轴间距
              mainAxisSpacing: Adapt.px(10),
              //横轴间距
              crossAxisSpacing: Adapt.px(10),
              //子组件宽高长度比例
              childAspectRatio: 1.05),
          itemBuilder: (BuildContext context, int index) {
            String heroTag = UniqueKey().toString();
            return Anime2Card(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) =>
                            WatchScreen(htmlUrl: data.video[index].htmlUrl)));
              },
              onLongPress: () {
                Navigator.of(context).push(NoAnimRouter(
                  HeroPhotoViewRouteWrapper(
                      heroTag: heroTag,
                      maxScale: 1.5,
                      imageProvider: NetworkImage(data.video[index].imgUrl)),
                ));
              },
              heroTag: heroTag,
              htmlUrl: data.video[index].htmlUrl,
              title: data.video[index].title,
              imgUrl: data.video[index].imgUrl,
              duration: data.video[index].duration,
              genre: data.video[index].genre,
              author: data.video[index].author,
              created: data.video[index].created,
            );
          },
          //加载内容
        ),
      ],
    );
  }
}
