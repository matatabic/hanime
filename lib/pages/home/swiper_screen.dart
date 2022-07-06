import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/common/common_image.dart';
import 'package:hanime/entity/home_entity.dart';
import 'package:hanime/providers/home_model.dart';
import 'package:provider/src/provider.dart';

class SwiperScreen extends StatelessWidget {
  final List<HomeSwiper> swiperList;
  final Function(HomeSwiper swiper) onTap;
  const SwiperScreen({Key? key, required this.swiperList, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Adapt.px(400),
      child: Swiper(
        autoplay: false,
        onTap: (int index) {
          onTap(swiperList[index]);
        },
        itemBuilder: (BuildContext context, int index) {
          return CommonImages(
            imgUrl: swiperList[index].imgUrl,
          );
        },
        onIndexChanged: (int index) {
          context.read<HomeModel>().setIndex(index);
        },
        itemCount: swiperList.length,
        viewportFraction: 0.9,
        scale: 0.9,
        pagination: SwiperPagination(
            margin: EdgeInsets.zero,
            builder: SwiperCustomPagination(builder: (context, config) {
              return ConstrainedBox(
                child: Container(
                    color: Color.fromRGBO(0, 0, 0, .5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${config.activeIndex + 1}/${config.itemCount}',
                          style: TextStyle(fontSize: Adapt.px(30)),
                        ),
                        Text(
                          '${swiperList[config.activeIndex].title}',
                          style: TextStyle(fontSize: Adapt.px(32)),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    )),
                constraints: BoxConstraints.expand(height: Adapt.px(90)),
              );
            })),
      ),
    );
  }
}
