import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:hanime/common/adapt.dart';
import 'package:hanime/common/common_image.dart';
import 'package:hanime/entity/home_entity.dart';
import 'package:hanime/providers/home_state.dart';
import 'package:provider/src/provider.dart';

class SwiperScreen extends StatelessWidget {
  final List<HomeSwiper> swiperList;
  const SwiperScreen({Key? key, required this.swiperList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Adapt.px(400),
      child: Swiper(
        autoplay: false,
        itemBuilder: (BuildContext context, int index) {
          return CommonImages(
              imgUrl:
                  // swiperList[index].imgUrl,
                  'http://img5.mtime.cn/mt/2022/01/19/102417.23221502_1280X720X2.jpg');
        },
        onIndexChanged: (int index) {
          context.read<HomeState>().setIndex(index);
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
