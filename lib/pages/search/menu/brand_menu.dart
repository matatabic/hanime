import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/services/search_services.dart';

class BrandMenu extends StatelessWidget {
  final Function(dynamic) loadData;
  final List<String> brandList;

  const BrandMenu({Key? key, required this.loadData, required this.brandList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('BrandMenu build');
    List<Widget> tagWidgetList = [];
    for (String title in brand.data) {
      tagWidgetList.add(BrandDetail(
          brandList: brandList,
          title: title,
          active: brandList.contains(title)));
    }

    return WillPopScope(
      onWillPop: () async {
        // loadData({});
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
                // loadData({});
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

// search.brandList.indexOf(title) > -1
class BrandDetail extends StatefulWidget {
  final List<String> brandList;
  final String title;
  final bool active;

  const BrandDetail(
      {Key? key,
      required this.brandList,
      required this.title,
      required this.active})
      : super(key: key);

  @override
  State<BrandDetail> createState() => _BrandDetailState();
}

class _BrandDetailState extends State<BrandDetail> {
  bool _active = false;

  @override
  initState() {
    super.initState();
    _active = widget.active;
  }

  void _onPressHandler() {
    setState(() {
      _active = !_active;
    });
    if (_active) {
      widget.brandList.add(widget.title);
    } else {
      widget.brandList.remove(widget.title);
    }
    print('_brandList: $widget.brandList');
  }

  @override
  Widget build(BuildContext context) {
    print("_BrandDetailState build");
    return Material(
      borderRadius: BorderRadius.all(
        Radius.circular(Adapt.px(15)),
      ),
      color: _active ? Theme.of(context).primaryColor : Colors.black,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(Adapt.px(15)),
            ),
            border: new Border.all(
              color: Colors.grey, //边框颜色
              width: Adapt.px(5), //边框粗细
            )),
        child: InkWell(
            onTap: () {
              _onPressHandler();
            },
            child: Container(
              padding: EdgeInsets.all(Adapt.px(10)),
              child: Text(
                widget.title,
                style: TextStyle(fontSize: Adapt.px(34)),
              ),
            )),
      ),
    );
  }
}
