import 'package:hanime/generated/json/base/json_convert_content.dart';

class Anime {
  late String title;
  late String image;
  late String htmlUrl;

  Anime({String? image, String? htmlUrl, String? title});

  // Anime({required this.title, required this.image, required this.htmlUrl});

  factory Anime.fromJson(Map<String, dynamic> json) => $AnimeFromJson(json);

  Map<String, dynamic> toJson() => $AnimeToJson(this);
}

Anime $AnimeFromJson(Map<String, dynamic> json) {
  final Anime anime = Anime();
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    anime.title = title;
  }
  final String? image = jsonConvert.convert<String>(json['image']);
  if (image != null) {
    anime.image = image;
  }
  final String? htmlUrl = jsonConvert.convert<String>(json['htmlUrl']);
  if (htmlUrl != null) {
    anime.image = htmlUrl;
  }

  return anime;
}

class Favourite {
  late String name;
  late List<Anime> children;

  Favourite({List<Anime>? children, String? name});
  // Favourite({required this.name, required this.children});

  factory Favourite.fromJson(Map<String, dynamic> json) =>
      $FavouriteFromJson(json);

  Map<String, dynamic> toJson() => $FavouriteToJson(this);
}

Favourite $FavouriteFromJson(Map<String, dynamic> json) {
  final Favourite favourite = Favourite();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    favourite.name = name;
  }
  final List<Anime>? children =
      jsonConvert.convertListNotNull<Anime>(json['children']);
  if (children != null) {
    favourite.children = children;
  }

  return favourite;
}

Map<String, dynamic> $AnimeToJson(Anime anime) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['title'] = anime.title;
  data['image'] = anime.image;
  data['htmlUrl'] = anime.htmlUrl;
  return data;
}

Map<String, dynamic> $FavouriteToJson(Favourite favourite) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = favourite.name;
  data['children'] = favourite.children.map((v) => v.toJson()).toList();

  return data;
}
