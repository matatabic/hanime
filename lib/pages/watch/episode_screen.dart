import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/selected_cover.dart';
import 'package:hanime/entity/watch_entity.dart';
import 'package:hanime/pages/watch/episode_item.dart';

import '../../component/loading_cover.dart';

const double LIST_SPACE = 15;

class EpisodeScreen extends StatelessWidget {
  final WatchEntity watchEntity;
  final bool direction;
  final double? containerHeight;
  final double itemWidth;
  final double itemHeight;
  final dynamic videoIndex;
  final bool loading;

  final Function(int index) onTap;

  const EpisodeScreen({
    Key? key,
    required this.watchEntity,
    required this.onTap,
    required this.direction,
    this.containerHeight,
    required this.itemWidth,
    required this.itemHeight,
    required this.videoIndex,
    required this.loading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double scrollOffset;
    if (watchEntity.info.videoIndex == 0) {
      scrollOffset = 0;
    } else {
      if (direction) {
        scrollOffset = watchEntity.info.videoIndex * (itemWidth + LIST_SPACE) -
            (MediaQuery.of(context).size.width - 2 * LIST_SPACE) / 2 +
            itemWidth / 2;
      } else {
        scrollOffset =
            (videoIndex != null ? videoIndex : watchEntity.info.videoIndex) *
                    (itemHeight + LIST_SPACE) -
                (MediaQuery.of(context).size.height - 2 * LIST_SPACE) / 2 +
                itemHeight / 2;
      }
    }

    return Container(
      color: Color.fromRGBO(48, 48, 48, 1),
      height:
          direction ? containerHeight : MediaQuery.of(context).size.height - 25,
      padding: EdgeInsets.symmetric(horizontal: LIST_SPACE),
      child: ListView.separated(
          // shrinkWrap: true,
          controller: ScrollController(initialScrollOffset: scrollOffset),
          scrollDirection: direction ? Axis.horizontal : Axis.vertical,
          itemCount: watchEntity.episode.length,
          separatorBuilder: (BuildContext context, int index) => Container(
                width: direction ? LIST_SPACE : 0,
                height: direction ? 0 : LIST_SPACE,
              ),
          itemBuilder: (BuildContext context, int index) {
            return Episode(
              videoList: watchEntity.episode[index],
              selector: videoIndex == null
                  ? watchEntity.info.videoIndex == index
                  : videoIndex == index,
              itemWidth: itemWidth,
              itemHeight: itemHeight,
              direction: direction,
              onTap: () => {onTap(index)},
              loading: loading,
              videoIndex: videoIndex,
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
  final dynamic videoIndex;
  final bool loading;

  const Episode(
      {Key? key,
      required this.videoList,
      required this.onTap,
      required this.selector,
      required this.direction,
      required this.itemWidth,
      required this.itemHeight,
      required this.videoIndex,
      required this.loading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: itemWidth,
        height: itemHeight,
        child: Flex(
          direction: direction ? Axis.vertical : Axis.horizontal,
          children: [
            Stack(children: [
              EpisodeItem(
                width: itemWidth,
                height: itemHeight,
                imgUrl: videoList.imgUrl,
                selector: selector,
              ),
              if (loading && selector)
                LoadingCover(
                  width: itemWidth,
                  height: itemHeight,
                ),
              if (!loading && selector)
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
