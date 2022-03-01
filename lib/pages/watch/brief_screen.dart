import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/common_image.dart';
import 'package:hanime/entity/watch_entity.dart';

class BriefScreen extends StatelessWidget {
  final WatchEntity watchEntity;

  const BriefScreen({Key? key, required this.watchEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        color: Color.fromRGBO(58, 60, 63, 1),
        height: 100,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            ClipOval(
              child: Container(
                width: 70.0,
                height: 70.0,
                child: CommonImages(
                  imgUrl: watchEntity.info.imgUrl,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(watchEntity.info.title,
                        maxLines: 2, overflow: TextOverflow.ellipsis),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(
                        watchEntity.info.countTitle,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
    ;
  }
}
