import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class HeroPhotoViewRouteWrapper extends StatelessWidget {
  const HeroPhotoViewRouteWrapper({
    required this.imageProvider,
    required this.randomNum,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
  });

  final ImageProvider imageProvider;
  final BoxDecoration? backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final String randomNum;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(
        height: MediaQuery.of(context).size.height,
      ),
      color: Colors.black12,
      child: PhotoView(
        imageProvider: imageProvider,
        backgroundDecoration: BoxDecoration(color: Colors.black87),
        minScale: minScale,
        maxScale: maxScale,
        enablePanAlways: true,
        heroAttributes: PhotoViewHeroAttributes(tag: "heroTag$randomNum"),
      ),
    );
  }
}
