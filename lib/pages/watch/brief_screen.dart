import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/hero_widget/hero_photo_view.dart';
import 'package:hanime/common/modal_bottom_route.dart';
import 'package:hanime/common/widget/common_image.dart';
import 'package:hanime/entity/watch_entity.dart';

import 'IconWidget/download_widget.dart';
import 'IconWidget/like_widget.dart';

class BriefScreen extends StatelessWidget {
  final WatchEntity watchEntity;
  final Function(String url) playerChange;
  final ScrollController controller;

  BriefScreen(
      {Key? key,
      required this.watchEntity,
      required this.playerChange,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String heroTag = UniqueKey().toString();

    return Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        color: Color.fromRGBO(58, 60, 63, 1),
        height: 110,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            InkWell(
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
                      width: 70,
                      height: 70,
                      child: CommonNormalImage(imgUrl: watchEntity.info.imgUrl),
                    ),
                  )),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(watchEntity.info.title,
                        maxLines: 2, overflow: TextOverflow.ellipsis),
                    Padding(
                      padding: EdgeInsets.only(top: 2.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            watchEntity.info.countTitle,
                          ),
                          Container(
                            width: 75,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DownloadWidget(
                                    info: watchEntity.info,
                                    videoUrl: watchEntity
                                        .videoData.video[0].list[0].url),
                                LikeWidget(
                                    info: watchEntity.info,
                                    episodeList: watchEntity.episode,
                                    controller: controller),
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
