import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

class IgnoreShowOnScreenWidget extends SingleChildRenderObjectWidget {
  const IgnoreShowOnScreenWidget({
    Key? key,
    Widget? child,
    this.ignoreShowOnScreen = true,
  }) : super(key: key, child: child);

  final bool ignoreShowOnScreen;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return IgnoreShowOnScreenRenderObject(
      ignoreShowOnScreen: ignoreShowOnScreen,
    );
  }
}

class IgnoreShowOnScreenRenderObject extends RenderProxyBox {
  IgnoreShowOnScreenRenderObject({
    RenderBox? child,
    this.ignoreShowOnScreen = true,
  });

  final bool ignoreShowOnScreen;

  @override
  void showOnScreen({
    RenderObject? descendant,
    Rect? rect,
    Duration duration = Duration.zero,
    Curve curve = Curves.ease,
  }) {
    if (!ignoreShowOnScreen) {
      return super.showOnScreen(
        descendant: descendant,
        rect: rect,
        duration: duration,
        curve: curve,
      );
    }
  }
}
