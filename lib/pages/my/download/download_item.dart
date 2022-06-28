import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/common/common_image.dart';
import 'package:hanime/entity/download_entity.dart';

class DownloadItem extends StatelessWidget {
  final DownloadEntity downloadEntity;

  DownloadItem({Key? key, required this.downloadEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
            vertical: Adapt.px(10), horizontal: Adapt.px(10)),
        color: Color.fromRGBO(58, 60, 63, 1),
        height: Adapt.px(220),
        child: Row(
          children: [
            SizedBox(
              width: Adapt.px(300),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: (){
                      print("12312312");
                    },
                    child: Container(
                      height: Adapt.px(200),
                      child: CommonImages(
                        imgUrl: downloadEntity.imageUrl,
                      ),
                    ),
                  ),
                  !downloadEntity.success
                      ? IconButton(
                          iconSize: Adapt.px(100),
                          icon:
                              Icon(Icons.cloud_download, color: Colors.white70),
                          onPressed: () {
                            print("cloud_download");
                          },
                        )
                      : Container()
                ],
              ),
            ),
            Expanded(
              child: Container(
                  padding: EdgeInsets.only(left: Adapt.px(20)),
                  child: Text(downloadEntity.title,
                      style: TextStyle(
                          fontSize: Adapt.px(30),
                          fontWeight: FontWeight.bold,
                          color: Colors.white))),
            )
          ],
        ));
  }
}

// child: downloadEntity.waitDownload
//     ? Stack(alignment: Alignment.center, children: [
//         Container(
//           height: Adapt.px(200),
//           child: CommonImages(
//             imgUrl: downloadEntity.imageUrl,
//           ),
//         ),
//         LoadingCover(
//           width: Adapt.px(300),
//           height: Adapt.px(220),
//         )
//       ])
//     : downloadEntity.success
//         ? Container(
//             height: Adapt.px(200),
//             child: CommonImages(
//               imgUrl: downloadEntity.imageUrl,
//             ),
//           )
//         : Stack(
//             alignment: Alignment.center,
//             children: [
//               Container(
//                 height: Adapt.px(200),
//                 child: CommonImages(
//                   imgUrl: downloadEntity.imageUrl,
//                 ),
//               ),
//               LinearPercentIndicator(
//                 animation: true,
//                 isRTL: true,
//                 animateFromLastPercent: true,
//                 lineHeight: Adapt.px(200),
//                 animationDuration: 1000,
//                 percent: progress2showProgress(
//                     downloadEntity.progress),
//                 padding: EdgeInsets.all(0),
//                 center: Text(
//                     "${(downloadEntity.progress * 100).toStringAsFixed(1)}%"),
//                 linearStrokeCap: LinearStrokeCap.butt,
//                 backgroundColor: Colors.transparent,
//                 progressColor: Colors.black87,
//               ),
//               IconButton(
//                 iconSize: Adapt.px(100),
//                 icon: Icon(Icons.cloud_download,
//                     color: Colors.white70),
//                 onPressed: () {},
//               )
//               // Material(
//               //   type: MaterialType.transparency,
//               //   child: InkWell(
//               //     onTap: () {
//               //       print("MaterialType");
//               //     },
//               //   ),
//               // )
//             ],
//           ),
