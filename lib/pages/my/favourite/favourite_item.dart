import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/entity/favourite_entity.dart';

// class FavouriteItem extends StatelessWidget {
//   final FavouriteChildren anime;
//   final bool showBg;
//   final String heroTag = UniqueKey().toString();
//
//   FavouriteItem({Key? key, required this.anime, this.showBg = true})
//       : super(key: key);
//
//     return Container(
//         padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
//         color: showBg ? Color.fromRGBO(58, 60, 63, 1) : Colors.transparent,
//         height: 110,
//         child: Row(
//           children: [
//             InkWell(
//               onLongPress: () {
//                 Navigator.of(context).push(NoAnimRouter(
//                   HeroPhotoView(
//                     heroTag: heroTag,
//                     maxScale: 1.5,
//                     imageProvider: NetworkImage(anime.imageUrl),
//                   ),
//                 ));
//               },
//               child: Hero(
//                   tag: heroTag,
//                   child: ClipOval(
//                     child: Container(
//                       width: 70,
//                       height: 70,
//                       child: CommonNormalImage(
//                         imgUrl: anime.imageUrl,
//                       ),
//                     ),
//                   )),
//             ),
//             Expanded(
//               child: Padding(
//                   padding: EdgeInsets.only(left: 10),
//                   child: Text(anime.title,
//                       style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white))),
//             ),
//           ],
//         ));
//   }
// }

const Duration _kExpand = Duration(milliseconds: 200);

class FavouriteItem extends StatefulWidget {
  final FavouriteChildren anime;
  final bool showBg;
  final String heroTag = UniqueKey().toString();

  FavouriteItem({Key? key, required this.anime, this.showBg = true})
      : super(key: key);

  @override
  _FavouriteItemState createState() => _FavouriteItemState();
}

class _FavouriteItemState extends State<FavouriteItem>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeOutTween =
      CurveTween(curve: Curves.easeOut);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);

  final ColorTween _borderColorTween = ColorTween();
  final ColorTween _headerColorTween = ColorTween();
  final ColorTween _iconColorTween = ColorTween();
  final ColorTween _backgroundColorTween = ColorTween();

  late AnimationController _controller;
  late Animation<double> _iconTurns;
  late Animation<Color?> _iconColor;
  late Animation<Color?> _borderColor;
  late Animation<Color?> _headerColor;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _kExpand, vsync: this);
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));
    _iconColor = _controller.drive(_iconColorTween.chain(_easeInTween));
    _borderColor = _controller.drive(_borderColorTween.chain(_easeOutTween));
    _headerColor = _controller.drive(_headerColorTween.chain(_easeInTween));

    if (_isExpanded) _controller.value = 1.0;

    // Schedule the notification that widget has changed for after init
    // to ensure that the parent widget maintains the correct state
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggle() {
    _setExpanded(!_isExpanded);
  }

  void _setExpanded(bool expanded) {
    if (_isExpanded != expanded) {
      setState(() {
        _isExpanded = expanded;
        if (_isExpanded) {
          _controller.forward();
        } else {
          _controller.reverse().then<void>((void value) {
            if (!mounted) return;
            setState(() {
              // Rebuild without widget.children.
            });
          });
        }
        // PageStorage.of(context)
        //     ?.writeState(context, _isExpanded, identifier: widget.listKey);
      });
      // if (widget.onExpansionChanged != null) {
      //   widget.onExpansionChanged!(_isExpanded);
      // }
    }
  }

  @override
  void didChangeDependencies() {
    final ThemeData theme = Theme.of(context);
    _borderColorTween.end = theme.dividerColor;
    _headerColorTween
      ..begin = theme.textTheme.subtitle1!.color
      ..end = theme.colorScheme.secondary;
    _iconColorTween
      ..begin = theme.unselectedWidgetColor
      ..end = theme.colorScheme.secondary;
    // _backgroundColorTween.end = widget.backgroundColor;
    super.didChangeDependencies();
  }

  Widget _buildChildren(BuildContext context, Widget? child) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTileTheme.merge(
            iconColor: _iconColor.value,
            textColor: _headerColor.value,
            child: ListTile(
              onTap: toggle,
              leading: Icon(Icons.file_copy),
              title: Text("2412412412"),
              trailing: RotationTransition(
                turns: _iconTurns,
                child: const Icon(Icons.expand_more),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;
    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: closed
          ? null
          : Column(
              children: [
              Text("12312"),
              Text("12312"),
              Text("12312"),
              Text("12312"),
              Text("12312"),
            ] as List<Widget>),
    );
  }
}
