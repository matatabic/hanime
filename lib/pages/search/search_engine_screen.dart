import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/providers/search_state.dart';
import 'package:provider/src/provider.dart';

class SearchEngineScreen extends StatelessWidget {
  final int currentScreen;
  final VoidCallback loadData;
  SearchEngineScreen(
      {Key? key, required this.currentScreen, required this.loadData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Search search = context.watch<SearchState>().searchList[currentScreen];

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
                                        '${search.query.length == 0 ? "" : search.query}', //判断keyword是否为空
                                    // 保持光标在最后
                                    selection: TextSelection.fromPosition(
                                        TextPosition(
                                            affinity: TextAffinity.downstream,
                                            offset: search.query.length)))),
                            maxLines: 1,
                            maxLength: 10,
                            onChanged: (value) {
                              context
                                  .read<SearchState>()
                                  .setQuery(currentScreen, value);
                            },
                            onSubmitted: (value) {
                              loadData();
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
                            context
                                .read<SearchState>()
                                .setQuery(currentScreen, "");
                            // _controller.clear();
                            // onSearchTextChanged('');
                          },
                        ),
                      ],
                    ),
                  ))),
              InkWell(
                  onTap: () {
                    loadData();
                  },
                  child: Container(child: Text("搜索")))
            ],
          ),
        ),
      ),
    );
  }
}
