import 'package:flutter/material.dart';
import 'package:hanime/services/watch_services.dart';

class WatchScreen extends StatefulWidget {
  final Map<String, dynamic> data;
  WatchScreen({Key? key, required this.data}) : super(key: key);

  @override
  _WatchScreenState createState() => _WatchScreenState(this.data);
}

class _WatchScreenState extends State<WatchScreen> {
  final Map<String, dynamic> data;
  _WatchScreenState(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SizedBox.expand(
          child: Container(
            child: Text("123"),
            color: Colors.red,
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
    setState(() {});
  }
}
