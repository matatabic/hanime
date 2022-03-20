import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/entity/watch_entity.dart';
import 'package:hanime/providers/watch_state.dart';
import 'package:provider/src/provider.dart';

class DetailScreen extends StatelessWidget {
  final WatchEntity watchEntity;

  const DetailScreen({Key? key, required this.watchEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Adapt.px(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.watch<WatchState>().title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Adapt.px(36),
            ),
          ),
          Container(
            child: ExpandableText(
              watchEntity.info.description,
              animation: true,
              prefixText: watchEntity.info.title,
              prefixStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Adapt.px(45),
                  color: Colors.orange),
              expandText: '顯示完整資訊',
              collapseText: '只顯示部分資訊',
              maxLines: 3,
              linkColor: Colors.cyan,
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: Adapt.px(30)),
              child: Wrap(
                children: _buildTagWidget(watchEntity.tag, () => {}),
                spacing: Adapt.px(20),
                runSpacing: Adapt.px(20),
              )),
        ],
      ),
    );
  }
}

List<Widget> _buildTagWidget(List<WatchTag> tagList, onTap) {
  List<Widget> tagWidgetList = [];
  for (var item in tagList) {
    tagWidgetList.add(InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(3.5),
        decoration: BoxDecoration(
            border: new Border.all(
          color: Colors.grey, //边框颜色
          width: Adapt.px(2), //边框粗细
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
