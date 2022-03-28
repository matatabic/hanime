import 'dart:convert';

import 'package:hanime/generated/json/base/json_field.dart';
import 'package:hanime/generated/json/translate_entity.g.dart';

@JsonSerializable()
class TranslateEntity {
  late String type;
  late int errorCode;
  late int elapsedTime;
  late List<List> translateResult;

  TranslateEntity();

  factory TranslateEntity.fromJson(Map<String, dynamic> json) =>
      $TranslateEntityFromJson(json);

  Map<String, dynamic> toJson() => $TranslateEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class TranslateTranslateResultTranslateTranslateResult {
  late String src;
  late String tgt;

  TranslateTranslateResultTranslateTranslateResult();

  factory TranslateTranslateResultTranslateTranslateResult.fromJson(
          Map<String, dynamic> json) =>
      $TranslateTranslateResultTranslateTranslateResultFromJson(json);

  Map<String, dynamic> toJson() =>
      $TranslateTranslateResultTranslateTranslateResultToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
