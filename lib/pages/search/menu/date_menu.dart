import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/services/search_services.dart';

// class DateMenu extends StatelessWidget {
//   final Function(dynamic) loadData;
//
//   const DateMenu({Key? key, required this.loadData}) : super(key: key);
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
//             title: Text(date.label),
//           ),
//           body: Container(
//             padding: EdgeInsets.symmetric(
//                 vertical: Adapt.px(80), horizontal: Adapt.px(70)),
//             child: Flex(
//               direction: Axis.horizontal,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 CustomDropdownButton2(
//                   hint: '请选择年份',
//                   dropdownItems: date.data.year,
//                   value: search.year,
//                   buttonDecoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(14),
//                     border: Border.all(
//                       color: Theme.of(context).primaryColor,
//                     ),
//                   ),
//                   onChanged: (value) {
//                     context.read<SearchModel>().setYear(value!);
//                   },
//                 ),
//                 CustomDropdownButton2(
//                   hint: '请选择月份',
//                   dropdownItems: date.data.month,
//                   value: search.month,
//                   buttonDecoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(14),
//                     border: Border.all(
//                       color: Colors.orangeAccent,
//                     ),
//                   ),
//                   onChanged: (value) {
//                     context.read<SearchModel>().setMonth(value!);
//                   },
//                 )
//               ],
//             ),
//           )),
//     );
//   }
// }

class DateMenu extends StatefulWidget {
  final Function(dynamic) loadData;
  final year;
  final month;

  const DateMenu(
      {Key? key,
      required this.loadData,
      required this.year,
      required this.month})
      : super(key: key);
  @override
  State<DateMenu> createState() => _DateMenuState();
}

class _DateMenuState extends State<DateMenu> {
  dynamic _year;
  dynamic _month;

  @override
  void initState() {
    super.initState();
    _year = widget.year;
    _month = widget.month;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.loadData({
          "type": "date",
          "data": {"year": _year, "month": _month}
        });
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
                widget.loadData({
                  "type": "date",
                  "data": {"year": _year, "month": _month}
                });
                Navigator.pop(context);
              },
            ),
            title: Text(date.label),
          ),
          body: Container(
            padding: EdgeInsets.symmetric(
                vertical: Adapt.px(80), horizontal: Adapt.px(70)),
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomDropdownButton2(
                  hint: '请选择年份',
                  dropdownItems: date.data.year,
                  value: _year,
                  buttonDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _year = value!;
                    });
                  },
                ),
                CustomDropdownButton2(
                  hint: '请选择月份',
                  dropdownItems: date.data.month,
                  value: _month,
                  buttonDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.orangeAccent,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _month = value!;
                    });
                  },
                )
              ],
            ),
          )),
    );
  }
}
