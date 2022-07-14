import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/providers/search_model.dart';
import 'package:hanime/services/search_services.dart';
import 'package:provider/src/provider.dart';

class DateMenu extends StatelessWidget {
  final VoidCallback loadData;

  const DateMenu({Key? key, required this.loadData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Search search = context.watch<SearchModel>().searchList;
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
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  onChanged: (value) {
                    context.read<SearchModel>().setYear(value!);
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
                    context.read<SearchModel>().setMonth(value!);
                  },
                )
              ],
            ),
          )),
    );
  }
}
