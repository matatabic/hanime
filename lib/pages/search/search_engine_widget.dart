import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hanime/common/Ignore_show.dart';

class SearchEngineWidget extends StatefulWidget {
  final FocusNode focusNode;
  final Function(dynamic) onChangeQuery;
  final Function(dynamic) loadData;
  final String query;

  const SearchEngineWidget(
      {Key? key,
      required this.loadData,
      required this.onChangeQuery,
      required this.query,
      required this.focusNode})
      : super(key: key);

  @override
  _SearchEngineWidgetState createState() => _SearchEngineWidgetState();
}

class _SearchEngineWidgetState extends State<SearchEngineWidget> {
  String _query = "";

  @override
  initState() {
    super.initState();
    _query = widget.query;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQueryData.fromWindow(window).padding.top,
        ),
        child: Container(
          height: 55,
          child: Row(
            children: [
              new Padding(
                  padding: EdgeInsets.all(5),
                  child: new Card(
                      child: new Container(
                    width: 300,
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
                        Expanded(
                          child: Container(
                            height: 23,
                            width: 215,
                            child: IgnoreShowOnScreenWidget(
                              child: TextField(
                                focusNode: widget.focusNode,
                                controller: TextEditingController.fromValue(
                                    TextEditingValue(
                                        text:
                                            '${_query.length == 0 ? "" : _query}', //判断keyword是否为空
                                        // 保持光标在最后
                                        selection: TextSelection.fromPosition(
                                            TextPosition(
                                                affinity:
                                                    TextAffinity.downstream,
                                                offset: _query.length)))),
                                maxLines: 1,
                                maxLength: 10,
                                onChanged: (value) {
                                  widget.onChangeQuery(value);
                                  setState(() {
                                    _query = value;
                                  });
                                  print(value);
                                  // context.read<SearchModel>().setQuery(value);
                                },
                                onSubmitted: (value) {
                                  widget.loadData(
                                      {"type": "query", "data": value});
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
                          ),
                        ),
                        new IconButton(
                          icon: new Icon(Icons.cancel),
                          color: Colors.grey,
                          iconSize: 20,
                          onPressed: () {
                            setState(() {
                              _query = "";
                            });
                          },
                        ),
                      ],
                    ),
                  ))),
              InkWell(
                  onTap: () {
                    widget.loadData({"type": "query", "data": _query});
                  },
                  child: Text("搜索"))
            ],
          ),
        ),
      ),
    );
  }
}
