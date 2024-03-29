import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectedCover extends StatelessWidget {
  final double width;
  final double height;
  const SelectedCover({Key? key, required this.width, required this.height})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Opacity(
          opacity: 0.7,
          child: Container(
            width: width,
            height: height,
            color: Colors.black,
          ),
        ),
        Center(
          child: Text("正在播放"),
        )
      ],
    );
  }
}
