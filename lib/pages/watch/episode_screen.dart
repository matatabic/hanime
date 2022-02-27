import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/entity/watch_entity.dart';
import 'package:hanime/pages/watch/episode_image.dart';
import 'package:hanime/providers/watch_state.dart';
import 'package:provider/src/provider.dart';

class EpisodeScreen extends StatelessWidget {
  final WatchEntity watchEntity;
  final dynamic videoIndex;
  final Function(int index) onTap;

  const EpisodeScreen({
    Key? key,
    required this.watchEntity,
    required this.videoIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var scrollOffset;
    if (watchEntity.info.videoIndex == '0') {
      scrollOffset = 0;
    } else if (watchEntity.info.videoIndex ==
        (watchEntity.videoList.length - 1).toString()) {
      scrollOffset = (watchEntity.videoList.length - 2) * 180 + 10;
    } else {
      scrollOffset = (double.parse(watchEntity.info.videoIndex)) * 180 -
          (MediaQuery.of(context).size.width / 4) +
          10;
    }
    scrollOffset = double.parse(scrollOffset.toString());

    return Column(
      children: [
        Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            color: Color(0x685F5F00),
            height: 100,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                ClipOval(
                  child: Container(
                    width: 70.0,
                    height: 70.0,
                    child: Image.network(
                      watchEntity.info.imgUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          child: Image.asset(
                            'assets/images/error.png',
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(watchEntity.info.shareTitle,
                            maxLines: 2, overflow: TextOverflow.ellipsis),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(watchEntity.info.countTitle),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )),
        Container(
          alignment: Alignment.topLeft,
          height: 110,
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: ListView.separated(
              shrinkWrap: true,
              controller: ScrollController(initialScrollOffset: scrollOffset),
              scrollDirection: Axis.horizontal,
              itemCount: watchEntity.videoList.length,
              separatorBuilder: (BuildContext context, int index) =>
                  VerticalDivider(
                    width: 20.0,
                  ),
              itemBuilder: (BuildContext context, int index) {
                return Episode(
                  videoList: watchEntity.videoList[index],
                  selector: videoIndex == null
                      ? watchEntity.info.videoIndex == index.toString()
                      : videoIndex == index,
                  onTap: () => {onTap(index)},
                );
              }),
        )
      ],
    );
  }
}

class Episode extends StatelessWidget {
  final WatchVideoList videoList;
  final VoidCallback onTap;
  final bool selector;
  const Episode(
      {Key? key,
      required this.videoList,
      required this.onTap,
      required this.selector})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 160,
        child: Column(
          children: [
            Stack(children: [
              EpisodePhoto(
                width: 160,
                height: 90,
                imgUrl: this.videoList.imgUrl,
                selector: this.selector,
              ),
              if (context.watch<WatchState>().loading && selector)
                LoadingCover(),
            ]),
            Expanded(
              child: Text(
                this.videoList.title,
                style: TextStyle(
                    color: this.selector ? Colors.pinkAccent : Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LoadingCover extends StatelessWidget {
  const LoadingCover({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Opacity(
          opacity: 0.7,
          child: Container(
            width: 160,
            height: 90,
            color: Colors.black,
          ),
        ),
        CircularProgressIndicator(
          value: null,
        ),
      ],
    );
  }
}
