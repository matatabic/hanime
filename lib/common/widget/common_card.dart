import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/widget/common_image.dart';

class CommonCard extends StatelessWidget {
  final String htmlUrl;
  final String imgUrl;
  final String title;
  final String created;
  final String genre;
  final String author;
  final String duration;
  final VoidCallback onTap;

  const CommonCard(
      {Key? key,
      required this.htmlUrl,
      required this.imgUrl,
      required this.title,
      required this.duration,
      required this.genre,
      required this.author,
      required this.created,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Flex(direction: Axis.vertical, children: [
        Expanded(
            flex: 3,
            child: Stack(
              alignment: Alignment(-1, 1),
              children: [
                ConstrainedBox(
                    child: CommonImage(imgUrl: imgUrl),
                    constraints: new BoxConstraints.expand()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(Icons.access_alarm_outlined, size: 20),
                            Text(created)
                          ]),
                      Text(duration),
                    ],
                  ),
                )
              ],
            )),
        Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      maxLines: 2,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(right: 8),
                          decoration: new BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(2.0)),
                            border: new Border.all(
                                width: 1, color: Colors.redAccent),
                          ),
                          child: Center(
                            child: Text(genre,
                                style: TextStyle(
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.bold)),
                          )),
                      Text(
                        author,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ))
      ]),
    );
  }
}
