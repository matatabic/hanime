import 'package:flutter/cupertino.dart';

class WatchScreen extends StatelessWidget {
  final Map<String, dynamic> data;
  WatchScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(data);
    return Container();
  }
}
