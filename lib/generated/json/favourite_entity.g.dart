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
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    favouriteChildren.name = name;
  }
  final List<FavouriteChildrenChildren>? children = jsonConvert
      .convertListNotNull<FavouriteChildrenChildren>(json['children']);
  if (children != null) {
    favouriteChildren.children = children;
  }
  return favouriteChildren;
}

Map<String, dynamic> $FavouriteChildrenToJson(FavouriteChildren entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['children'] = entity.children.map((v) => v.toJson()).toList();
  return data;
}

FavouriteChildrenChildren $FavouriteChildrenChildrenFromJson(
    Map<String, dynamic> json) {
  final FavouriteChildrenChildren favouriteChildrenChildren =
      FavouriteChildrenChildren();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    favouriteChildrenChildren.id = id;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    favouriteChildrenChildren.title = title;
  }
  final String? htmlUrl = jsonConvert.convert<String>(json['htmlUrl']);
  if (htmlUrl != null) {
    favouriteChildrenChildren.htmlUrl = htmlUrl;
  }
  final String? imgUrl = jsonConvert.convert<String>(json['imgUrl']);
  if (imgUrl != null) {
    favouriteChildrenChildren.imgUrl = imgUrl;
  }
  return favouriteChildrenChildren;
}

Map<String, dynamic> $FavouriteChildrenChildrenToJson(
    FavouriteChildrenChildren entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['title'] = entity.title;
  data['htmlUrl'] = entity.htmlUrl;
  data['imgUrl'] = entity.imgUrl;
  return data;
}
