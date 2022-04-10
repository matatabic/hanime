import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/common_image.dart';

class Anime3Card extends StatelessWidget {
  final String title;
  final String imgUrl;
  final VoidCallback onTap;
  const Anime3Card(
      {Key? key,
      required this.title,
      required this.imgUrl,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Stack(
          alignment: Alignment(-1, 1),
          children: <Widget>[
            ConstrainedBox(
              child: CommonImages(
                imgUrl:
                    // imgUrl
                    'http://img5.mtime.cn/mt/2022/01/19/102417.23221502_1280X720X2.jpg',
              ),
              constraints: new BoxConstraints.expand(),
            ),
            Container(
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(2.5, 2.5),
                      blurRadius: 3.5,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
