import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/pages/home/home_screen.dart';
import 'package:hanime/pages/my/my_screen.dart';
import 'package:hanime/pages/search/search_screen.dart';

import 'common/adapt.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(vsync: this, length: 3)
      ..addListener(() {
        setState(() {
          currentIndex = tabController.index;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          // backgroundColor: colors[currentIndex],
          color: Theme.of(context).primaryColor,
          buttonBackgroundColor: Colors.transparent,
          backgroundColor: Colors.black26,
          index: currentIndex,
          items: <Widget>[
            Icon(Icons.home, size: Adapt.px(60)),
            Icon(Icons.search, size: Adapt.px(60)),
            Icon(Icons.repeat, size: Adapt.px(60)),
          ],
          onTap: (index) {
            //Handle button tap
            setState(() {
              currentIndex = index;
            });
            tabController.animateTo(index,
                duration: Duration(milliseconds: 300), curve: Curves.ease);
          },
        ),
        body: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: tabController,
            children: <Widget>[
              HomeScreen(),
              SearchScreen(),
              MyScreen(),
            ],
          ),
        ));
  }
}
