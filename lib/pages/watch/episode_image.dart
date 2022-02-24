import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      width: this.width,
      height: this.height,
      decoration: BoxDecoration(
          border: Border.all(
        color: this.selector ? Colors.pinkAccent : Colors.grey, //边框颜色
        width: 1.0, //边框粗细
      )),
      child: Image.network(
        this.imgUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.network(
            this.imgUrl + '?reload',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                'assets/images/error.png',
                fit: BoxFit.cover,
              );
            },
          );
        },
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
    );
  }
}
