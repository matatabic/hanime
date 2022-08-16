import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'menu/brand_menu.dart';
import 'menu/date_menu.dart';
import 'menu/duration_menu.dart';
import 'menu/genre_menu.dart';
import 'menu/sort_menu.dart';
import 'menu/tag_menu.dart';

List _menuList = [
  {"id": 0, "icon": Icons.dashboard},
  {"id": 1, "icon": Icons.loyalty},
  {"id": 2, "icon": Icons.sort},
  {"id": 3, "icon": Icons.business},
  {"id": 4, "icon": Icons.date_range},
  {"id": 5, "icon": Icons.update}
];

class SearchMenuWidget extends StatelessWidget {
  final Function(dynamic) loadData;
  final bool broad;
  final int genreIndex;
  final int sortIndex;
  final int durationIndex;
  final year;
  final month;
  final List<String> customTagList;
  final List<String> tagList;
  final List<String> brandList;

  SearchMenuWidget(
      {Key? key,
      required this.broad,
      required this.loadData,
      required this.genreIndex,
      required this.sortIndex,
      required this.durationIndex,
      required this.year,
      required this.month,
      required this.customTagList,
      required this.tagList,
      required this.brandList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> dataList = [];

    for (var menu in _menuList) {
      dataList.add(Padding(
        padding: EdgeInsets.symmetric(
            vertical: Adapt.px(10), horizontal: Adapt.px(10)),
        child: ClipOval(
          child: Material(
            color: getActive(this, menu['id']),
            child: InkWell(
              customBorder: StadiumBorder(),
              onTap: () {
                showBarModalBottomSheet(
                    expand: true,
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) {
                      return getMenuDetail(this, menu['id'], loadData);
                    });
              },
              child: Container(
                height: Adapt.px(100),
                width: Adapt.px(100),
                child: Center(
                  child: Icon(
                    menu['icon'] as IconData,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
          ),
        ),
      ));
    }
    return CupertinoScaffold(
        body: Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: dataList,
    ));
  }
}

Color getActive(that, index) {
  switch (index) {
    case 0:
      return that.genreIndex > 0
          ? Colors.orangeAccent
          : Color.fromRGBO(51, 51, 51, 1);
    case 1:
      return that.tagList.length > 0
          ? Colors.orangeAccent
          : Color.fromRGBO(51, 51, 51, 1);
    case 2:
      return that.sortIndex > 0
          ? Colors.orangeAccent
          : Color.fromRGBO(51, 51, 51, 1);
    case 3:
      return that.brandList.length > 0
          ? Colors.orangeAccent
          : Color.fromRGBO(51, 51, 51, 1);
    case 4:
      return that.year != "全部" && that.year != null
          ? Colors.orangeAccent
          : Color.fromRGBO(51, 51, 51, 1);
    case 5:
      return that.durationIndex > 0
          ? Colors.orangeAccent
          : Color.fromRGBO(51, 51, 51, 1);
  }
  return Color.fromRGBO(51, 51, 51, 1);
}

Widget getMenuDetail(that, index, loadData) {
  switch (index) {
    case 0:
      return GenreMenu(
        loadData: loadData,
        genreIndex: that.genreIndex,
      );
    case 1:
      return TagMenu(
        loadData: loadData,
        broad: that.broad,
        customTagList: that.customTagList,
        tagList: that.tagList,
      );
    case 2:
      return SortMenu(
        loadData: loadData,
        sortIndex: that.sortIndex,
      );
    case 3:
      return BrandMenu(
        loadData: loadData,
        brandList: that.brandList,
      );
    case 4:
      return DateMenu(
        loadData: loadData,
        year: that.year,
        month: that.month,
      );
    case 5:
      return DurationMenu(
        loadData: loadData,
        durationIndex: that.durationIndex,
      );
    default:
      return Container();
  }
}
