import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/common/common_image.dart';
import 'package:hanime/entity/watch_entity.dart';
import 'package:hanime/providers/watch_state.dart';
import 'package:hanime/services/watch_services.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/src/provider.dart';

class BriefScreen extends StatelessWidget {
  final WatchEntity watchEntity;
  final Function(String url) playerChange;

  const BriefScreen(
      {Key? key, required this.watchEntity, required this.playerChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    WatchState watchState = context.read<WatchState>();
    return Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        color: Color.fromRGBO(58, 60, 63, 1),
        height: Adapt.px(220),
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            ClipOval(
              child: Container(
                width: Adapt.px(140),
                height: Adapt.px(140),
                child: CommonImages(
                  imgUrl: watchEntity.info.imgUrl,
                ),
              ),
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
                          LikeButton(
                            isLiked: true,
                            size: Adapt.px(60),
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

  getEpisodeData(htmlUrl) async {
    var data = await getWatchData(htmlUrl);
    WatchEntity watchEntity = WatchEntity.fromJson(data);

    return watchEntity;
  }
}
