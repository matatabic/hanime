import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/hero_widget/hero_widget.dart';

class HeroSlidePage extends StatefulWidget {
  const HeroSlidePage({required this.url, required this.heroTag});
  final String url;
  final String heroTag;
  @override
  _HeroSlidePageState createState() => _HeroSlidePageState();
}

class _HeroSlidePageState extends State<HeroSlidePage> {
  GlobalKey<ExtendedImageSlidePageState> slidePageKey =
      GlobalKey<ExtendedImageSlidePageState>();

  @override
  Widget build(BuildContext context) {
    // timeDilation = 0.5;
    return Material(
      color: Colors.transparent,
      child: ExtendedImageSlidePage(
        key: slidePageKey,
        child: GestureDetector(
          child: HeroWidget(
            child: ExtendedImage.network(
              widget.url,
              mode: ExtendedImageMode.gesture,
              enableSlideOutPage: true,
            ),
            tag: widget.heroTag,
            slideType: SlideType.onlyImage,
            slidePagekey: slidePageKey,
          ),
          onTap: () {
            slidePageKey.currentState!.popPage();
            Navigator.pop(context);
          },
        ),
        slideAxis: SlideAxis.both,
        slideType: SlideType.onlyImage,
      ),
    );
  }
}
