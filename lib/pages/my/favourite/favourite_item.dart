import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hanime/common/expansionLayout.dart';
import 'package:hanime/common/hero_widget/hero_photo_view.dart';
import 'package:hanime/common/modal_bottom_route.dart';
import 'package:hanime/common/widget/common_image.dart';
import 'package:hanime/entity/favourite_entity.dart';

const Duration _kExpand = Duration(milliseconds: 200);

class Favourite extends StatefulWidget {
  final FavouriteChildren episodeList;
  final bool showBg;
  final String heroTag = UniqueKey().toString();

  Favourite({Key? key, required this.episodeList, this.showBg = true})
      : super(key: key);

  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite>
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

  late AnimationController _controller;
  late Animation<double> _iconTurns;
  late Animation<Color?> _iconColor;
  late Animation<Color?> _headerColor;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _kExpand, vsync: this);
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));
    _iconColor = _controller.drive(_iconColorTween.chain(_easeInTween));
    _headerColor = _controller.drive(_headerColorTween.chain(_easeInTween));

    if (_isExpanded) _controller.value = 1.0;
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
    // setState(() {
    //   _isExpanded = expanded;
    // });
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
      });
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
    return Slidable(
      key: ValueKey(widget.episodeList.name),
      startActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (BuildContext context) {
              // CustomDialog.showDialog(context, "确认删除该影片?", () {
              //   widgetContext.read<FavouriteModel>().removeItem(episodeList);
              // });
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: '删除',
          )
        ],
      ),
      child: Container(
        child: ListTileTheme.merge(
          iconColor: _iconColor.value,
          textColor: _headerColor.value,
          child: ListTile(
            onTap: toggle,
            leading: Icon(Icons.file_copy),
            title: Text(widget.episodeList.name),
            trailing: RotationTransition(
              turns: _iconTurns,
              child: const Icon(Icons.expand_more),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItem(FavouriteChildrenChildren item) {
    return Slidable(
      key: ValueKey(item.htmlUrl),
      startActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (BuildContext context) {
              // CustomDialog.showDialog(context, "确认删除该影片?", () {
              //   widgetContext.read<FavouriteModel>().removeItem(episodeList);
              // });
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: '删除',
          )
        ],
      ),
      child: FavouriteItem(
        anime: item,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedBuilder(animation: _controller.view, builder: _buildChildren),
        ExpansionLayout(
            onExpansionChanged: (bool value) {
              print(value);
              // setState(() {
              //   isExpanded = !isExpanded;
              // });
            },
            backgroundColor: Colors.white,
            trailing: Icon(Icons.remove_red_eye_outlined),
            isExpanded: _isExpanded,
            children:
                widget.episodeList.children.map((e) => _buildItem(e)).toList())
      ],
    );
  }
}

class FavouriteItem extends StatelessWidget {
  final FavouriteChildrenChildren anime;
  final bool showBg;
  final String heroTag = UniqueKey().toString();

  FavouriteItem({Key? key, required this.anime, this.showBg = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        color: showBg ? Color.fromRGBO(58, 60, 63, 1) : Colors.transparent,
        height: 110,
        child: Row(
          children: [
            InkWell(
              onLongPress: () {
                Navigator.of(context).push(NoAnimRouter(
                  HeroPhotoView(
                    heroTag: heroTag,
                    maxScale: 1.5,
                    imageProvider: NetworkImage(anime.imgUrl),
                  ),
                ));
              },
              child: Hero(
                  tag: heroTag,
                  child: ClipOval(
                    child: Container(
                      width: 70,
                      height: 70,
                      child: CommonNormalImage(
                        imgUrl: anime.imgUrl,
                      ),
                    ),
                  )),
            ),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(anime.title,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white))),
            ),
          ],
        ));
  }
}
