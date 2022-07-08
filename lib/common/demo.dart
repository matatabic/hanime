import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

void main() {
  runApp(MaterialApp(
    // 该组件本质是 StatelessWidget 组件子类
    home: RadialHeroAnimation(),
  ));
}

/// Hero 组件 , 跳转前后两个页面都有该组件
class ImageWidget extends StatelessWidget {
  /// 构造方法
  const ImageWidget({Key? key, required this.imageUrl, required this.onTap})
      : super(key: key);

  /// Hero 动画之间关联的 ID , 通过该标识
  /// 标识两个 Hero 组件之间进行动画过渡
  /// 同时该字符串也是图片的 url 网络地址
  final String imageUrl;

  /// 点击后的回调事件
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Material(
      /// 获取主题颜色 , 并将透明度设置为 0.25
      color: Colors.green,

      /// 按钮
      child: InkWell(
        /// 按钮点击事件
        onTap: onTap,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints size) {
            return Image.network(
              imageUrl,
              fit: BoxFit.contain,
            );
          },
        ),
      ),
    );
  }
}

/// Hero 组件 , 径向动画扩展
/// 该组件主要用于裁剪组件用的
class OvalRectWidget extends StatelessWidget {
  /// 这里的裁剪大小 clipRectSize 最大半径 / 2 的开方值 再乘以 2
  const OvalRectWidget({Key? key, required this.maxRadius, required this.child})
      : clipRectSize = 2.0 * (maxRadius / math.sqrt2),
        super(key: key);
  // 最大半径值
  final double maxRadius;

  /// 该值需要动态计算
  final clipRectSize;
  final Widget child;

  /// 这里特别注意该圆形裁剪组件
  /// 如果整个组件的宽高都是 maxRadius ,
  /// 内部的方形组件宽高是 2.0 * (maxRadius / math.sqrt2)
  /// 并且该方形组件居中显示
  /// 那么该方形组件的四个顶点正好处于圆形组件的裁剪半径位置
  /// 也就是方形组件完整显示 , 没有裁剪到
  @override
  Widget build(BuildContext context) {
    /// 布局裁剪组件 , 可以将布局裁剪成圆形
    return ClipOval(
      /// 可用于约束布局大小的组件
      /// 这里的居中显示是关键 , 如果不居中显示 , 最终还是圆形
      child: Center(
        child: SizedBox(
          width: clipRectSize,
          height: clipRectSize,

          /// 用于裁剪圆角矩形的组件
          child: ClipRect(
            child: child,
          ),
        ),
      ),
    );
  }
}

class RadialHeroAnimation extends StatelessWidget {
  /// 最小半径
  /// 使用该半径作为组件大小时 , 组件被裁剪成圆形
  static const double minRadius = 32.0;

  /// 最大半径
  /// 使用该半径作为组件大小时 , 组件被裁剪成方形
  static const double maxRadius = 128.0;

  /// 动画差速器
  static const opacityCurve = Interval(0.0, 0.75, curve: Curves.fastOutSlowIn);

  /// 创建径向动画
  static RectTween _createRectTween(Rect? begin, Rect? end) {
    /// MaterialRectCenterArcTween 就是从方形到圆形变化的辅助类
    return MaterialRectCenterArcTween(begin: begin, end: end);
  }

  /// 创建页面 2 , 这是点击后跳转到的页面
  /// 三个参数分别是 : 上下文 , 图片名称 , 页面描述
  /// 页面的核心组件是 Hero 组件 , 只有 1 个
  static Widget _buildSecondPageWidget(
      BuildContext context, String imageName, String description) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: Center(
        child: Card(
          /// 设置卡片布局阴影大小
          elevation: 8,

          /// 卡片布局中显示图片和图片的描述
          child: Column(
            /// 在主轴方向 , 也就是垂直方向 , 应该占用多少空间
            /// Colum 主轴方向是垂直方向
            /// Row 主轴方向是水平方向
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                /// 约束布局大小的组件的宽高定义为最大半径的两倍
                width: maxRadius * 2,
                height: maxRadius * 2,

                /// 核心 Hero 组件
                child: Hero(
                  /// 创建径向动画
                  /// 如果没有这个动画 , 中间过程会变成椭圆
                  createRectTween: _createRectTween,

                  /// Hero 动画标签 ID
                  tag: imageName,

                  /// Hero 动画作用的组件
                  child: OvalRectWidget(
                    /// 这里的半径设置为最大半径值 ,
                    maxRadius: maxRadius,

                    /// 最内层显示的是网络图片组件
                    child: ImageWidget(
                      imageUrl: imageName,
                      onTap: () {
                        /// 点击后关闭当前页面
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ),

              /// 图片描述文本
              Text(
                // 设置文本内容
                description,
                // 设置文本样式, 粗体
                style: TextStyle(fontWeight: FontWeight.bold),
                textScaleFactor: 3.0,
              ),

              /// 空白间隔 , 无实际意义
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 创建在界面 1 显示的图标 , 点击后跳转到界面 2
  /// 页面的核心组件是 Hero 组件 , 而且是 3 个
  Widget _buildFirstPagWidget(
      BuildContext context, String imageName, String description) {
    return Container(
      /// 界面 1 中的显示的 Hero 组件是小图标
      /// 图标大小就是半径的两倍
      width: minRadius * 2.0,
      height: minRadius * 2.0,

      /// 主界面的核心 Hero 动画
      child: Hero(
        /// 这是 Hero 径向动画与标准 Hero 动画的区别
        /// 如果没有这个动画 , 中间过程会变成椭圆
        createRectTween: _createRectTween,

        /// Hero 动画标签
        tag: imageName,
        child: OvalRectWidget(
          maxRadius: maxRadius,

          /// 最内层显示的是网络图片组件
          child: ImageWidget(
            /// 设置网络图片地址
            imageUrl: imageName,
            // 设置点击事件
            onTap: () {
              /// 点击后跳转到新界面中
              Navigator.of(context).push(PageRouteBuilder<void>(pageBuilder:
                  (BuildContext context, Animation<double> animation,
                      Animation<double> secondaryAnimation) {
                // 创建一个 RoutePageBuilder
                return AnimatedBuilder(
                    animation: animation,
                    builder: (context, child) {
                      /// 设置透明度组件
                      return Opacity(
                        /// 当前的透明度值 , 取值 0.0 ~ 1.0
                        opacity: opacityCurve.transform(animation.value),
                        // 主要显示的使用透明度控制的组件
                        // 页面 2 组件
                        child: _buildSecondPageWidget(
                            context, imageName, description),
                      );
                    });
              }));
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    /// 时间膨胀系数 , 用于降低动画运行速度
    /// 1.0 是标准速度
    timeDilation = 10.0;

    /// 主界面显示内容
    return Scaffold(
      appBar: AppBar(
        title: Text("Hero 径向动画演示"),
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        alignment: FractionalOffset.bottomLeft,

        /// 横向列表显示 3 个图标
        child: Row(
          /// 排列方式 : 平分空间
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildFirstPagWidget(context,
                "https://img-blog.csdnimg.cn/20210330094257242.png", "蜂王"),
            _buildFirstPagWidget(context,
                "https://img-blog.csdnimg.cn/20210330093526559.png", "蜜蜂"),
            _buildFirstPagWidget(context,
                "https://img-blog.csdnimg.cn/2021033009353553.png", "工蜂"),
          ],
        ),
      ),
    );
  }
}
