import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/selected_cover.dart';
import 'package:hanime/entity/watch_entity.dart';
import 'package:hanime/pages/watch/episode_item.dart';

import '../../component/loading_cover.dart';

class EpisodeScreen extends StatefulWidget {
  final WatchEntity watchEntity;
  final bool direction;
  final double? containerHeight;
  final double itemWidth;
  final double itemHeight;
  final Function(int index) onTap;
  final Function(String url) playerChange;
  final Function(String htmlUrl) loadData;

  const EpisodeScreen(
      {Key? key,
      required this.watchEntity,
      required this.onTap,
      required this.direction,
      this.containerHeight,
      required this.itemWidth,
      required this.itemHeight,
      required this.playerChange,
      required this.loadData})
      : super(key: key);

  @override
  State<EpisodeScreen> createState() => _EpisodeScreenState();
}

class _EpisodeScreenState extends State<EpisodeScreen> {
  double itemSpace = 15;
  bool _loading = false;
  dynamic _videoIndex;

  @override
  Widget build(BuildContext context) {
    double scrollOffset;
    if (widget.direction) {
      scrollOffset =
          widget.watchEntity.info.videoIndex * (widget.itemWidth + itemSpace) -
              (MediaQuery.of(context).size.width - 2 * itemSpace) / 2 +
              widget.itemWidth / 2;
    } else {
      scrollOffset = (_videoIndex != null
                  ? _videoIndex
                  : widget.watchEntity.info.videoIndex) *
              (widget.itemHeight + itemSpace) -
          (MediaQuery.of(context).size.height - 2 * itemSpace) / 2 +
          widget.itemHeight / 2;
    }

    return Container(
      color: Color.fromRGBO(48, 48, 48, 1),
      height: widget.direction
          ? widget.containerHeight
          : MediaQuery.of(context).size.height - 25,
      padding: EdgeInsets.symmetric(horizontal: itemSpace),
      child: ListView.separated(
          // shrinkWrap: true,
          controller: ScrollController(initialScrollOffset: scrollOffset),
          scrollDirection: widget.direction ? Axis.horizontal : Axis.vertical,
          itemCount: widget.watchEntity.episode.length,
          separatorBuilder: (BuildContext context, int index) => Container(
                width: widget.direction ? itemSpace : 0,
                height: widget.direction ? 0 : itemSpace,
              ),
          itemBuilder: (BuildContext context, int index) {
            return EpisodeWrapper(
              watchEpisode: widget.watchEntity.episode[index],
              selector: _videoIndex == null
                  ? widget.watchEntity.info.videoIndex == index
                  : _videoIndex == index,
              itemWidth: widget.itemWidth,
              itemHeight: widget.itemHeight,
              direction: widget.direction,
              onTap: () {
                widget.onTap(index);
              },
              playerChange: (String url) => widget.playerChange(url),
              loadData: (htmlUrl) => widget.loadData(htmlUrl),
              index: index,
              loading: _loading,
            );
          }),
    );
  }
}

class EpisodeWrapper extends StatefulWidget {
  final WatchEpisode watchEpisode;
  final VoidCallback onTap;
  final bool selector;
  final bool direction;
  final double itemWidth;
  final double itemHeight;
  final Function(String url) playerChange;
  final int index;
  final Function(String htmlUrl) loadData;
  final bool loading;

  const EpisodeWrapper(
      {Key? key,
      required this.watchEpisode,
      required this.onTap,
      required this.selector,
      required this.direction,
      required this.itemWidth,
      required this.itemHeight,
      required this.index,
      required this.loadData,
      required this.playerChange,
      required this.loading})
      : super(key: key);

  @override
  State<EpisodeWrapper> createState() => _EpisodeWrapperState();
}

class _EpisodeWrapperState extends State<EpisodeWrapper> {
  bool _loading = false;
  dynamic _videoIndex;
  bool _selector = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (_loading) {
          return;
        }
        print("12321321");
        setState(() {
          _selector = true;
          _loading = true;
          _videoIndex = widget.index;
        });
        // WatchEntity data = await widget.loadData(widget.watchEpisode.htmlUrl);
        // widget.playerChange(data.videoData.video[0].list[0].url);

        setState(() {
          // _shareTitle = data.info.shareTitle;
          _loading = false;
        });
      },
      child: Container(
        width: widget.itemWidth,
        height: widget.itemHeight,
        child: Flex(
          direction: widget.direction ? Axis.vertical : Axis.horizontal,
          children: [
            Stack(children: [
              EpisodeItem(
                width: widget.itemWidth,
                height: widget.itemHeight,
                imgUrl: widget.watchEpisode.imgUrl,
                selector: _selector,
              ),
              if (widget.loading && _selector)
                LoadingCover(
                  width: widget.itemWidth,
                  height: widget.itemHeight,
                ),
              if (!widget.loading && _selector)
                SelectedCover(
                  width: widget.itemWidth,
                  height: widget.itemHeight,
                )
            ]),
            Expanded(
              child: Center(
                child: Text(
                  widget.watchEpisode.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: _selector ? Colors.pinkAccent : Colors.white,
                      fontWeight:
                          _selector ? FontWeight.bold : FontWeight.normal),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  _onTapHandle(int index) {
    if (_loading) {
      return;
    }
    setState(() {
      _loading = true;
      _videoIndex = index;
    });
    // WatchEntity data = await widget.loadData(widget.watchEpisode.htmlUrl);
    // widget.playerChange(data.videoData.video[0].list[0].url);

    setState(() {
      // _shareTitle = data.info.shareTitle;
      _loading = false;
    });
  }
}

// class EpisodeWrapper extends StatelessWidget {
//   final WatchEpisode videoList;
//   final VoidCallback onTap;
//   final bool selector;
//   final bool direction;
//   final double itemWidth;
//   final double itemHeight;
//   final bool loading;
//
//   const EpisodeWrapper(
//       {Key? key,
//       required this.videoList,
//       required this.onTap,
//       required this.selector,
//       required this.direction,
//       required this.itemWidth,
//       required this.itemHeight,
//       required this.loading})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         width: itemWidth,
//         height: itemHeight,
//         child: Flex(
//           direction: direction ? Axis.vertical : Axis.horizontal,
//           children: [
//             Stack(children: [
//               EpisodeItem(
//                 width: itemWidth,
//                 height: itemHeight,
//                 imgUrl: videoList.imgUrl,
//                 selector: selector,
//               ),
//               if (loading && selector)
//                 LoadingCover(
//                   width: itemWidth,
//                   height: itemHeight,
//                 ),
//               if (!loading && selector)
//                 SelectedCover(
//                   width: itemWidth,
//                   height: itemHeight,
//                 )
//             ]),
//             Expanded(
//               child: Center(
//                 child: Text(
//                   videoList.title,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                       color: selector ? Colors.pinkAccent : Colors.white,
//                       fontWeight:
//                           selector ? FontWeight.bold : FontWeight.normal),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
