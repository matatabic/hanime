import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/entity/watch_entity.dart';

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
              width: 160,
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
