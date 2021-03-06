import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:hanime/providers/home_state.dart';
import 'package:hanime/providers/watch_state.dart';
import 'package:provider/provider.dart';

import 'bottom_nav_bar.dart';

// void main() => runApp(new MyApp());
void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => HomeState()),
          ChangeNotifierProvider(create: (_) => WatchState()),
        ],
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        builder: BotToastInit(), //1.调用BotToastInit
        navigatorObservers: [BotToastNavigatorObserver()], //2.注册路由观察者
        theme: new ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.lightBlue[800],
          accentColor: Colors.cyan[600],
          scaffoldBackgroundColor: Colors.black26,
        ),
        home: new BottomNavBar());
  }
}
