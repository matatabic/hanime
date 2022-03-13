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
  {"id": 0, "icon": Icons.dashboard, "selector": false},
  {"id": 1, "icon": Icons.loyalty, "selector": false},
  {"id": 2, "icon": Icons.sort, "selector": false},
  {"id": 3, "icon": Icons.business, "selector": false},
  {"id": 4, "icon": Icons.date_range, "selector": false},
  {"id": 5, "icon": Icons.update, "selector": false}
];

const double _fabDimension = 100.0;
ContainerTransitionType _transitionType = ContainerTransitionType.fade;

class SearchMenuScreen extends StatelessWidget {
  SearchMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> dataList = [];
    for (var menu in _menuList) {
      dataList.add(OpenContainer(
        transitionType: _transitionType,
        openBuilder: (BuildContext context, VoidCallback _) {
          return menuDetail(menu['id']);
        },
        closedElevation: 6.0,
        closedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(_fabDimension / 2),
          ),
        ),
        closedColor: getActive(context, menu['id']),
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

Color getActive(BuildContext context, index) {
  switch (index) {
    case 0:
      return context.watch<SearchState>().genreIndex > 0
          ? Colors.red
          : Color.fromRGBO(51, 51, 51, 1);
    case 1:
      return Color.fromRGBO(51, 51, 51, 1);
    case 2:
      return Color.fromRGBO(51, 51, 51, 1);
    case 3:
      return Color.fromRGBO(51, 51, 51, 1);
    case 4:
      return Color.fromRGBO(51, 51, 51, 1);
    case 5:
      return Color.fromRGBO(51, 51, 51, 1);
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
