import 'package:flutter/foundation.dart';

class Anime {
  final int id;
  final String title;
  final String image;
  final String htmlUrl;

  Anime(
      {required this.id,
      required this.title,
      required this.image,
      required this.htmlUrl});
}

class Favourite {
  final String name;
  final List<Anime> children;

  Favourite({required this.name, required this.children});
}

class FavouriteState with ChangeNotifier, DiagnosticableTreeMixin {
  List<Favourite> _favList = [
    Favourite(
      name: '默认收藏夹',
      children: [
        Anime(
          title: '我的收藏夹title1',
          image: '我的收藏夹image1',
          htmlUrl: '我的收藏夹htmlUrl1',
          id: 1,
        ),
        Anime(
          title: '我的收藏夹title2',
          image: '我的收藏夹image2',
          htmlUrl: '我的收藏夹htmlUrl2',
          id: 2,
        )
      ],
    ),
    Favourite(
      name: '我的收藏夹',
      children: [
        Anime(
          title: '我的收藏夹title3',
          image: '我的收藏夹image3',
          htmlUrl: '我的收藏夹htmlUrl3',
          id: 3,
        ),
        Anime(
          title: '我的收藏夹title4',
          image: '我的收藏夹image4',
          htmlUrl: '我的收藏夹htmlUrl4',
          id: 4,
        )
      ],
    )
  ];

  List<Favourite> get favList => _favList;

  void setFavList(int index) {
    // _favList = [];
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty('favList', favList));
  }
}
