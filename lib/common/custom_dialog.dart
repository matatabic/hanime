import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialog {
  static Future<void> showTextDialog(context, title, onPressed) async {
    String content = "";
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Card(
              elevation: 0.0,
              child: Column(
                children: <Widget>[
                  CupertinoTextField(
                    onChanged: (String text) => {content = text},
                    maxLength: 10,
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
                  onPressed(content);
                },
                child: Text('确定'),
              ),
            ],
          );
        });
  }

  static Future<void> showDialog(context, text, onPressed) async {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(text),
            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('取消'),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  onPressed();
                },
                child: Text('确定'),
              ),
            ],
          );
        });
  }
}
