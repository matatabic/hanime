import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:hanime/providers/download_model.dart';
import 'package:hanime/providers/favourite_model.dart';
import 'package:hanime/providers/home_model.dart';
import 'package:hanime/providers/search_model.dart';
import 'package:hanime/providers/watch_model.dart';
import 'package:provider/provider.dart';

import 'bottom_nav_bar.dart';

// void main() => runApp(new MyApp());
void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => HomeModel()),
          ChangeNotifierProvider(create: (_) => WatchModel()),
          ChangeNotifierProvider(create: (_) => SearchModel()),
          ChangeNotifierProvider(create: (_) => FavouriteModel()),
          ChangeNotifierProvider(create: (_) => DownloadModel()),
        ],
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        showPerformanceOverlay: false,
        locale: const Locale('en'),
        builder: BotToastInit(), //1.调用BotToastInit
        navigatorObservers: [BotToastNavigatorObserver()], //2.注册路由观察者
        theme: new ThemeData(
          platform: TargetPlatform.iOS,
          brightness: Brightness.dark,
          primaryColor: Colors.orange[800],
          accentColor: Colors.orange[300],
          scaffoldBackgroundColor: Colors.black26,
        ),
        home: new BottomNavBar());
  }
}
