import 'package:flutter/foundation.dart';

class Anime {
  final String title;
  final String image;
  final String htmlUrl;

  Anime({required this.title, required this.image, required this.htmlUrl});
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
          title: '兔耳冒險譚 4',
          image:
              'https://cdn.jsdelivr.net/gh/tatakanuta/tatakanuta@v1.0.0/asset/cover/W1XDwTL.jpg',
          htmlUrl: 'https://hanime1.me/watch?v=38388',
        )
      ],
    ),
    Favourite(
      name: '我的收藏夹',
      children: [],
    )
  ];

  List<Favourite> get favList => _favList;

  void saveAnime(Anime anime, Favourite favourite) {
    int index = _favList.indexOf(favourite);
    _favList[index].children.insert(0, anime);

    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty('favList', favList));
  }
}
