import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/pages/favourite/favourite_screen.dart';

class MyScreen extends StatefulWidget {
  const MyScreen({Key? key}) : super(key: key);

  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Colors.red,
                indicatorWeight: 3,
                tabs: [
                  Tab(text: "测试1"),
                  Tab(text: "测试2"),
                ]),
            body: TabBarView(children: [
              ExpansionTileExample(),
              Icon(Icons.search),
            ]),
          )),
    );
  }
}
