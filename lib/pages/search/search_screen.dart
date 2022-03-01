import 'package:flutter/cupertino.dart';
import 'package:hanime/services/search_services.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  initState() {
    super.initState();
    getEpisodeData();
  }

  getEpisodeData() async {
    var data = await getSearchData();
  }
}
