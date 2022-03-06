import 'package:hanime/generated/json/base/json_convert_content.dart';
import 'package:hanime/entity/search_entity.dart';

SearchEntity $SearchEntityFromJson(Map<String, dynamic> json) {
	final SearchEntity searchEntity = SearchEntity();
	final SearchGenre? genre = jsonConvert.convert<SearchGenre>(json['genre']);
	if (genre != null) {
		searchEntity.genre = genre;
	}
	final List<SearchTag>? tag = jsonConvert.convertListNotNull<SearchTag>(json['tag']);
	if (tag != null) {
		searchEntity.tag = tag;
	}
	final SearchBrand? brand = jsonConvert.convert<SearchBrand>(json['brand']);
	if (brand != null) {
		searchEntity.brand = brand;
	}
	final SearchDate? date = jsonConvert.convert<SearchDate>(json['date']);
	if (date != null) {
		searchEntity.date = date;
	}
	final List<String>? duration = jsonConvert.convertListNotNull<String>(json['duration']);
	if (duration != null) {
		searchEntity.duration = duration;
	}
	final List<SearchVideo>? video = jsonConvert.convertListNotNull<SearchVideo>(json['video']);
	if (video != null) {
		searchEntity.video = video;
	}
	return searchEntity;
}

Map<String, dynamic> $SearchEntityToJson(SearchEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['genre'] = entity.genre.toJson();
	data['tag'] =  entity.tag.map((v) => v.toJson()).toList();
	data['brand'] = entity.brand.toJson();
	data['date'] = entity.date.toJson();
	data['duration'] =  entity.duration;
	data['video'] =  entity.video.map((v) => v.toJson()).toList();
	return data;
}

SearchGenre $SearchGenreFromJson(Map<String, dynamic> json) {
	final SearchGenre searchGenre = SearchGenre();
	final String? label = jsonConvert.convert<String>(json['label']);
	if (label != null) {
		searchGenre.label = label;
	}
	final List<String>? data = jsonConvert.convertListNotNull<String>(json['data']);
	if (data != null) {
		searchGenre.data = data;
	}
	return searchGenre;
}

Map<String, dynamic> $SearchGenreToJson(SearchGenre entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['label'] = entity.label;
	data['data'] =  entity.data;
	return data;
}

SearchTag $SearchTagFromJson(Map<String, dynamic> json) {
	final SearchTag searchTag = SearchTag();
	final String? label = jsonConvert.convert<String>(json['label']);
	if (label != null) {
		searchTag.label = label;
	}
	final List<String>? data = jsonConvert.convertListNotNull<String>(json['data']);
	if (data != null) {
		searchTag.data = data;
	}
	return searchTag;
}

Map<String, dynamic> $SearchTagToJson(SearchTag entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['label'] = entity.label;
	data['data'] =  entity.data;
	return data;
}

SearchBrand $SearchBrandFromJson(Map<String, dynamic> json) {
	final SearchBrand searchBrand = SearchBrand();
	final String? label = jsonConvert.convert<String>(json['label']);
	if (label != null) {
		searchBrand.label = label;
	}
	final List<String>? data = jsonConvert.convertListNotNull<String>(json['data']);
	if (data != null) {
		searchBrand.data = data;
	}
	return searchBrand;
}

Map<String, dynamic> $SearchBrandToJson(SearchBrand entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['label'] = entity.label;
	data['data'] =  entity.data;
	return data;
}

SearchDate $SearchDateFromJson(Map<String, dynamic> json) {
	final SearchDate searchDate = SearchDate();
	final List<String>? year = jsonConvert.convertListNotNull<String>(json['year']);
	if (year != null) {
		searchDate.year = year;
	}
	final List<String>? month = jsonConvert.convertListNotNull<String>(json['month']);
	if (month != null) {
		searchDate.month = month;
	}
	return searchDate;
}

Map<String, dynamic> $SearchDateToJson(SearchDate entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['year'] =  entity.year;
	data['month'] =  entity.month;
	return data;
}

SearchVideo $SearchVideoFromJson(Map<String, dynamic> json) {
	final SearchVideo searchVideo = SearchVideo();
	final String? title = jsonConvert.convert<String>(json['title']);
	if (title != null) {
		searchVideo.title = title;
	}
	final String? imgUrl = jsonConvert.convert<String>(json['imgUrl']);
	if (imgUrl != null) {
		searchVideo.imgUrl = imgUrl;
	}
	final String? htmlUrl = jsonConvert.convert<String>(json['htmlUrl']);
	if (htmlUrl != null) {
		searchVideo.htmlUrl = htmlUrl;
	}
	final String? author = jsonConvert.convert<String>(json['author']);
	if (author != null) {
		searchVideo.author = author;
	}
	return searchVideo;
}

Map<String, dynamic> $SearchVideoToJson(SearchVideo entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['title'] = entity.title;
	data['imgUrl'] = entity.imgUrl;
	data['htmlUrl'] = entity.htmlUrl;
	data['author'] = entity.author;
	return data;
}