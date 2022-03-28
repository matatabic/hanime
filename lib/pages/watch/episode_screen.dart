import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/entity/watch_entity.dart';
import 'package:hanime/pages/watch/episode_image.dart';
import 'package:hanime/pages/watch/selected_cover.dart';
import 'package:hanime/providers/watch_state.dart';
import 'package:provider/src/provider.dart';

import 'loading_cover.dart';

const double LIST_SPACE = 20;

class EpisodeScreen extends StatelessWidget {
  final WatchEntity watchEntity;
  final bool direction;
  final double? containerHeight;
  final double itemWidth;
  final double itemHeight;

  final Function(int index) onTap;

  const EpisodeScreen({
    Key? key,
    required this.watchEntity,
    required this.onTap,
    required this.direction,
    this.containerHeight,
    required this.itemWidth,
    required this.itemHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var scrollOffset;
    if (watchEntity.info.videoIndex == 0) {
      scrollOffset = 0;
    } else {
      if (direction) {
        scrollOffset =
            (watchEntity.info.videoIndex) * (itemWidth + LIST_SPACE) -
                (MediaQuery.of(context).size.width / 2);
      } else {
        scrollOffset =
            (watchEntity.info.videoIndex) * (itemHeight + LIST_SPACE) -
                ((MediaQuery.of(context).size.height) / 2);
      }
    }
    // scrollOffset = double.parse(scrollOffset.toString());

    return Container(
      color: Color.fromRGBO(48, 48, 48, 1),
      height: direction
          ? Adapt.px(containerHeight)
          : MediaQuery.of(context).size.height - Adapt.px(50),
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: ListView.separated(
          // shrinkWrap: true,
          controller:
              ScrollController(initialScrollOffset: Adapt.px(scrollOffset)),
          scrollDirection: direction ? Axis.horizontal : Axis.vertical,
          itemCount: watchEntity.episode.length,
          separatorBuilder: (BuildContext context, int index) => Container(
                width: Adapt.px(direction ? LIST_SPACE : 0),
                height: Adapt.px(direction ? 0 : LIST_SPACE),
              ),
          itemBuilder: (BuildContext context, int index) {
            return Episode(
              videoList: watchEntity.episode[index],
              selector: context.watch<WatchState>().videoIndex == null
                  ? watchEntity.info.videoIndex == index
                  : context.watch<WatchState>().videoIndex == index,
              itemWidth: Adapt.px(itemWidth),
              itemHeight: Adapt.px(itemHeight),
              direction: direction,
              onTap: () => {onTap(index)},
            );
          }),
    );
  }
}

class Episode extends StatelessWidget {
  final WatchEpisode videoList;
  final VoidCallback onTap;
  final bool selector;
  final bool direction;
  final double itemWidth;
  final double itemHeight;

  const Episode(
      {Key? key,
      required this.videoList,
      required this.onTap,
      required this.selector,
      required this.direction,
      required this.itemWidth,
      required this.itemHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: itemWidth,
        child: Flex(
          direction: direction ? Axis.vertical : Axis.horizontal,
          children: [
            Stack(children: [
              EpisodePhoto(
                width: itemWidth,
                height: itemHeight,
                imgUrl: videoList.imgUrl,
                selector: selector,
              ),
              if (context.watch<WatchState>().loading && selector)
                LoadingCover(
                  width: itemWidth,
                  height: itemHeight,
                ),
              if (!context.watch<WatchState>().loading && selector)
                SelectedCover(
                  width: itemWidth,
                  height: itemHeight,
                )
            ]),
            Expanded(
              child: Center(
                child: Text(
                  videoList.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: selector ? Colors.pinkAccent : Colors.white,
                      fontWeight:
                          selector ? FontWeight.bold : FontWeight.normal),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
