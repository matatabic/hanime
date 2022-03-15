import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/providers/search_state.dart';
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

const double _fabDimension = 100.0;
ContainerTransitionType _transitionType = ContainerTransitionType.fade;

class SearchMenuScreen extends StatelessWidget {
  final VoidCallback loadData;
  SearchMenuScreen({Key? key, required this.loadData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> dataList = [];
    for (var menu in _menuList) {
      dataList.add(OpenContainer(
        transitionType: _transitionType,
        openBuilder: (BuildContext context, VoidCallback _) {
          return menuDetail(menu['id']);
        },
        closedElevation: 1.0,
        onClosed: (_) {
          loadData();
        },
        closedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(_fabDimension / 2),
          ),
        ),
        closedColor: getActive(context.watch<SearchState>(), menu['id']),
        closedBuilder: (BuildContext context, VoidCallback openContainer) {
          return SizedBox(
            height: Adapt.px(100),
            width: Adapt.px(100),
            child: Center(
              child: Icon(
                menu['icon'] as IconData,
                color: Colors.white70,
              ),
            ),
          );
        },
      ));
    }
    return Container(
      height: Adapt.px(150),
      padding: EdgeInsets.symmetric(horizontal: Adapt.px(20)),
      child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: dataList),
    );
  }
}

Color getActive(SearchState searchState, index) {
  switch (index) {
    case 0:
      return searchState.genreIndex > 0
          ? Colors.orangeAccent
          : Color.fromRGBO(51, 51, 51, 1);
    case 1:
      return searchState.selectedTag.length > 0
          ? Colors.orangeAccent
          : Color.fromRGBO(51, 51, 51, 1);
    case 2:
      return searchState.sortIndex > 0
          ? Colors.orangeAccent
          : Color.fromRGBO(51, 51, 51, 1);
    case 3:
      return searchState.selectedBrand.length > 0
          ? Colors.orangeAccent
          : Color.fromRGBO(51, 51, 51, 1);
    case 4:
      return Color.fromRGBO(51, 51, 51, 1);
    case 5:
      return searchState.durationIndex > 0
          ? Colors.orangeAccent
          : Color.fromRGBO(51, 51, 51, 1);
  }
  return Color.fromRGBO(51, 51, 51, 1);
}

Widget menuDetail(id) {
  switch (id) {
    case 0:
      return GenreMenu();
    case 1:
      return TagMenu();
    case 2:
      return SortMenu();
    case 3:
      return BrandMenu();
    case 4:
      return DateMenu();
    case 5:
      return DurationMenu();
  }

  return Container();
}
