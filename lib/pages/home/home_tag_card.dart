import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/common/common_image.dart';
import 'package:hanime/entity/home_entity.dart';

class HomeTagCard extends StatelessWidget {
  final HomeTagVideo data;
  final int index;
  final VoidCallback onTap;
  const HomeTagCard(
      {Key? key, required this.data, required this.index, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: EdgeInsets.only(top: Adapt.px(7)),
        child: Material(
          child: Ink(
            child: InkWell(
              onTap: onTap,
              child: Stack(
                alignment: Alignment(-1, 1),
                children: [
                  ConstrainedBox(
                      child: CommonImages(imgUrl: data.imgUrl),
                      constraints: new BoxConstraints.expand()),
                  Container(color: Colors.black26),
                  Container(
                      height: Adapt.px(100),
                      padding: EdgeInsets.symmetric(horizontal: Adapt.px(5)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            data.title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Adapt.px(35)),
                          ),
                          Text(
                            data.total,
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
