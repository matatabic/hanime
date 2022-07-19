import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/component/menu_row.dart';
import 'package:hanime/providers/search_model.dart';
import 'package:hanime/services/search_services.dart';
import 'package:provider/src/provider.dart';

// class SortMenu extends StatelessWidget {
//   final Function(dynamic) loadData;
//
//   const SortMenu({Key? key, required this.loadData}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     Search search = context.select((SearchModel model) => model.searchList);
//     return WillPopScope(
//       onWillPop: () async {
//         loadData({});
//         return true;
//       },
//       child: Scaffold(
//           backgroundColor: Colors.black,
//           appBar: new AppBar(
//             centerTitle: true,
//             backgroundColor: Theme.of(context).primaryColor,
//             leading: IconButton(
//               icon: Icon(Icons.close_rounded),
//               onPressed: () {
//                 loadData({});
//                 Navigator.pop(context);
//               },
//             ),
//             title: Text(sort.label),
//           ),
//           body: ListView.separated(
//             padding: EdgeInsets.only(top: Adapt.px(20)),
//             itemBuilder: (BuildContext context, int index) {
//               return Material(
//                 color: index == search.sortIndex
//                     ? Theme.of(context).primaryColor
//                     : Colors.black,
//                 child: MenuRow(
//                   title: sort.data[index],
//                   onTap: () {
//                     context.read<SearchModel>().setSortIndex(index);
//                   },
//                 ),
//               );
//             },
//             itemCount: sort.data.length,
//             separatorBuilder: (BuildContext context, int index) {
//               return Container(
//                 height: Adapt.px(5),
//                 color: Colors.white30,
//               );
//             },
//           )),
//     );
//   }
// }

class SortMenu extends StatefulWidget {
  final Function(dynamic) loadData;
  final int sortIndex;

  const SortMenu({Key? key, required this.loadData, required this.sortIndex})
      : super(key: key);

  @override
  _SortMenuState createState() => _SortMenuState();
}

class _SortMenuState extends State<SortMenu> {
  late int _index;

  @override
  void initState() {
    super.initState();
    _index = widget.sortIndex;
  }

  @override
  Widget build(BuildContext context) {
    Search search = context.select((SearchModel model) => model.searchList);
    return WillPopScope(
      onWillPop: () async {
        widget.loadData({"type": "sort", "data": _index});
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
                widget.loadData({"type": "sort", "data": _index});
                Navigator.pop(context);
              },
            ),
            title: Text(sort.label),
          ),
          body: ListView.separated(
            padding: EdgeInsets.only(top: Adapt.px(20)),
            itemBuilder: (BuildContext context, int index) {
              return Material(
                color: index == search.sortIndex
                    ? Theme.of(context).primaryColor
                    : Colors.black,
                child: MenuRow(
                  title: sort.data[index],
                  onTap: () {
                    setState(() {
                      _index = index;
                    });
                  },
                ),
              );
            },
            itemCount: sort.data.length,
            separatorBuilder: (BuildContext context, int index) {
              return Container(
                height: Adapt.px(5),
                color: Colors.white30,
              );
            },
          )),
    );
  }
}
