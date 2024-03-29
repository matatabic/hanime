import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/component/menu_widget.dart';
import 'package:hanime/services/search_services.dart';

class DurationMenu extends StatefulWidget {
  final Function(dynamic) loadData;
  final int durationIndex;

  const DurationMenu(
      {Key? key, required this.loadData, required this.durationIndex})
      : super(key: key);

  @override
  State<DurationMenu> createState() => _DurationMenuState();
}

class _DurationMenuState extends State<DurationMenu> {
  late int _index;

  @override
  void initState() {
    super.initState();
    _index = widget.durationIndex;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.loadData({"type": "duration", "data": _index});
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
                widget.loadData({"type": "duration", "data": _index});
                Navigator.pop(context);
              },
            ),
            title: Text(duration.label),
          ),
          body: ListView.separated(
            padding: EdgeInsets.only(top: 10),
            itemBuilder: (BuildContext context, int index) {
              return Material(
                color: index == _index
                    ? Theme.of(context).primaryColor
                    : Colors.black,
                child: MenuWidget(
                  title: duration.data[index],
                  onTap: () {
                    setState(() {
                      _index = index;
                    });
                  },
                ),
              );
            },
            itemCount: duration.data.length,
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
