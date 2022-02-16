import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';

class Product {
  final String title;
  final String des;
  Product(this.title, this.des);
}

class VideoScreen extends StatefulWidget {
  final String url;

  VideoScreen({required this.url});

  @override
  WatchScreen createState() => WatchScreen();
}

class WatchScreen extends State<VideoScreen> {
  final FijkPlayer player = FijkPlayer();

  WatchScreen();

  @override
  void initState() {
    super.initState();
    player.setDataSource(
        "https://vdownload-28.sb-cd.com/1/0/10900430-720p.mp4?secure=03b28k4XgRF_74EAvlOleg,1643916903&m=28&d=2&_tid=10900430",
        autoPlay: true);
  }

  @override
  void dispose() {
    super.dispose();
    player.release();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WatchScreen'),
      ),
      body: Center(
        child: FijkView(player: player),
      ),
    );
  }
}
