import 'package:flutter/material.dart';
import 'package:hanime/providers/counter.dart';
import 'package:hanime/providers/home_state.dart';
import 'package:provider/provider.dart';

import 'bottom_nav_bar.dart';

// void main() => runApp(new MyApp());
void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => HomeState()),
          ChangeNotifierProvider(create: (_) => Counter()),
        ],
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        theme: new ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.lightBlue[800],
          accentColor: Colors.cyan[600],
          scaffoldBackgroundColor: Colors.black26,
        ),
        home: new BottomNavBar());
  }
}
