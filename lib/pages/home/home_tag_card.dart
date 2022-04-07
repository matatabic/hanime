import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/common/common_image.dart';
import 'package:hanime/entity/home_entity.dart';

class HomeTagCard extends StatelessWidget {
  final HomeTagVideo data;
  final int index;
  const HomeTagCard({Key? key, required this.data, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        flex: 1,
        child: InkWell(
          onTap: () {
            print("123");
          },
          child: Container(
            margin: EdgeInsets.only(top: Adapt.px(7)),
            child: Stack(
              alignment: Alignment(-1, 1),
              children: [
                ConstrainedBox(
                    child: CommonImages(
                        imgUrl:
                            'http://img5.mtime.cn/mt/2022/01/19/102417.23221502_1280X720X2.jpg'
                        // data.imgUrl
                        ),
                    constraints: new BoxConstraints.expand()),
                Container(color: Colors.black26),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: Adapt.px(5)),
                    child: Container(
                      height: Adapt.px(100),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            data.title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Adapt.px(35)),
                          ),
                          Text(
                            data.total,
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
