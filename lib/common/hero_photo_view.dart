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
  late PhotoViewController controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void listener(PhotoViewControllerValue value) {
    print("listener");
    print(value.position);
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(
        height: MediaQuery.of(context).size.height,
      ),
      color: Colors.black12,
      child: PhotoView(
        imageProvider: widget.imageProvider,
        backgroundDecoration:
            BoxDecoration(color: Theme.of(context).dialogBackgroundColor),
        minScale: widget.minScale,
        maxScale: widget.maxScale,
        enablePanAlways: true,
        disableGestures: false,
        tightMode: true,
        onScaleEnd: (BuildContext context, ScaleEndDetails scaleEndDetails,
            PhotoViewControllerValue photoViewControllerValue) {},
        scaleStateChangedCallback: (PhotoViewScaleState photoViewScaleState) {},
        // gestureDetectorBehavior: HitTestBehavior.opaque,
        heroAttributes: PhotoViewHeroAttributes(tag: widget.heroTag),
      ),
    );
  }
}
