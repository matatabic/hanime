import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/widget/common_image.dart';
import 'package:hanime/entity/home_entity.dart';

class HomeTagCard extends StatelessWidget {
  final HomeTagVideo data;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final String heroTag;

  const HomeTagCard(
      {Key? key,
      required this.data,
      required this.onTap,
      required this.onLongPress,
      required this.heroTag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: EdgeInsets.only(top: 3.5),
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          child: Stack(
            alignment: Alignment(-1, 1),
            children: [
              ConstrainedBox(
                  child: Hero(
                      tag: heroTag, child: CommonImage(imgUrl: data.imgUrl)),
                  constraints: new BoxConstraints.expand()),
              Container(color: Colors.black26),
              Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: 2.5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        data.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
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
    );
  }
}
