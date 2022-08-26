import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/common/common_image.dart';
import 'package:hanime/common/hero_photo_view.dart';
import 'package:hanime/common/modal_bottom_route.dart';
import 'package:hanime/entity/watch_entity.dart';

import 'IconWidget/download_widget.dart';
import 'IconWidget/like_widget.dart';

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
              // onTap: () {
              //   Navigator.of(context).push(NoAnimRouter(
              //     HeroPhotoView(
              //       heroTag: heroTag,
              //       maxScale: 1.5,
              //       imageProvider: NetworkImage(watchEntity.info.imgUrl),
              //     ),
              //   ));
              // },
              onLongPress: () {
                Navigator.of(context).push(NoAnimRouter(
                  HeroPhotoView(
                    heroTag: heroTag,
                    maxScale: 1.5,
                    imageProvider: NetworkImage(watchEntity.info.imgUrl),
                  ),
                ));
              },
              child: Hero(
                  tag: heroTag,
                  child: ClipOval(
                    child: Container(
                      width: Adapt.px(140),
                      height: Adapt.px(140),
                      child: CommonNormalImage(imgUrl: watchEntity.info.imgUrl),
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
