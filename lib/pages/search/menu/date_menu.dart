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
      "2021年",
      "2020年",
      "2019年",
      "2018年",
      "2017年",
      "2016年",
      "2015年",
      "2014年",
      "2013年",
      "2012年",
      "2011年",
      "2010年",
      "2009年",
      "2008年",
      "2007年",
      "2006年",
      "2005年",
      "2004年",
      "2003年",
      "2002年",
      "2001年",
      "2000年",
      "1999年",
      "1998年",
      "1997年",
      "1996年",
      "1995年",
      "1994年",
      "1993年",
      "1992年",
      "1991年",
      "1990年",
    ],
    "month": [
      "全部",
      "1月",
      "2月",
      "3月",
      "4月",
      "5月",
      "6月",
      "7月",
      "8月",
      "9月",
      "10月",
      "11月",
      "12月",
    ],
  }
});

class DateMenu extends StatelessWidget {
  DateMenu({Key? key}) : super(key: key);

  String? selectedValue;

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
          title: Text(date.label),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(
              vertical: Adapt.px(80), horizontal: Adapt.px(70)),
          child: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Text(context.watch<SearchState>().year),
              CustomDropdownButton2(
                hint: '请选择年份',
                dropdownItems: date.data.year,
                value: context.watch<SearchState>().year,
                buttonDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: Colors.orangeAccent,
                  ),
                ),
                onChanged: (value) {
                  context.read<SearchState>().setYear(value!);
                },
              ),
              CustomDropdownButton2(
                hint: '请选择月份',
                dropdownItems: date.data.month,
                value: context.watch<SearchState>().month,
                buttonDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: Colors.orangeAccent,
                  ),
                ),
                onChanged: (value) {
                  context.read<SearchState>().setMonth(value!);
                },
              )
            ],
          ),
        ));
  }
}
