import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/entity/search_entity.dart';

SearchBrand genre = SearchBrand.fromJson({
  "label": "發佈日期",
  "data": ["H動漫", "3D動畫", "同人作品", "Cosplay"]
});

class DateMenu extends StatelessWidget {
  const DateMenu({Key? key}) : super(key: key);

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
        title: const Text('發佈日期'),
      ),
      body: Text(""),
    );
  }
}
