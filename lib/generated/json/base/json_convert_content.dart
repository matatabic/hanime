// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:hanime/entity/home_entity.dart';
import 'package:hanime/entity/search_entity.dart';
import 'package:hanime/entity/translate_entity.dart';
import 'package:hanime/entity/watch_entity.dart';

JsonConvert jsonConvert = JsonConvert();

class JsonConvert {
  T? convert<T>(dynamic value) {
    if (value == null) {
      return null;
    }
    return asT<T>(value);
  }

  List<T?>? convertList<T>(List<dynamic>? value) {
    if (value == null) {
      return null;
    }
    try {
      return value.map((dynamic e) => asT<T>(e)).toList();
    } catch (e, stackTrace) {
      print('asT<$T> $e $stackTrace');
      return <T>[];
    }
  }

  List<T>? convertListNotNull<T>(dynamic value) {
    if (value == null) {
      return null;
    }
    try {
      return (value as List<dynamic>).map((dynamic e) => asT<T>(e)!).toList();
    } catch (e, stackTrace) {
      print('asT<$T> $e $stackTrace');
      return <T>[];
    }
  }

  T? asT<T extends Object?>(dynamic value) {
    if (value is T) {
      return value;
    }
    final String type = T.toString();
    try {
      final String valueS = value.toString();
      if (type == "String") {
        return valueS as T;
      } else if (type == "int") {
        final int? intValue = int.tryParse(valueS);
        if (intValue == null) {
          return double.tryParse(valueS)?.toInt() as T?;
        } else {
          return intValue as T;
        }
      } else if (type == "double") {
        return double.parse(valueS) as T;
      } else if (type == "DateTime") {
        return DateTime.parse(valueS) as T;
      } else if (type == "bool") {
        if (valueS == '0' || valueS == '1') {
          return (valueS == '1') as T;
        }
        return (valueS == 'true') as T;
      } else {
        return JsonConvert.fromJsonAsT<T>(value);
      }
    } catch (e, stackTrace) {
      print('asT<$T> $e $stackTrace');
      return null;
    }
  }

  //Go back to a single instance by type
  static M? _fromJsonSingle<M>(Map<String, dynamic> json) {
    final String type = M.toString();
    if (type == (HomeEntity).toString()) {
      return HomeEntity.fromJson(json) as M;
    }
    if (type == (HomeSwiper).toString()) {
      return HomeSwiper.fromJson(json) as M;
    }
    if (type == (HomeVideo).toString()) {
      return HomeVideo.fromJson(json) as M;
    }
    if (type == (HomeVideoData).toString()) {
      return HomeVideoData.fromJson(json) as M;
    }
    if (type == (SearchEntity).toString()) {
      return SearchEntity.fromJson(json) as M;
    }
    if (type == (SearchGenre).toString()) {
      return SearchGenre.fromJson(json) as M;
    }
    if (type == (SearchTag).toString()) {
      return SearchTag.fromJson(json) as M;
    }
    if (type == (SearchTagData).toString()) {
      return SearchTagData.fromJson(json) as M;
    }
    if (type == (SearchBrand).toString()) {
      return SearchBrand.fromJson(json) as M;
    }
    if (type == (SearchSort).toString()) {
      return SearchSort.fromJson(json) as M;
    }
    if (type == (SearchDate).toString()) {
      return SearchDate.fromJson(json) as M;
    }
    if (type == (SearchDateData).toString()) {
      return SearchDateData.fromJson(json) as M;
    }
    if (type == (SearchDuration).toString()) {
      return SearchDuration.fromJson(json) as M;
    }
    if (type == (SearchVideo).toString()) {
      return SearchVideo.fromJson(json) as M;
    }
    if (type == (TranslateEntity).toString()) {
      return TranslateEntity.fromJson(json) as M;
    }
    if (type == (TranslateTranslateResultTranslateTranslateResult).toString()) {
      return TranslateTranslateResultTranslateTranslateResult.fromJson(json)
          as M;
    }
    if (type == (WatchEntity).toString()) {
      return WatchEntity.fromJson(json) as M;
    }
    if (type == (WatchInfo).toString()) {
      return WatchInfo.fromJson(json) as M;
    }
    if (type == (WatchVideoData).toString()) {
      return WatchVideoData.fromJson(json) as M;
    }
    if (type == (WatchVideoDataVideo).toString()) {
      return WatchVideoDataVideo.fromJson(json) as M;
    }
    if (type == (WatchVideoDataVideoList).toString()) {
      return WatchVideoDataVideoList.fromJson(json) as M;
    }
    if (type == (WatchEpisode).toString()) {
      return WatchEpisode.fromJson(json) as M;
    }
    if (type == (WatchTag).toString()) {
      return WatchTag.fromJson(json) as M;
    }
    if (type == (WatchCommend).toString()) {
      return WatchCommend.fromJson(json) as M;
    }

    print("$type not found");

    return null;
  }

