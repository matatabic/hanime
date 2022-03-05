import 'dart:ui';

import 'package:flutter/material.dart';

class SearchEngine extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SearchEngineState();
}

class _SearchEngineState extends State<SearchEngine> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQueryData.fromWindow(window).padding.top,
        ),
        child: Container(
          height: 52.0,
          child: new Padding(
              padding: const EdgeInsets.all(0.0),
              child: new Card(
                  child: new Container(
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
                        alignment: Alignment.center,
                        child: TextField(
                          controller: controller,
                          decoration: new InputDecoration(
                              contentPadding: EdgeInsets.only(top: 0.0),
                              hintText: 'Search',
                              border: InputBorder.none),
                          // onChanged: onSearchTextChanged,
                        ),
                      ),
                    ),
                    new IconButton(
                      icon: new Icon(Icons.cancel),
                      color: Colors.grey,
                      iconSize: 18.0,
                      onPressed: () {
                        controller.clear();
                        // onSearchTextChanged('');
                      },
                    ),
                  ],
                ),
              ))),
        ),
      ),
    );
  }
}
