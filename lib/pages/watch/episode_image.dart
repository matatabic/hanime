import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/common_image.dart';

class EpisodePhoto extends StatelessWidget {
  final String imgUrl;
  final double width;
  final double height;
  final bool selector;

  const EpisodePhoto(
      {Key? key,
      required this.imgUrl,
      required this.width,
      required this.height,
      this.selector = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            border: Border.all(
          color: selector ? Colors.pinkAccent : Colors.grey, //边框颜色
          width: 1.0, //边框粗细
        )),
        child: CommonImages(
          imgUrl:
              // imgUrl,
              'http://img5.mtime.cn/mt/2022/01/19/102417.23221502_1280X720X2.jpg',
        ));
  }
}
