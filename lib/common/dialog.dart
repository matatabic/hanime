import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> _chooseDialog(context, text) async {
  showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(text),
          content: Card(
            elevation: 0.0,
            child: Column(
              children: <Widget>[
                CupertinoTextField(
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('取消'),
            ),
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('确定'),
            ),
          ],
        );
      });
}
