// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RelaxVideoModels.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************


RelaxVideoModels _$RelaxVideoModelsFromJson(Map<String, dynamic> json) {
  return RelaxVideoModels(
      json['count'] as int,
      json['error'] as bool,
      (json['results'] as List)
      ?.map((e) => e == null
      ? null
      : BaseItemModel.fromJson(e as Map<String, dynamic>))
      ?.toList());
}

Map<String, dynamic> _$RelaxVideoModelsToJson(RelaxVideoModels instance) =>
    <String, dynamic>{
      'count': instance.count,
      'error': instance.error,
      'results': instance.results
    };
