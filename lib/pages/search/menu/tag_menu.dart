import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/entity/search_entity.dart';
import 'package:hanime/providers/search_state.dart';
import 'package:hanime/services/search_services.dart';
import 'package:provider/src/provider.dart';

class TagMenu extends StatelessWidget {
  final int currentScreen;
  final VoidCallback loadData;
  const TagMenu({Key? key, required this.currentScreen, required this.loadData})
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
            title: Text(searchTag.label),
          ),
          body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Container(
              child: Column(
                children: [
                  Container(
                    color: Color.fromRGBO(51, 51, 51, 1),
                    padding: EdgeInsets.symmetric(
                        horizontal: Adapt.px(32), vertical: Adapt.px(15)),
                    height: Adapt.px(220),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "廣泛配對",
                              style: TextStyle(
                                  fontSize: Adapt.px(45),
                                  fontWeight: FontWeight.bold),
                            ),
                            Switch(
                              value: search.broad,
                              activeColor: Colors.orange,
                              onChanged: (value) {
                                context
                                    .read<SearchState>()
                                    .setBroadFlag(currentScreen, value);
                              },
                            ),
                          ],
                        ),
                        Container(
                            child: Text("較多結果，較不精準。配對所有包含任何一個選擇的標籤的影片，而非全部標籤。"))
                      ],
                    ),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: searchTag.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return TagContainer(
                            currentScreen: currentScreen,
                            searchTagData: searchTag.data[index],
                            onTap: (String title) {
                              context
                                  .read<SearchState>()
                                  .selectedTagHandle(currentScreen, title);
                            });
                      }),
                ],
              ),
            ),
          )),
    );
  }
}

class TagContainer extends StatelessWidget {
  final int currentScreen;
  final SearchTagData searchTagData;
  final Function(String title) onTap;

  const TagContainer(
      {Key? key,
      required this.currentScreen,
      required this.searchTagData,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Search search = context.watch<SearchState>().searchList[currentScreen];
    List<Widget> tagWidgetList = [];
    for (String title in searchTagData.data) {
      tagWidgetList.add(InkWell(
        onTap: () {
          onTap(title);
        },
        child: TagDetail(
          title: title,
          color:
              search.tagList.indexOf(title) > -1 ? Colors.orange : Colors.black,
        ),
      ));
    }

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Adapt.px(32), vertical: Adapt.px(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: Adapt.px(10)),
            child: Text(
              searchTagData.label,
              style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: Adapt.px(40)),
            ),
          ),
          Wrap(
            children: tagWidgetList,
            spacing: Adapt.px(20),
            runSpacing: Adapt.px(20),
          )
        ],
      ),
    );
  }
}

class TagDetail extends StatelessWidget {
  final String title;
  final Color color;

  const TagDetail({Key? key, required this.title, required this.color})
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
