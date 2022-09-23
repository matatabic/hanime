import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/selected_cover.dart';
import 'package:hanime/entity/watch_entity.dart';
import 'package:hanime/pages/watch/episode_item.dart';
import 'package:hanime/providers/watch_model.dart';
import 'package:provider/src/provider.dart';

import '../../component/loading_cover.dart';

const double LIST_SPACE = 15;

class EpisodeScreen extends StatefulWidget {
  final WatchEntity watchEntity;
  final bool direction;
  final double? containerHeight;
  final double itemWidth;
  final double itemHeight;
  final Function(String) loadData;
  final Function(String) playerChange;

  const EpisodeScreen(
      {Key? key,
      required this.watchEntity,
      required this.direction,
      this.containerHeight,
      required this.itemWidth,
      required this.itemHeight,
      required this.loadData,
      required this.playerChange})
      : super(key: key);

  @override
  _EpisodeScreenState createState() => _EpisodeScreenState();
}

class _EpisodeScreenState extends State<EpisodeScreen> {
  var _videoIndex;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    double scrollOffset;
    if (widget.watchEntity.info.videoIndex == 0) {
      scrollOffset = 0;
    } else {
      if (widget.direction) {
        scrollOffset = widget.watchEntity.info.videoIndex *
                (widget.itemWidth + LIST_SPACE) -
            (MediaQuery.of(context).size.width - 2 * LIST_SPACE) / 2 +
            widget.itemWidth / 2;
      } else {
        scrollOffset = (_videoIndex != null
                    ? _videoIndex
                    : widget.watchEntity.info.videoIndex) *
                (widget.itemHeight + LIST_SPACE) -
            (MediaQuery.of(context).size.height - 2 * LIST_SPACE) / 2 +
            widget.itemHeight / 2;
      }
    }

    return Container(
      color: Color.fromRGBO(48, 48, 48, 1),
      height: widget.direction
          ? widget.containerHeight
          : MediaQuery.of(context).size.height - 25,
      padding: EdgeInsets.symmetric(horizontal: LIST_SPACE),
      child: ListView.separated(
          // shrinkWrap: true,
          controller: ScrollController(initialScrollOffset: scrollOffset),
          scrollDirection: widget.direction ? Axis.horizontal : Axis.vertical,
          itemCount: widget.watchEntity.episode.length,
          separatorBuilder: (BuildContext context, int index) => Container(
                width: widget.direction ? LIST_SPACE : 0,
                height: widget.direction ? 0 : LIST_SPACE,
              ),
          itemBuilder: (BuildContext context, int index) {
            return Episode(
              videoList: widget.watchEntity.episode[index],
              selector: _videoIndex == null
                  ? widget.watchEntity.info.videoIndex == index
                  : _videoIndex == index,
              itemWidth: widget.itemWidth,
              itemHeight: widget.itemHeight,
              direction: widget.direction,
              onTap: () async {
                if (_loading) {
                  return;
                }
                setState(() {
                  _loading = true;
                  _videoIndex = index;
                });
                WatchEntity data = await widget
                    .loadData(widget.watchEntity.episode[index].htmlUrl);
                print(data);
                widget.playerChange(data.videoData.video[0].list[0].url);
                //
                context.read<WatchModel>().setShareTitle = data.info.shareTitle;
                setState(() {
                  // _shareTitle = data.info.shareTitle;
                  _loading = false;
                });
              },
              loading: _loading,
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
  final bool loading;

  const Episode(
      {Key? key,
      required this.videoList,
      required this.onTap,
      required this.selector,
      required this.direction,
      required this.itemWidth,
      required this.itemHeight,
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
