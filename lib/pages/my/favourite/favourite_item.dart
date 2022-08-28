import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/common_image.dart';
import 'package:hanime/common/hero_photo_view.dart';
import 'package:hanime/common/modal_bottom_route.dart';
import 'package:hanime/entity/favourite_entity.dart';

class FavouriteItem extends StatelessWidget {
  final FavouriteChildren anime;
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
                    imageProvider: NetworkImage(anime.imageUrl),
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
                        imgUrl: anime.imageUrl,
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
