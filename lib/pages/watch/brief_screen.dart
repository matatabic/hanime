import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/entity/watch_entity.dart';

class BriefScreen extends StatelessWidget {
  final WatchEntity watchEntity;
  final String title;

  const BriefScreen({Key? key, required this.watchEntity, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Container(
            child: ExpandableText(
              watchEntity.info.description,
              animation: true,
              prefixText: watchEntity.info.title,
              prefixStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.orange),
              expandText: '顯示完整資訊',
              collapseText: '只顯示部分資訊',
              maxLines: 3,
              linkColor: Colors.cyan,
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 15),
              child: Wrap(
                children: _buildTagWidget(watchEntity.tagList),
                spacing: 10,
                runSpacing: 10,
              )),
        ],
      ),
    );
  }
}

List<Widget> _buildTagWidget(tagList) {
  List<Widget> tagWidgetList = [];
  for (var item in tagList) {
    tagWidgetList.add(Container(
      padding: EdgeInsets.all(3.5),
      decoration: BoxDecoration(
          border: new Border.all(
        color: Colors.grey, //边框颜色
        width: 2.0, //边框粗细
      )),
      child: Text(
        item,
        style: TextStyle(fontSize: 17),
      ),
    ));
  }

  return tagWidgetList;
}
