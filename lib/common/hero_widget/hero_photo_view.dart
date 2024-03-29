import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class HeroPhotoView extends StatefulWidget {
  final ImageProvider imageProvider;
  final BoxDecoration? backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final String heroTag;

  const HeroPhotoView({
    required this.imageProvider,
    required this.heroTag,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
  });

  @override
  _HeroPhotoViewState createState() => _HeroPhotoViewState();
}

class _HeroPhotoViewState extends State<HeroPhotoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        color: Colors.black12,
        child: PhotoView(
          imageProvider: widget.imageProvider,
          minScale: widget.minScale,
          maxScale: widget.maxScale,
          enablePanAlways: true,
          disableGestures: false,
          tightMode: true,
          gestureDetectorBehavior: HitTestBehavior.opaque,
          heroAttributes: PhotoViewHeroAttributes(tag: widget.heroTag),
        ),
      ),
    );
  }
}
