import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/providers/search_model.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/src/provider.dart';

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

class SearchMenuScreen extends StatelessWidget {
  final Function(dynamic) loadData;
  final int genreIndex;
  final int sortIndex;

  SearchMenuScreen(
      {Key? key,
      required this.loadData,
      required this.genreIndex,
      required this.sortIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> dataList = [];
    Search searchList = context.select((SearchModel model) => model.searchList);
    for (var menu in _menuList) {
      dataList.add(Padding(
        padding: EdgeInsets.symmetric(
            vertical: Adapt.px(10), horizontal: Adapt.px(10)),
        child: ClipOval(
          child: Material(
            color: getActive(searchList, menu['id']),
            child: InkWell(
              customBorder: StadiumBorder(),
              onTap: () {
                showBarModalBottomSheet(
                    expand: true,
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) {
                      switch (menu['id']) {
                        case 0:
                          return GenreMenu(
                            loadData: loadData,
                            genreIndex: genreIndex,
                          );
                        case 1:
                          return TagMenu(
                            loadData: loadData,
                          );
                        case 2:
                          return SortMenu(
                            loadData: loadData,
                            sortIndex: sortIndex,
                          );
                        case 3:
                          return BrandMenu(
                            loadData: loadData,
                          );
                        case 4:
                          return DateMenu(
                            loadData: loadData,
                          );
                        case 5:
                          return DurationMenu(
                            loadData: loadData,
                          );
                        default:
                          return Container();
                      }
                    });
              },
              // menuDetail(genreIndex,menu['id'], loadData)
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

Color getActive(Search searchState, index) {
  switch (index) {
    case 0:
      return searchState.genreIndex > 0
          ? Colors.orangeAccent
          : Color.fromRGBO(51, 51, 51, 1);
    case 1:
      return searchState.tagList.length > 0
          ? Colors.orangeAccent
          : Color.fromRGBO(51, 51, 51, 1);
    case 2:
      return searchState.sortIndex > 0
          ? Colors.orangeAccent
          : Color.fromRGBO(51, 51, 51, 1);
    case 3:
      return searchState.brandList.length > 0
          ? Colors.orangeAccent
          : Color.fromRGBO(51, 51, 51, 1);
    case 4:
      return searchState.year != "全部" && searchState.year != null
          ? Colors.orangeAccent
          : Color.fromRGBO(51, 51, 51, 1);
    case 5:
      return searchState.durationIndex > 0
          ? Colors.orangeAccent
          : Color.fromRGBO(51, 51, 51, 1);
  }
  return Color.fromRGBO(51, 51, 51, 1);
}
