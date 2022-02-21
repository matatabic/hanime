import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimePhoto extends StatelessWidget {
  final Map<String, dynamic> data;
  final VoidCallback onTap;
  final double width;

  const AnimePhoto(
      {Key? key, required this.data, required this.onTap, required this.width})
      : super(key: key);

  Widget build(BuildContext context) {
    return Container(
        width: width,
        margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
        child: InkWell(
          child: Stack(
            children: <Widget>[
              ConstrainedBox(
                child: Image.network(
                  // data['imgUrl'],
                  'http://img5.mtime.cn/mt/2022/01/19/102417.23221502_1280X720X2.jpg',
                  fit: BoxFit.cover,
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
                constraints: new BoxConstraints.expand(),
              ),
              Container(
                alignment: AlignmentDirectional.bottomStart,
                child: Text(
                  data['title'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          onTap: onTap,
        ));
  }
}
