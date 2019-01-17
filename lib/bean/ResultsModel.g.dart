// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResultsModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultsModel _$ResultsModelFromJson(Map<String, dynamic> json) {
  return ResultsModel(
      (json['Android'] as List)
          ?.map((e) => e == null
              ? null
              : BaseItemModel.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['前端'] as List)
          ?.map((e) => e == null
              ? null
              : BaseItemModel.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['App'] as List)
          ?.map((e) => e == null
              ? null
              : BaseItemModel.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['iOS'] as List)
          ?.map((e) => e == null
              ? null
              : BaseItemModel.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['休息视频'] as List)
          ?.map((e) => e == null
              ? null
              : BaseItemModel.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['拓展资源'] as List)
          ?.map((e) => e == null
              ? null
              : BaseItemModel.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['瞎推荐'] as List)
          ?.map((e) => e == null
              ? null
              : BaseItemModel.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['福利'] as List)
          ?.map((e) => e == null
              ? null
              : BaseItemModel.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$ResultsModelToJson(ResultsModel instance) =>
    <String, dynamic>{
      'Android': instance.Android,
      'App': instance.App,
      'iOS': instance.iOS,
      'mRelaxVideoModels': instance.mRelaxVideoModels,
      'mStretchResModels': instance.mStretchResModels,
      'mFreeRecomModels': instance.mFreeRecomModels,
      'mBenifitModels': instance.mBenifitModels
    };
