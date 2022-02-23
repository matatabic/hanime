import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/entity/watch_entity.dart';

class EpisodeScreen extends StatelessWidget {
  final WatchEntity watchEntity;
  final String videoIndex;
  final Future<Null> onTap;

  const EpisodeScreen({
    Key? key,
    required this.watchEntity,
    required this.videoIndex,
    required Future<Null> Function(int) onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          color: Color(0x5757571C),
          height: 100,
          margin: EdgeInsets.only(top: 15),
          child: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipOval(
                    child: Image.network(
                      watchEntity.info.imgUrl,
                      // 'https://pic2.zhimg.com/v2-639b49f2f6578eabddc458b84eb3c6a1.jpg',
                      fit: BoxFit.cover,
                      width: 70.0,
                      height: 70.0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(watchEntity.info.title),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(watchEntity.info.countTitle),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        Container(
          height: 110,
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: ListView.separated(
              shrinkWrap: true,
              controller: ScrollController(initialScrollOffset: 300),
              scrollDirection: Axis.horizontal,
              itemCount: watchEntity.videoList.length,
              separatorBuilder: (BuildContext context, int index) =>
                  VerticalDivider(
                    width: 20.0,
                    // color: Color(0xFFFFFFFF),
                  ),
              itemBuilder: (BuildContext context, int index) {
                return Episode(
                  videoList: watchEntity.videoList[index],
                  selector: videoIndex == null
                      ? watchEntity.info.videoIndex == index.toString()
                      : videoIndex == index,
                  onTap: onTap(index),
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
        child: Column(
          children: [
            Container(
              // width: 160,
              height: 90,
              decoration: BoxDecoration(
                  border: new Border.all(
                color: this.selector ? Colors.pinkAccent : Colors.grey, //边框颜色
                width: 1.0, //边框粗细
              )),
              child: Image.network(
                this.videoList.imgUrl,
                // 'http://img5.mtime.cn/mt/2022/01/19/102417.23221502_1280X720X2.jpg',
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!.toDouble()
                          : null,
                    ),
                  );
                },
              ),
            ),
            Text(
              this.videoList.title,
              style: TextStyle(
                  color: this.selector ? Colors.pinkAccent : Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
