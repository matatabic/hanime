import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/common_image.dart';

class CoverPhoto extends StatelessWidget {
  final String title;
  final String imgUrl;
  final bool latest;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final double width;
  final String heroTag;

  CoverPhoto(
      {Key? key,
      required this.title,
      required this.imgUrl,
      this.latest = false,
      required this.onTap,
      required this.onLongPress,
      required this.width,
      required this.heroTag})
      : super(key: key);

  Widget build(BuildContext context) {
    double h = 25, w = 100;

    final span = TextSpan(text: "最新", style: TextStyle(fontSize: 15));

    final tp = TextPainter(text: span, textDirection: TextDirection.ltr)
      ..layout();
    h = tp.height;
    w = tp.width * 2;

    return Container(
        width: width,
        margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
        child: InkWell(
            onTap: onTap,
            onLongPress: onLongPress,
            child: ClipRect(
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment(-1, 1),
                children: <Widget>[
                  ConstrainedBox(
                      child: Hero(
                          tag: heroTag, child: CommonImages(imgUrl: imgUrl)),
                      constraints: new BoxConstraints.expand()),
                  latest
                      ? Positioned(
                          right: 0,
                          top: sqrt(w * w / 2 - sqrt2 * w * h + h * h),
                          child: Transform.rotate(
                            alignment: Alignment.bottomRight,
                            angle: pi / 4,
                            child: Container(
                              color: Colors.purpleAccent,
                              width: w,
                              height: h,
                              child: Center(child: Text.rich(span)),
                            ),
                          ))
                      : Container(),
                  Container(
                    child: Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(2.5, 2.5),
                            blurRadius: 3.5,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )));
  }
}
