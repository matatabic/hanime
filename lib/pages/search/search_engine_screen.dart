import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';

class SearchEngineScreen extends StatelessWidget {
  final Function(dynamic) loadData;
  final Function(String) onQueryChange;

  SearchEngineScreen(
      {Key? key, required this.loadData, required this.onQueryChange})
      : super(key: key);

  late final String queryVal = "";

  @override
  Widget build(BuildContext context) {
    // Search search = context.select((SearchModel model) => model.searchList);

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
                            // controller: TextEditingController.fromValue(
                            //     TextEditingValue(
                            //         text:
                            //             '${search.query.length == 0 ? "" : search.query}', //判断keyword是否为空
                            //         // 保持光标在最后
                            //         selection: TextSelection.fromPosition(
                            //             TextPosition(
                            //                 affinity: TextAffinity.downstream,
                            //                 offset: search.query.length)))
                            // ),
                            maxLines: 1,
                            maxLength: 10,
                            onChanged: (value) {
                              queryVal = value;
                              // context.read<SearchModel>().setQuery(value);
                            },
                            onSubmitted: (value) {
                              onQueryChange(value);
                              print("Sfasfas");
                              // loadData({"type": "query", "data": value});
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
                            print("12412412");
                            // context.read<SearchModel>().setQuery("");
                            // _controller.clear();
                            // onSearchTextChanged('');
                          },
                        ),
                      ],
                    ),
                  ))),
              InkWell(
                  onTap: () {
                    onQueryChange(queryVal);
                    print("sfrdawsfsa");
                    // loadData({"type": "query", "data": ""});
                  },
                  child: Text(
                    "搜索",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: Adapt.px(38)),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

// class SearchEngineScreen extends StatefulWidget {
//   final Function(dynamic) loadData;
//
//   const SearchEngineScreen({Key? key, required this.loadData})
//       : super(key: key);
//
//   @override
//   _SearchEngineScreenState createState() => _SearchEngineScreenState();
// }
//
// class _SearchEngineScreenState extends State<SearchEngineScreen> {
//   String queryVal = "";
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Theme.of(context).primaryColor,
//       child: Padding(
//         padding: EdgeInsets.only(
//           top: MediaQueryData.fromWindow(window).padding.top,
//         ),
//         child: Container(
//           height: Adapt.px(110),
//           child: Row(
//             children: [
//               new Padding(
//                   padding: EdgeInsets.all(Adapt.px(10)),
//                   child: new Card(
//                       child: new Container(
//                     width: Adapt.px(600),
//                     child: new Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: <Widget>[
//                         SizedBox(
//                           width: 5.0,
//                         ),
//                         Icon(
//                           Icons.search,
//                           color: Colors.grey,
//                         ),
//                         Container(
//                           height: Adapt.px(55),
//                           width: Adapt.px(430),
//                           child: TextField(
//                             controller: TextEditingController.fromValue(
//                                 TextEditingValue(
//                                     text:
//                                         '${queryVal.length == 0 ? "" : queryVal}', //判断keyword是否为空
//                                     // 保持光标在最后
//                                     selection: TextSelection.fromPosition(
//                                         TextPosition(
//                                             affinity: TextAffinity.downstream,
//                                             offset: queryVal.length)))),
//                             maxLines: 1,
//                             maxLength: 10,
//                             onChanged: (value) {
//                               print(value);
//                               // context.read<SearchModel>().setQuery(value);
//                             },
//                             onSubmitted: (value) {
//                               print("onSubmitted");
//                               print(value);
//                               // widget.loadData({"type": "query", "data": value});
//                             },
//                             decoration: new InputDecoration(
//                                 counterText: "", // 此处控制最大字符是否显示
//                                 // contentPadding: EdgeInsets.only(top: 500),
//                                 // hintText: 'Search',
//                                 border: InputBorder.none),
//                             style: TextStyle(
//                                 textBaseline: TextBaseline.alphabetic),
//                             // onChanged: onSearchTextChanged,
//                           ),
//                         ),
//                         new IconButton(
//                           icon: new Icon(Icons.cancel),
//                           color: Colors.grey,
//                           iconSize: Adapt.px(40),
//                           onPressed: () {
//                             // context.read<SearchModel>().setQuery("");
//                             // _controller.clear();
//                             // onSearchTextChanged('');
//                           },
//                         ),
//                       ],
//                     ),
//                   ))),
//               InkWell(
//                   onTap: () {
//                     // widget.loadData({"type": "query", "data": ""});
//                   },
//                   child: Text("搜索"))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
