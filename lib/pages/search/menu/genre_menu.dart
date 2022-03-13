import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/entity/search_entity.dart';
import 'package:hanime/providers/search_state.dart';
import 'package:provider/src/provider.dart';

SearchBrand genre = SearchBrand.fromJson({
  "label": "影片類型",
  "data": ["全部", "H動漫", "3D動畫", "同人作品", "Cosplay"]
});

class GenreMenu extends StatefulWidget {
  const GenreMenu({Key? key}) : super(key: key);

  @override
  _GenreMenuState createState() => _GenreMenuState();
}

class _GenreMenuState extends State<GenreMenu> {
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
        title: const Text('影片類型'),
      ),
      body: ListView.separated(
        // scrollDirection: Axis.horizontal,//设置为水平布局
        itemBuilder: (BuildContext context, int index) {
          return Genre(
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

class Genre extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;
  const Genre(
      {Key? key,
      required this.title,
      required this.selected,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: Adapt.px(120),
        color: selected ? Colors.deepPurple : Colors.black,
        child: Center(
            child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Adapt.px(36),
          ),
        )),
      ),
    );
  }
}
