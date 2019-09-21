// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResultsMode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultsMode _$ResultsModeFromJson(Map<String, dynamic> json) {
  return ResultsMode(
      (json['Android'] as List)
          .map((e) => BaseItemMode.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['front'] as List)
          .map((e) => BaseItemMode.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['App'] as List)
          .map((e) => BaseItemMode.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['iOS'] as List)
          .map((e) => BaseItemMode.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['mRelaxVideoModels'] as List)
          .map((e) => BaseItemMode.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['mStretchResModels'] as List)
          .map((e) => BaseItemMode.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['mFreeRecomModels'] as List)
          .map((e) => BaseItemMode.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['mBenifitModels'] as List)
          .map((e) => BaseItemMode.fromJson(e as Map<String, dynamic>))
          .toList());
}

Map<String, dynamic> _$ResultsModeToJson(ResultsMode instance) =>
    <String, dynamic>{
      'App': instance.App,
      'front': instance.front,
      'Android': instance.Android,
      'iOS': instance.iOS,
      'mRelaxVideoModels': instance.mRelaxVideoModels,
      'mStretchResModels': instance.mStretchResModels,
      'mFreeRecomModels': instance.mFreeRecomModels,
      'mBenifitModels': instance.mBenifitModels
    };
