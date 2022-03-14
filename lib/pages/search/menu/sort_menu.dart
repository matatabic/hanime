import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/common/menu_row.dart';
import 'package:hanime/entity/search_entity.dart';
import 'package:hanime/providers/search_state.dart';
import 'package:provider/src/provider.dart';

SearchSort sort = SearchSort.fromJson({
  "label": "排序方式",
  "data": ["无", "本日排行", "最新內容", "最新上傳", "觀看次數"]
});

class SortMenu extends StatelessWidget {
  const SortMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: new AppBar(
          centerTitle: true,
          backgroundColor: Colors.orange,
          leading: IconButton(
            icon: Icon(Icons.close_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(sort.label),
        ),
        body: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return MenuRow(
              title: sort.data[index],
              selected: index == context.watch<SearchState>().sortIndex,
              onTap: () {
                context.read<SearchState>().setSortIndex(index);
              },
            );
          },
          itemCount: sort.data.length,
          separatorBuilder: (BuildContext context, int index) {
            return Container(
              height: Adapt.px(5),
              color: Colors.white30,
            );
          },
        ));
  }
}
