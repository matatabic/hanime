import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonImages extends StatelessWidget {
  final String imgUrl;

  const CommonImages({Key? key, required this.imgUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(this.imgUrl, fit: BoxFit.cover,
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
