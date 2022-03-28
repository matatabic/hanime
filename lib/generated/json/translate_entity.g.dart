import 'package:hanime/entity/translate_entity.dart';
import 'package:hanime/generated/json/base/json_convert_content.dart';

TranslateEntity $TranslateEntityFromJson(Map<String, dynamic> json) {
  final TranslateEntity translateEntity = TranslateEntity();
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    translateEntity.type = type;
  }
  final int? errorCode = jsonConvert.convert<int>(json['errorCode']);
  if (errorCode != null) {
    translateEntity.errorCode = errorCode;
  }
  final int? elapsedTime = jsonConvert.convert<int>(json['elapsedTime']);
  if (elapsedTime != null) {
    translateEntity.elapsedTime = elapsedTime;
  }
  final List<List>? translateResult =
      jsonConvert.convertListNotNull<List>(json['translateResult']);
  if (translateResult != null) {
    translateEntity.translateResult = translateResult;
  }
  return translateEntity;
}

Map<String, dynamic> $TranslateEntityToJson(TranslateEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['type'] = entity.type;
  data['errorCode'] = entity.errorCode;
  data['elapsedTime'] = entity.elapsedTime;
  data['translateResult'] = entity.translateResult;
  return data;
}

TranslateTranslateResultTranslateTranslateResult
    $TranslateTranslateResultTranslateTranslateResultFromJson(
        Map<String, dynamic> json) {
  final TranslateTranslateResultTranslateTranslateResult
      translateTranslateResultTranslateTranslateResult =
      TranslateTranslateResultTranslateTranslateResult();
  final String? src = jsonConvert.convert<String>(json['src']);
  if (src != null) {
    translateTranslateResultTranslateTranslateResult.src = src;
  }
  final String? tgt = jsonConvert.convert<String>(json['tgt']);
  if (tgt != null) {
    translateTranslateResultTranslateTranslateResult.tgt = tgt;
  }
  return translateTranslateResultTranslateTranslateResult;
}

Map<String, dynamic> $TranslateTranslateResultTranslateTranslateResultToJson(
    TranslateTranslateResultTranslateTranslateResult entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['src'] = entity.src;
  data['tgt'] = entity.tgt;
  return data;
}
