import 'package:flutter/material.dart';
import 'package:hanime/entity/search_entity.dart';
import 'package:hanime/services/search_services.dart';

class TagMenu extends StatelessWidget {
  final Function(dynamic) loadData;
  final bool broad;
  final List<String> customTagList;
  final List<String> tagList;

  const TagMenu(
      {Key? key,
      required this.loadData,
      required this.customTagList,
      required this.tagList,
      required this.broad})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        loadData({"type": "broad", "data": _broad});
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
                loadData({"type": "broad", "data": _broad});
                Navigator.pop(context);
              },
            ),
            title: Text(searchTag.label),
          ),
          body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Container(
              child: Column(
                children: [
                  BroadContainer(broad: broad),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: searchTag.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return TagContainer(
                            customTagList: customTagList,
                            index: index,
                            tagList: tagList,
                            // active: tagList.contains(searchTag.data[index]),
                            searchTagData: searchTag.data[index]);
                      }),
                ],
              ),
            ),
          )),
    );
  }
}

class TagContainer extends StatefulWidget {
  final List<String> customTagList;
  final List<String> tagList;
  final int index;
  final SearchTagData searchTagData;

  const TagContainer(
      {Key? key,
      required this.customTagList,
      required this.tagList,
      required this.index,
      required this.searchTagData})
      : super(key: key);

  @override
  State<TagContainer> createState() => _TagContainerState();
}

class _TagContainerState extends State<TagContainer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tagWidgetList = [];

    if (widget.index == 0) {
      for (String title in widget.customTagList) {
        tagWidgetList.add(TagDetail(
            tagList: widget.tagList,
            title: title,
            active: widget.tagList.indexOf(title) > -1));
      }
    }
    print(widget.searchTagData.data);
    for (String title in widget.searchTagData.data) {
      tagWidgetList.add(TagDetail(
          tagList: widget.tagList,
          title: title,
          active: widget.tagList.indexOf(title) > -1));
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: Text(
              widget.searchTagData.label,
              style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          Wrap(
            children: tagWidgetList,
            spacing: 10,
            runSpacing: 10,
          )
        ],
      ),
    );
  }
}

class BroadContainer extends StatefulWidget {
  final bool broad;

  const BroadContainer({Key? key, required this.broad}) : super(key: key);

  @override
  State<BroadContainer> createState() => _BroadContainerState();
}

bool _broad = false;

class _BroadContainerState extends State<BroadContainer> {
  @override
  void initState() {
    super.initState();
    _broad = widget.broad;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(51, 51, 51, 1),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 7.5),
      height: 110,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "廣泛配對",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
              Switch(
                value: _broad,
                activeColor: Theme.of(context).primaryColor,
                onChanged: (value) {
                  setState(() {
                    _broad = value;
                  });
                },
              ),
            ],
          ),
          Text("較多結果，較不精準。配對所有包含任何一個選擇的標籤的影片，而非全部標籤。")
        ],
      ),
    );
  }
}

class TagDetail extends StatefulWidget {
  final List<String> tagList;
  final String title;
  final bool active;

  const TagDetail(
      {Key? key,
      required this.tagList,
      required this.title,
      required this.active})
      : super(key: key);

  @override
  State<TagDetail> createState() => _TagDetailState();
}

class _TagDetailState extends State<TagDetail> {
  bool _active = false;

  @override
  void initState() {
    super.initState();
    _active = widget.active;
  }

  void _onPressHandler() {
    setState(() {
      _active = !_active;
    });
    if (_active) {
      widget.tagList.add(widget.title);
    } else {
      widget.tagList.remove(widget.title);
    }
    print('_brandList: $widget.brandList');
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _onPressHandler();
      },
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: _active ? Theme.of(context).primaryColor : Colors.black,
            borderRadius: BorderRadius.all(
              Radius.circular(7),
            ),
            border: new Border.all(
              color: Colors.grey, //边框颜色
              width: 2.5, //边框粗细
            )),
        child: Text(
          widget.title,
          style: TextStyle(fontSize: 17),
        ),
      ),
    );
  }
}
