import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/common/common_image.dart';
import 'package:hanime/common/hero_photo.dart';
import 'package:hanime/common/modal_bottom_route.dart';
import 'package:hanime/entity/watch_entity.dart';
import 'package:hanime/services/watch_services.dart';
import 'package:hanime/utils/index.dart';

import 'like_screen.dart';

class BriefScreen extends StatelessWidget {
  final WatchEntity watchEntity;
  final Function(String url) playerChange;
  final String randomTag = '${randomNumber(1, 100)}${randomNumber(1, 100)}';

  BriefScreen({Key? key, required this.watchEntity, required this.playerChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        color: Color.fromRGBO(58, 60, 63, 1),
        height: Adapt.px(220),
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(NoAnimRouter(
                  HeroPhotoViewRouteWrapper(
                    randomNum: randomTag,
                    minScale: 1.0,
                    maxScale: 1.8,
                    imageProvider: NetworkImage(watchEntity.info.imgUrl),
                  ),
                ));
              },
              child: Hero(
                  tag: "heroTag$randomTag",
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
                          LikeScreen()
                          // LikeButton(
                          //   isLiked: true,
                          //   size: Adapt.px(60),
                          // ),
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

  getEpisodeData(htmlUrl) async {
    var data = await getWatchData(htmlUrl);
    WatchEntity watchEntity = WatchEntity.fromJson(data);

    return watchEntity;
  }
}
