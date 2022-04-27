import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/LikeButton.dart';
import 'package:hanime/common/adapt.dart';

class DownloadIcon extends StatefulWidget {
  const DownloadIcon({Key? key}) : super(key: key);

  @override
  _DownloadIconState createState() => _DownloadIconState();
}

class _DownloadIconState extends State<DownloadIcon> {
  GlobalKey iconKey = new GlobalKey();

  bool isLiked = false;

  bool isPanel = false;

  @override
  Widget build(BuildContext context) {
    return LikeButton(
      key: iconKey,
      likeBuilder: (bool isLiked) {
        return Icon(
          Icons.file_download,
          color: isLiked ? Colors.red : Colors.grey,
          size: Adapt.px(70),
        );
      },
      onTap: (bool isLike) async {
        showCupertinoDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title: Text("是否下载该影片?"),
                actions: <Widget>[
                  CupertinoDialogAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('取消'),
                  ),
                  CupertinoDialogAction(
                    onPressed: () {
                      setState(() {
                        isLiked = !isLike;
                      });
                      Navigator.pop(context);
                    },
                    child: Text('确定'),
                  ),
                ],
              );
            });
      },
      isLiked: isLiked,
    );
  }
}
