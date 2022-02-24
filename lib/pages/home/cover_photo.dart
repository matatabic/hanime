import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoverPhoto extends StatelessWidget {
  final Map<String, dynamic> data;
  final VoidCallback onTap;
  final double width;

  CoverPhoto(
      {Key? key, required this.data, required this.onTap, required this.width})
      : super(key: key);

  Widget build(BuildContext context) {
    return Container(
        width: width,
        margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
        child: InkWell(
          child: Stack(
            alignment: Alignment(-1, 1),
            children: <Widget>[
              ConstrainedBox(
                child: Image.network(
                  // data['imgUrl'],
                  'http://img5.mtime.cn/mt/2022/01/19/102417.23221502_1280X720X2.jpg',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.network(
                      data['imgUrl'] + '?reload',
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
                constraints: new BoxConstraints.expand(),
              ),
              Container(
                child: Text(
                  data['title'],
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
          ),
          onTap: onTap,
        ));
  }
}
