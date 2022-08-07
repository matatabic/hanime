import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/common/common_image.dart';
import 'package:hanime/common/hero_photo_view.dart';
import 'package:hanime/entity/watch_entity.dart';

import 'download_widget.dart';
import 'like_widget.dart';

class BriefScreen extends StatelessWidget {
  final WatchEntity watchEntity;
  final Function(String url) playerChange;

  BriefScreen({Key? key, required this.watchEntity, required this.playerChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String heroTag = UniqueKey().toString();
    return Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        color: Color.fromRGBO(58, 60, 63, 1),
        height: Adapt.px(220),
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            InkWell(
              onTap: () {
                // Navigator.of(context).push(PageRouteBuilder(
                //     opaque: false,
                //     pageBuilder: (context, animation, secondaryAnimation) {
                //       return AnimatedBuilder(
                //         animation: animation,
                //         builder: (context, child) {
                //           return HeroSlidePage(
                //               heroTag: heroTag, url: watchEntity.info.imgUrl
                //               // 'http://img5.mtime.cn/mt/2022/01/19/102417.23221502_1280X720X2.jpg',
                //               );
                //         },
                //       );
                //     }));
                // Navigator.of(context).push(NoAnimRouter(
                //   HeroPhotoView(
                //     heroTag: heroTag,
                //     maxScale: 1.5,
                //     imageProvider: NetworkImage(watchEntity.info.imgUrl),
                //   ),
                // ));
                Navigator.of(context).push(
                  PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 500),
                    pageBuilder: (ctx, anim1, anim2) {
                      return FadeTransition(
                        opacity: anim1,
                        child: HeroPhotoView(
                          heroTag: heroTag,
                          maxScale: 1.5,
                          imageProvider: NetworkImage(watchEntity.info.imgUrl),
                        ),
                      );
                    },
                  ),
                );
                // Navigator.of(context).push(PageRouteBuilder(
                //     opaque: false,
                //     pageBuilder: (context, animation, secondaryAnimation) {
                //       return AnimatedBuilder(
                //         animation: animation,
                //         builder: (context, child) {
                //           return HeroPhotoView(
                //             heroTag: heroTag,
                //             maxScale: 1.5,
                //             imageProvider:
                //                 NetworkImage(watchEntity.info.imgUrl),
                //           );
                //         },
                //       );
                //     }));
              },
              onLongPress: () {
                Navigator.of(context).push(PageRouteBuilder(
                    opaque: false,
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return AnimatedBuilder(
                        animation: animation,
                        builder: (context, child) {
                          return HeroPhotoView(
                            heroTag: heroTag,
                            maxScale: 1.5,
                            imageProvider:
                                NetworkImage(watchEntity.info.imgUrl),
                          );
                        },
                      );
                    }));
              },
              child: Hero(
                  tag: heroTag,
                  child: ClipOval(
                    child: Container(
                      width: Adapt.px(140),
                      height: Adapt.px(140),
                      child: CommonImages(
                        imgUrl: watchEntity.info.imgUrl,
                      ),
                    ),
                  )),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: Adapt.px(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(watchEntity.info.title,
                        maxLines: 2, overflow: TextOverflow.ellipsis),
                    Padding(
                      padding: EdgeInsets.only(top: Adapt.px(5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            watchEntity.info.countTitle,
                          ),
                          Container(
                            width: Adapt.px(150),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DownloadWidget(
                                    info: watchEntity.info,
                                    videoUrl: watchEntity
                                        .videoData.video[0].list[0].url),
                                LikeWidget(info: watchEntity.info)
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
