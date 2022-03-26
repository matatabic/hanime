import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/entity/search_entity.dart';
import 'package:hanime/providers/search_state.dart';
import 'package:provider/src/provider.dart';

SearchDate date = SearchDate.fromJson({
  "label": "發佈日期",
  "data": {
    "year": [
      "全部",
      "2021",
      "2020",
      "2019",
      "2018",
      "2017",
      "2016",
      "2015",
      "2014",
      "2013",
      "2012",
      "2011",
      "2010",
      "2009",
      "2008",
      "2007",
      "2006",
      "2005",
      "2004",
      "2003",
      "2002",
      "2001",
      "2000",
      "1999",
      "1998",
      "1997",
      "1996",
      "1995",
      "1994",
      "1993",
      "1992",
      "1991",
      "1990",
    ],
    "month": [
      "全部",
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9",
      "10",
      "11",
      "12",
    ],
  }
});

class DateMenu extends StatelessWidget {
  final int currentScreen;
  final VoidCallback loadData;
  const DateMenu(
      {Key? key, required this.currentScreen, required this.loadData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Search search = context.watch<SearchState>().searchList[currentScreen];
    return WillPopScope(
      onWillPop: () async {
        loadData();
        return true;
      },
      child: Scaffold(
          backgroundColor: Colors.black,
          appBar: new AppBar(
            centerTitle: true,
            backgroundColor: Colors.orange,
            leading: IconButton(
              icon: Icon(Icons.close_rounded),
              onPressed: () {
                loadData();
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
                  value: search.year,
                  buttonDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.orangeAccent,
                    ),
                  ),
                  onChanged: (value) {
                    context.read<SearchState>().setYear(currentScreen, value!);
                  },
                ),
                CustomDropdownButton2(
                  hint: '请选择月份',
                  dropdownItems: date.data.month,
                  value: search.month,
                  buttonDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.orangeAccent,
                    ),
                  ),
                  onChanged: (value) {
                    context.read<SearchState>().setMonth(currentScreen, value!);
                  },
                )
              ],
            ),
          )),
    );
  }
}
