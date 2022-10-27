import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hanime/common/custom_dialog.dart';
import 'package:hanime/common/expansionLayout.dart';
import 'package:hanime/common/hero_widget/hero_photo_view.dart';
import 'package:hanime/common/modal_bottom_route.dart';
import 'package:hanime/common/widget/common_image.dart';
import 'package:hanime/entity/favourite_entity.dart';
import 'package:hanime/pages/watch/watch_screen.dart';
import 'package:hanime/providers/favourite_model.dart';
import 'package:provider/src/provider.dart';

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

  bool _isDelete = false;
  final ColorTween _borderColorTween = ColorTween();
  final ColorTween _headerColorTween = ColorTween();
  final ColorTween _iconColorTween = ColorTween();

  late AnimationController _controller;
  late Animation<double> _iconTurns;
  late Animation<Color?> _iconColor;
  late Animation<Color?> _headerColor;

  bool _isExpanded = false;
  late FavouriteChildren _episodeList;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _kExpand, vsync: this);
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));
    _iconColor = _controller.drive(_iconColorTween.chain(_easeInTween));
    _headerColor = _controller.drive(_headerColorTween.chain(_easeInTween));
    _episodeList = widget.episodeList;
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
    final widgetContext = context;

    return Slidable(
      key: ValueKey(_episodeList.name),
      startActionPane: ActionPane(
        motion: ScrollMotion(),
        extentRatio: 0.25,
        children: [
          SlidableAction(
            onPressed: (BuildContext context) {
              CustomDialog.showDialog(context, "确认删除该剧集?", () {
                setState(() {
                  _isDelete = true;
                });
                widgetContext
                    .read<FavouriteModel>()
                    .removeEpisode(_episodeList.name);
              });
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: '删除',
          )
        ],
      ),
      child: _isDelete
          ? Container()
          : ListTileTheme.merge(
              iconColor: _iconColor.value,
              textColor: _headerColor.value,
              child: ListTile(
                onTap: toggle,
                leading: Icon(Icons.file_copy),
                title: Text(_episodeList.name),
                trailing: RotationTransition(
                  turns: _iconTurns,
                  child: const Icon(Icons.expand_more),
                ),
              ),
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
            children: _episodeList.children
                .map((anime) => FavouriteWrapper(
                      episodeList: _episodeList,
                      anime: anime,
                    ))
                .toList())
      ],
    );
  }
}

class FavouriteWrapper extends StatefulWidget {
  final FavouriteChildrenChildren anime;
  final FavouriteChildren episodeList;

  const FavouriteWrapper(
      {Key? key, required this.anime, required this.episodeList})
      : super(key: key);

  @override
  State<FavouriteWrapper> createState() => _FavouriteWrapperState();
}

class _FavouriteWrapperState extends State<FavouriteWrapper> {
  bool _isDelete = false;

  @override
  Widget build(BuildContext context) {
    final widgetContext = context;

    return Slidable(
      key: ValueKey(widget.anime.htmlUrl),
      startActionPane: ActionPane(
        motion: ScrollMotion(),
        extentRatio: 0.25,
        children: [
          SlidableAction(
            onPressed: (BuildContext context) {
              CustomDialog.showDialog(context, "确认删除该影片?", () {
                setState(() {
                  _isDelete = true;
                });
                widget.episodeList.children.remove(widget.anime);
                widgetContext
                    .read<FavouriteModel>()
                    .removeAnime(widget.anime.htmlUrl);
              });
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: '删除',
          )
        ],
      ),
      child: _isDelete
          ? Container()
          : FavouriteItem(
              item: widget.anime,
            ),
    );
  }
}

class FavouriteItem extends StatelessWidget {
  final FavouriteChildrenChildren item;
  final bool showBg;
  final String heroTag = UniqueKey().toString();

  FavouriteItem({Key? key, required this.item, this.showBg = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => WatchScreen(htmlUrl: item.htmlUrl)));
      },
      child: Container(
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
                      imageProvider: NetworkImage(item.imgUrl),
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
                          imgUrl: item.imgUrl,
                        ),
                      ),
                    )),
              ),
              Expanded(
                child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(item.title,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white))),
              ),
            ],
          )),
    );
  }
}
