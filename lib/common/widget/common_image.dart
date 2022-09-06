import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonImage extends StatelessWidget {
  final String imgUrl;

  const CommonImage({Key? key, required this.imgUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExtendedImage(
      fit: BoxFit.cover,
      image: ExtendedResizeImage(
        ExtendedNetworkImageProvider(imgUrl,
            // "http://img5.mtime.cn/mt/2022/01/19/102417.23221502_1280X720X2.jpg",
            cache: true,
            retries: 3,
            timeRetry: const Duration(milliseconds: 700)),
      ),
      loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            return Center(
              child: CircularProgressIndicator(),
            );
          case LoadState.completed:
            return null;
          case LoadState.failed:
            return GestureDetector(
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Image.asset(
                    "assets/images/error.png",
                    fit: BoxFit.fill,
                  ),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Text(
                      "load image failed, click to reload",
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
              onTap: () {
                state.reLoadImage();
              },
            );
        }
      },
    );
  }
}

class CommonNormalImage extends StatelessWidget {
  final String imgUrl;

  const CommonNormalImage({Key? key, required this.imgUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(this.imgUrl, fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
      return Image.network(
        // "http://img5.mtime.cn/mt/2022/01/19/102417.23221502_1280X720X2.jpg",
        this.imgUrl + '?reload',
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            'assets/images/error.png',
            fit: BoxFit.cover,
          );
        },
      );
    }, loadingBuilder: (context, child, loadingProgress) {
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
    });
  }
}
