import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../common/adapt.dart';

class MenuWidget extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const MenuWidget({Key? key, required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: Adapt.px(120),
        child: Center(
            child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Adapt.px(36),
          ),
        )),
      ),
    );
  }
}