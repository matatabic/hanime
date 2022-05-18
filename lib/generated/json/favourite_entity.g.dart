import 'package:hanime/entity/favourite_entity.dart';
import 'package:hanime/generated/json/base/json_convert_content.dart';

FavouriteEntity $FavouriteEntityFromJson(Map<String, dynamic> json) {
  final FavouriteEntity favouriteEntity = FavouriteEntity();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    favouriteEntity.name = name;
  }
  final List<FavouriteChildren>? children =
      jsonConvert.convertListNotNull<FavouriteChildren>(json['children']);
  if (children != null) {
    favouriteEntity.children = children;
  }
  return favouriteEntity;
}

Map<String, dynamic> $FavouriteEntityToJson(FavouriteEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['children'] = entity.children.map((v) => v.toJson()).toList();
  return data;
}

FavouriteChildren $FavouriteChildrenFromJson(Map<String, dynamic> json) {
  final FavouriteChildren favouriteChildren = FavouriteChildren();
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    favouriteChildren.title = title;
  }
  final String? imageUrl = jsonConvert.convert<String>(json['imageUrl']);
  if (imageUrl != null) {
    favouriteChildren.imageUrl = imageUrl;
  }
  final String? htmlUrl = jsonConvert.convert<String>(json['htmlUrl']);
  if (htmlUrl != null) {
    favouriteChildren.htmlUrl = htmlUrl;
  }
  return favouriteChildren;
}

Map<String, dynamic> $FavouriteChildrenToJson(FavouriteChildren entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['title'] = entity.title;
  data['imageUrl'] = entity.imageUrl;
  data['htmlUrl'] = entity.htmlUrl;
  return data;
}
