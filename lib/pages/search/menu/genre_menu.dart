import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/common/menu_row.dart';
import 'package:hanime/entity/search_entity.dart';
import 'package:hanime/providers/search_state.dart';
import 'package:provider/src/provider.dart';

SearchGenre genre = SearchGenre.fromJson({
  "label": "影片類型",
  "data": ["全部", "H動漫", "3D動畫", "同人作品", "Cosplay"]
});

class GenreMenu extends StatelessWidget {
  GenreMenu({Key? key}) : super(key: key);

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
        title: Text(genre.label),
      ),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return MenuRow(
            title: genre.data[index],
            selected: index == context.watch<SearchState>().genreIndex,
            onTap: () {
              context.read<SearchState>().setGenreIndex(index);
            },
          );
        },
        itemCount: genre.data.length,
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            height: Adapt.px(5),
            color: Colors.white30,
          );
        },
      ),
    );
  }
}
