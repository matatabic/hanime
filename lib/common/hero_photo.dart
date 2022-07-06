import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

// class HeroPhotoViewRouteWrapper extends StatelessWidget {
//   const HeroPhotoViewRouteWrapper({
//     required this.imageProvider,
//     required this.randomNum,
//     this.backgroundDecoration,
//     this.minScale,
//     this.maxScale,
//   });
//
//   final ImageProvider imageProvider;
//   final BoxDecoration? backgroundDecoration;
//   final dynamic minScale;
//   final dynamic maxScale;
//   final String randomNum;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       constraints: BoxConstraints.expand(
//         height: MediaQuery.of(context).size.height,
//       ),
//       color: Colors.black12,
//       child: PhotoView(
//         imageProvider: imageProvider,
//         backgroundDecoration: BoxDecoration(color: Colors.black),
//         minScale: minScale,
//         maxScale: maxScale,
//         enablePanAlways: true,
//         disableGestures: false,
//         onScaleEnd: (BuildContext context, ScaleEndDetails scaleEndDetails,
//             PhotoViewControllerValue photoViewControllerValue) {
//           print("1234214");
//           print(photoViewControllerValue.position);
//         },
//         scaleStateChangedCallback: (PhotoViewScaleState photoViewScaleState) {
//           print("12312");
//         },
//         // gestureDetectorBehavior: HitTestBehavior.opaque,
//         heroAttributes: PhotoViewHeroAttributes(tag: "heroTag$randomNum"),
//       ),
//     );
//   }
// }

class HeroPhotoViewRouteWrapper extends StatefulWidget {
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
  _HeroPhotoViewRouteWrapperState createState() =>
      _HeroPhotoViewRouteWrapperState();
}

class _HeroPhotoViewRouteWrapperState extends State<HeroPhotoViewRouteWrapper> {
  late PhotoViewController controller;

  @override
  void initState() {
    super.initState();
    controller = PhotoViewController()..outputStateStream.listen(listener);
  }

  @override
  void dispose() {
    controller.dispose();
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
        // controller: controller,
        imageProvider: widget.imageProvider,
        backgroundDecoration: BoxDecoration(color: Colors.black),
        minScale: widget.minScale,
        maxScale: widget.maxScale,
        enablePanAlways: true,
        disableGestures: false,
        tightMode: true,
        onScaleEnd: (BuildContext context, ScaleEndDetails scaleEndDetails,
            PhotoViewControllerValue photoViewControllerValue) {
          print("1234214");
          print(photoViewControllerValue);
          print(photoViewControllerValue.position);
        },
        scaleStateChangedCallback: (PhotoViewScaleState photoViewScaleState) {
          print("12312");
        },
        // gestureDetectorBehavior: HitTestBehavior.opaque,
        heroAttributes: PhotoViewHeroAttributes(tag: widget.randomNum),
      ),
    );
  }
}
