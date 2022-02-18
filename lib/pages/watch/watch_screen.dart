import 'package:flutter/material.dart';
import 'package:hanime/pages/watch/video_screen.dart';
import 'package:hanime/services/watch_services.dart';
import 'package:hanime/utils/logUtil.dart';

class WatchScreen extends StatefulWidget {
  final Map<String, dynamic> data;
  WatchScreen({Key? key, required this.data}) : super(key: key);

  @override
  _WatchScreenState createState() => _WatchScreenState(this.data);
}

class _WatchScreenState extends State<WatchScreen> {
  final Map<String, dynamic> data;
  _WatchScreenState(this.data);

  Map<String, List<Map<String, dynamic>>> dataList = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("213"),
      ),
      body: SafeArea(
        child: SizedBox.expand(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: VideoScreen(),
          ),
        ),
      ),
    );
  }

  initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    var data = await getWatchData(this.data['url']);
    LogUtil.d(data);
    setState(() {
      dataList = data;
    });
  }
}
