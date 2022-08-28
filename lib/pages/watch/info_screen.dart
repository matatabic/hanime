import 'package:expandable_text/expandable_text.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/entity/watch_entity.dart';
import 'package:hanime/pages/search/search_screen.dart';
import 'package:hanime/services/watch_services.dart';

class InfoScreen extends StatelessWidget {
  final WatchEntity watchEntity;
  final FijkPlayer player;
  final String shareTitle;

  InfoScreen(
      {Key? key,
      required this.watchEntity,
      required this.player,
      required this.shareTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            shareTitle.length > 0 ? shareTitle : watchEntity.info.shareTitle,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Container(
            child: InkWell(
              onLongPress: () {
                translate(watchEntity.info.title, watchEntity.info.description);
              },
              child: ExpandableText(
                watchEntity.info.description,
                animation: true,
                prefixText: watchEntity.info.title,
                prefixStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                    color: Theme.of(context).primaryColor),
                expandText: '顯示完整資訊',
                collapseText: '只顯示部分資訊',
                maxLines: 3,
                linkColor: Colors.cyan,
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 15),
              child: Wrap(
                children: _buildTagWidget(
                    watchEntity.tag,
                    (String tag) => {
                          player.pause(),
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) =>
                                    SearchScreen(tagList: [tag])),
                          )
                        }),
                spacing: 10,
                runSpacing: 10,
              ))
        ],
      ),
    );
  }
}

List<Widget> _buildTagWidget(List<WatchTag> tagList, onTap) {
  List<Widget> tagWidgetList = [];
  for (var item in tagList) {
    tagWidgetList.add(InkWell(
      onTap: () => onTap(item.title),
      child: Container(
        padding: EdgeInsets.all(3.5),
        decoration: BoxDecoration(
            border: new Border.all(
          color: Colors.grey, //边框颜色
          width: 1, //边框粗细
        )),
        child: Text(
          item.title,
          style: TextStyle(fontSize: 17),
        ),
      ),
    ));
  }

  return tagWidgetList;
}
