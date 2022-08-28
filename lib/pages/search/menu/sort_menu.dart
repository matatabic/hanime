import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/component/menu_widget.dart';
import 'package:hanime/services/search_services.dart';

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
            padding: EdgeInsets.only(top: 10),
            itemBuilder: (BuildContext context, int index) {
              return Material(
                color: index == _index
                    ? Theme.of(context).primaryColor
                    : Colors.black,
                child: MenuWidget(
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
                height: 2.5,
                color: Colors.white30,
              );
            },
          )),
    );
  }
}
