import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'menu/genre_menu.dart';

class MenuDetail extends StatefulWidget {
  const MenuDetail({Key? key}) : super(key: key);

  @override
  _MenuDetailState createState() => _MenuDetailState();
}

class _MenuDetailState extends State<MenuDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: new AppBar(
        centerTitle: true,
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: Icon(Icons.close_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('影片類型'),
      ),
      body: GenreMenu(),
    );
  }
}

var genre = {
  "label": "影片類型",
  "data": ["H動漫", "3D動畫", "同人作品", "Cosplay"]
};
