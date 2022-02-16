/**
 * 使用BackdropFilter实现毛玻璃效果,且子部件需要设置Opacity
 * 使用这个部件的代价很高，尽量少用
 * ImageFilter.blur的sigmaX/Y决定了毛玻璃的模糊程度，值越高越模糊
 * 一般来说，为了防止模糊效果绘制出边界，需要使用ClipRect Widget包裹
 */
import 'dart:ui';

import 'package:flutter/material.dart';

class FrostedGlassDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          new ConstrainedBox(
              constraints: const BoxConstraints.expand(),
              child: Image.network(
                  'https://img0.baidu.com/it/u=3842015069,1925244851&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=652',
                  fit: BoxFit.cover)),
          Container(
            child: new ClipRect(
              child: new BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Opacity(
                  opacity: 0.5,
                  child: new Container(
                    decoration: new BoxDecoration(
                      color: Colors.grey.shade500.withOpacity(0.3),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