  //list is returned by type
  static M? _getListChildType<M>(List<Map<String, dynamic>> data) {
    if (<HomeEntity>[] is M) {
      return data
          .map<HomeEntity>((Map<String, dynamic> e) => HomeEntity.fromJson(e))
          .toList() as M;
    }
    if (<HomeSwiper>[] is M) {
      return data
          .map<HomeSwiper>((Map<String, dynamic> e) => HomeSwiper.fromJson(e))
          .toList() as M;
    }
    if (<HomeVideo>[] is M) {
      return data
          .map<HomeVideo>((Map<String, dynamic> e) => HomeVideo.fromJson(e))
          .toList() as M;
    }
    if (<HomeVideoData>[] is M) {
      return data
          .map<HomeVideoData>(
              (Map<String, dynamic> e) => HomeVideoData.fromJson(e))
          .toList() as M;
    }
    if (<SearchEntity>[] is M) {
      return data
          .map<SearchEntity>(
              (Map<String, dynamic> e) => SearchEntity.fromJson(e))
          .toList() as M;
    }
    if (<SearchGenre>[] is M) {
      return data
          .map<SearchGenre>((Map<String, dynamic> e) => SearchGenre.fromJson(e))
          .toList() as M;
    }
    if (<SearchTag>[] is M) {
      return data
          .map<SearchTag>((Map<String, dynamic> e) => SearchTag.fromJson(e))
          .toList() as M;
    }
    if (<SearchTagData>[] is M) {
      return data
          .map<SearchTagData>(
              (Map<String, dynamic> e) => SearchTagData.fromJson(e))
          .toList() as M;
    }
    if (<SearchBrand>[] is M) {
      return data
          .map<SearchBrand>((Map<String, dynamic> e) => SearchBrand.fromJson(e))
          .toList() as M;
    }
    if (<SearchSort>[] is M) {
      return data
          .map<SearchSort>((Map<String, dynamic> e) => SearchSort.fromJson(e))
          .toList() as M;
    }
    if (<SearchDate>[] is M) {
      return data
          .map<SearchDate>((Map<String, dynamic> e) => SearchDate.fromJson(e))
          .toList() as M;
    }
    if (<SearchDateData>[] is M) {
      return data
          .map<SearchDateData>(
              (Map<String, dynamic> e) => SearchDateData.fromJson(e))
          .toList() as M;
    }
    if (<SearchDuration>[] is M) {
      return data
          .map<SearchDuration>(
              (Map<String, dynamic> e) => SearchDuration.fromJson(e))
          .toList() as M;
    }
    if (<SearchVideo>[] is M) {
      return data
          .map<SearchVideo>((Map<String, dynamic> e) => SearchVideo.fromJson(e))
          .toList() as M;
    }
    if (<TranslateEntity>[] is M) {
      return data
          .map<TranslateEntity>(
              (Map<String, dynamic> e) => TranslateEntity.fromJson(e))
          .toList() as M;
    }
    if (<TranslateTranslateResultTranslateTranslateResult>[] is M) {
      return data
          .map<TranslateTranslateResultTranslateTranslateResult>(
              (Map<String, dynamic> e) =>
                  TranslateTranslateResultTranslateTranslateResult.fromJson(e))
          .toList() as M;
    }
    if (<WatchEntity>[] is M) {
      return data
          .map<WatchEntity>((Map<String, dynamic> e) => WatchEntity.fromJson(e))
          .toList() as M;
    }
    if (<WatchInfo>[] is M) {
      return data
          .map<WatchInfo>((Map<String, dynamic> e) => WatchInfo.fromJson(e))
          .toList() as M;
    }
    if (<WatchVideoData>[] is M) {
      return data
          .map<WatchVideoData>(
              (Map<String, dynamic> e) => WatchVideoData.fromJson(e))
          .toList() as M;
    }
    if (<WatchVideoDataVideo>[] is M) {
      return data
          .map<WatchVideoDataVideo>(
              (Map<String, dynamic> e) => WatchVideoDataVideo.fromJson(e))
          .toList() as M;
    }
    if (<WatchVideoDataVideoList>[] is M) {
      return data
          .map<WatchVideoDataVideoList>(
              (Map<String, dynamic> e) => WatchVideoDataVideoList.fromJson(e))
          .toList() as M;
    }
    if (<WatchEpisode>[] is M) {
      return data
          .map<WatchEpisode>(
              (Map<String, dynamic> e) => WatchEpisode.fromJson(e))
          .toList() as M;
    }
    if (<WatchTag>[] is M) {
      return data
          .map<WatchTag>((Map<String, dynamic> e) => WatchTag.fromJson(e))
          .toList() as M;
    }
    if (<WatchCommend>[] is M) {
      return data
          .map<WatchCommend>(
              (Map<String, dynamic> e) => WatchCommend.fromJson(e))
          .toList() as M;
    }

    print("${M.toString()} not found");

    return null;
  }

  static M? fromJsonAsT<M>(dynamic json) {
    if (json == null) {
      return null;
    }
    if (json is List) {
      return _getListChildType<M>(
          json.map((e) => e as Map<String, dynamic>).toList());
    } else {
      return _fromJsonSingle<M>(json as Map<String, dynamic>);
    }
  }
}
