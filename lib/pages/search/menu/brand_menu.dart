import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/providers/search_state.dart';
import 'package:hanime/services/search_services.dart';
import 'package:provider/src/provider.dart';

class BrandMenu extends StatelessWidget {
  final int currentScreen;
  final VoidCallback loadData;
  const BrandMenu(
      {Key? key, required this.currentScreen, required this.loadData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Search search = context.watch<SearchState>().searchList[currentScreen];
    List<Widget> tagWidgetList = [];
    for (String title in brand.data) {
      tagWidgetList.add(InkWell(
        onTap: () {
          context.read<SearchState>().selectedBrandHandle(currentScreen, title);
        },
        child: BrandDetail(
            title: title,
            color: search.brandList.indexOf(title) > -1
                ? Colors.orange
                : Colors.black),
      ));
    }

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
            title: Text(brand.label),
          ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: SingleChildScrollView(
                padding: EdgeInsets.only(top: Adapt.px(20)),
                physics: const ClampingScrollPhysics(),
                child: Wrap(
                  children: tagWidgetList,
                  spacing: Adapt.px(20),
                  runSpacing: Adapt.px(20),
                )),
          )),
    );
  }
}

class BrandDetail extends StatelessWidget {
  final String title;
  final Color color;

  const BrandDetail({Key? key, required this.title, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Adapt.px(10)),
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(
            Radius.circular(Adapt.px(15)),
          ),
          border: new Border.all(
            color: Colors.grey, //边框颜色
            width: Adapt.px(5), //边框粗细
          )),
      child: Text(
        title,
        style: TextStyle(fontSize: Adapt.px(34)),
      ),
    );
  }
}
