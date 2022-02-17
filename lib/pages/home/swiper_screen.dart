import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:hanime/providers/home_state.dart';
import 'package:provider/src/provider.dart';

class SwiperData {
  final String image_url;
  SwiperData(this.image_url);
}

class SwiperScreen extends StatelessWidget {
  final List swiperList;
  const SwiperScreen({Key? key, required this.swiperList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (swiperList.length == 0) {
      return Container();
    }
    return Container(
      height: 200,
      child: Swiper(
        autoplay: false,
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            // swiperList[index]['imgUrl'],
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.jj20.com%2Fup%2Fallimg%2Ftp08%2F01042323313046.jpg&refer=http%3A%2F%2Fimg.jj20.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1647567926&t=5801838b202ca2811218d58da4f586bf",
            fit: BoxFit.cover,
          );
        },
        onIndexChanged: (int index) {
          context.read<HomeState>().setIndex(index);
        },
        itemCount: swiperList.length,
        viewportFraction: 0.8,
        scale: 0.8,
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
                          style: const TextStyle(fontSize: 15.0),
                        ),
                        Text(
                          '${swiperList[config.activeIndex]['title']}',
                          style: const TextStyle(fontSize: 16.0),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    )),
                constraints: const BoxConstraints.expand(height: 50.0),
              );
            })),
        // control: SwiperControl(),
      ),
    );
  }
}
