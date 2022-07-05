import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/component/menu_row.dart';
import 'package:hanime/providers/search_model.dart';
import 'package:hanime/services/search_services.dart';
import 'package:provider/src/provider.dart';

class GenreMenu extends StatelessWidget {
  final int currentScreen;
  final VoidCallback loadData;
  GenreMenu({Key? key, required this.currentScreen, required this.loadData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Search search = context.watch<SearchModel>().searchList[currentScreen];
    return WillPopScope(
      onWillPop: () async {
        loadData();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: new AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
          leading: IconButton(
            icon: Icon(Icons.close_rounded),
            onPressed: () {
              loadData();
              Navigator.pop(context);
            },
          ),
          title: Text(genre.label),
        ),
        body: ListView.separated(
          padding: EdgeInsets.only(top: Adapt.px(20)),
          physics: const ClampingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Material(
              color: index == search.genreIndex
                  ? Theme.of(context).primaryColor
                  : Colors.black,
              child: MenuRow(
                title: genre.data[index],
                onTap: () {
                  context
                      .read<SearchModel>()
                      .setGenreIndex(currentScreen, index);
                },
              ),
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
      ),
    );
  }
}
