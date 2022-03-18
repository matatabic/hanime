import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/providers/search_state.dart';
import 'package:provider/src/provider.dart';

import 'menu/duration_menu.dart';
import 'menu/genre_menu.dart';
import 'menu/sort_menu.dart';

class SearchEngineScreen extends StatelessWidget {
  final Function(String url) loadData;
  SearchEngineScreen({Key? key, required this.loadData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String query = context.watch<SearchState>().query;
    int genreIndex = context.watch<SearchState>().genreIndex;
    List tagList = context.watch<SearchState>().tagList;
    bool broadFlag = context.watch<SearchState>().broad;
    int sortIndex = context.watch<SearchState>().sortIndex;
    List brandList = context.watch<SearchState>().brandList;
    var year = context.watch<SearchState>().year;
    var month = context.watch<SearchState>().month;
    int durationIndex = context.watch<SearchState>().durationIndex;

    var htmlUrl =
        "https://hanime1.me/search?query=$query&genre=${genre.data[genreIndex]}&sort=${sort.data[sortIndex]}&duration=${duration.data[durationIndex]}";

    if (broadFlag) {
      htmlUrl = "$htmlUrl&broad=on";
    }

    if (year != null) {
      htmlUrl = "$htmlUrl&year=$year";
      if (month != null) {
        htmlUrl = "$htmlUrl&month=$month";
      }
    }

    if (tagList.length > 0) {
      for (String tag in tagList) {
        htmlUrl = "$htmlUrl&tags[]=$tag";
      }
    }

    if (brandList.length > 0) {
      for (String brand in brandList) {
        htmlUrl = "$htmlUrl&brands[]=$brand";
      }
    }

    return Container(
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQueryData.fromWindow(window).padding.top,
        ),
        child: Container(
          height: Adapt.px(110),
          child: Row(
            children: [
              new Padding(
                  padding: EdgeInsets.all(Adapt.px(10)),
                  child: new Card(
                      child: new Container(
                    width: Adapt.px(600),
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 5.0,
                        ),
                        Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        Container(
                          height: Adapt.px(55),
                          width: Adapt.px(430),
                          child: TextField(
                            controller: TextEditingController.fromValue(
                                TextEditingValue(
                                    text:
                                        '${query.length == 0 ? "" : query}', //判断keyword是否为空
                                    // 保持光标在最后
                                    selection: TextSelection.fromPosition(
                                        TextPosition(
                                            affinity: TextAffinity.downstream,
                                            offset: query.length)))),
                            maxLines: 1,
                            maxLength: 10,
                            onChanged: (value) {
                              context.read<SearchState>().setQuery(value);
                            },
                            onSubmitted: (value) {
                              loadData(htmlUrl);
                            },
                            decoration: new InputDecoration(
                                counterText: "", // 此处控制最大字符是否显示
                                // contentPadding: EdgeInsets.only(top: 500),
                                // hintText: 'Search',
                                border: InputBorder.none),
                            style: TextStyle(
                                textBaseline: TextBaseline.alphabetic),
                            // onChanged: onSearchTextChanged,
                          ),
                        ),
                        new IconButton(
                          icon: new Icon(Icons.cancel),
                          color: Colors.grey,
                          iconSize: Adapt.px(40),
                          onPressed: () {
                            context.read<SearchState>().setQuery("");
                            // _controller.clear();
                            // onSearchTextChanged('');
                          },
                        ),
                      ],
                    ),
                  ))),
              InkWell(
                  onTap: () {
                    loadData(htmlUrl);
                  },
                  child: Container(child: Text("搜索")))
            ],
          ),
        ),
      ),
    );
  }
}
