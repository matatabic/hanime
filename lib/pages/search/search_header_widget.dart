import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/pages/search/search_engine_widget.dart';
import 'package:hanime/pages/search/search_menu_widget.dart';

class SearchHeaderWidget extends StatefulWidget {
  final double topHeight;
  final Function(dynamic) loadData;
  final bool broad;
  final int genreIndex;
  final int sortIndex;
  final int durationIndex;
  final year;
  final month;
  final List<String> customTagList;
  final List<String> tagList;
  final List<String> brandList;

  const SearchHeaderWidget(
      {Key? key,
      required this.topHeight,
      required this.broad,
      required this.loadData,
      required this.genreIndex,
      required this.sortIndex,
      required this.durationIndex,
      required this.year,
      required this.month,
      required this.customTagList,
      required this.tagList,
      required this.brandList})
      : super(key: key);

  @override
  _SearchHeaderWidgetState createState() => _SearchHeaderWidgetState();
}

class _SearchHeaderWidgetState extends State<SearchHeaderWidget> {
  final focusNode = FocusNode();
  String _tempQuery = "";

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: false,
      floating: true,
      stretch: true,
      automaticallyImplyLeading: false,
      toolbarHeight: widget.topHeight,
      expandedHeight: widget.topHeight,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.all(0),
        title: Column(
          children: [
            SearchEngineWidget(
                focusNode: focusNode,
                onChangeQuery: (dynamic data) => _onChangeQuery(data),
                loadData: (dynamic data) => widget.loadData(data),
                query: _tempQuery),
            SearchMenuWidget(
                loadData: (dynamic data) => widget.loadData(data),
                genreIndex: widget.genreIndex,
                sortIndex: widget.sortIndex,
                durationIndex: widget.durationIndex,
                broad: widget.broad,
                year: widget.year,
                month: widget.month,
                customTagList: widget.customTagList,
                tagList: widget.tagList,
                brandList: widget.brandList)
          ],
        ),
      ),
    );
  }

  void _onChangeQuery(String data) {
    setState(() {
      _tempQuery = data;
    });
  }
}
