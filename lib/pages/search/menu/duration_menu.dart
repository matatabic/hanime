import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/common/menu_row.dart';
import 'package:hanime/entity/search_entity.dart';
import 'package:hanime/providers/search_state.dart';
import 'package:provider/src/provider.dart';

SearchDuration duration = SearchDuration.fromJson({
  "label": "片長",
  "data": [
    "全部",
    "短片（4 分鐘內）",
    "中長片（4 至 20 分鐘）",
    "長片（20 分鐘以上）",
  ]
});

class DurationMenu extends StatelessWidget {
  final int currentScreen;
  final VoidCallback loadData;
  const DurationMenu(
      {Key? key, required this.currentScreen, required this.loadData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Search search = context.watch<SearchState>().searchList[currentScreen];
    return WillPopScope(
      onWillPop: () async {
        loadData();
        return true;
      },
      child: Scaffold(
          backgroundColor: Colors.black,
          appBar: new AppBar(
            centerTitle: true,
            backgroundColor: Colors.orange,
            leading: IconButton(
              icon: Icon(Icons.close_rounded),
              onPressed: () {
                loadData();
                Navigator.pop(context);
              },
            ),
            title: Text(duration.label),
          ),
          body: ListView.separated(
            padding: EdgeInsets.only(top: Adapt.px(20)),
            itemBuilder: (BuildContext context, int index) {
              return MenuRow(
                title: duration.data[index],
                selected: index == search.durationIndex,
                onTap: () {
                  context
                      .read<SearchState>()
                      .setDurationIndex(currentScreen, index);
                },
              );
            },
            itemCount: duration.data.length,
            separatorBuilder: (BuildContext context, int index) {
              return Container(
                height: Adapt.px(5),
                color: Colors.white30,
              );
            },
          )),
    );
  }
}
