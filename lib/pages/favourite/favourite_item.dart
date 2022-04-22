import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/common/common_image.dart';
import 'package:hanime/common/hero_photo.dart';
import 'package:hanime/common/modal_bottom_route.dart';
import 'package:hanime/providers/favourite_state.dart';

class FavouriteItem extends StatelessWidget {
  final Anime anime;
  final bool showBg;
  final String randomTag = UniqueKey().toString();

  FavouriteItem({Key? key, required this.anime, this.showBg = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        color: showBg ? Color.fromRGBO(58, 60, 63, 1) : Colors.transparent,
        height: Adapt.px(220),
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(NoAnimRouter(
                  HeroPhotoViewRouteWrapper(
                    randomNum: randomTag,
                    minScale: 1.0,
                    maxScale: 1.8,
                    imageProvider: NetworkImage(anime.image),
                  ),
                ));
              },
              child: Hero(
                  tag: "heroTag$randomTag",
                  child: ClipOval(
                    child: Container(
                      width: Adapt.px(140),
                      height: Adapt.px(140),
                      child: CommonImages(
                        imgUrl: anime.image,
                      ),
                    ),
                  )),
            ),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.only(left: Adapt.px(20)),
                  child: Text(anime.title,
                      style: TextStyle(
                          fontSize: Adapt.px(30),
                          fontWeight: FontWeight.bold,
                          color: Colors.white))),
            ),
          ],
        ));
  }
}
