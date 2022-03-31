import 'package:hanime/generated/json/base/json_convert_content.dart';
import 'package:hanime/entity/home_entity.dart';

HomeHomeEntity $HomeHomeEntityFromJson(Map<String, dynamic> json) {
	final HomeHomeEntity homeHomeEntity = HomeHomeEntity();
	final String? title = jsonConvert.convert<String>(json['title']);
	if (title != null) {
		homeHomeEntity.title = title;
	}
	final String? imgUrl = jsonConvert.convert<String>(json['imgUrl']);
	if (imgUrl != null) {
		homeHomeEntity.imgUrl = imgUrl;
	}
	final String? htmlUrl = jsonConvert.convert<String>(json['htmlUrl']);
	if (htmlUrl != null) {
		homeHomeEntity.htmlUrl = htmlUrl;
	}
	final bool? latest = jsonConvert.convert<bool>(json['latest']);
	if (latest != null) {
		homeHomeEntity.latest = latest;
	}
	return homeHomeEntity;
}

Map<String, dynamic> $HomeHomeEntityToJson(HomeHomeEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['title'] = entity.title;
	data['imgUrl'] = entity.imgUrl;
	data['htmlUrl'] = entity.htmlUrl;
	data['latest'] = entity.latest;
	return data;
}