import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingCover extends StatelessWidget {
  const LoadingCover({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: 0.7,
          child: Container(
            color: Colors.black,
          ),
        ),
        Center(
          child: CircularProgressIndicator(
            value: null,
          ),
        ),
      ],
    );
  }
}
