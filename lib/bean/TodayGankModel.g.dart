// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TodayGankModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodayGankModel _$TodayGankModelFromJson(Map<String, dynamic> json) {
  return TodayGankModel(
      (json['category'] as List)?.map((e) => e as String)?.toList(),
      json['error'] as bool,
      json['results'] == null
          ? null
          : ResultsModel.fromJson(json['results'] as Map<String, dynamic>));
}

Map<String, dynamic> _$TodayGankModelToJson(TodayGankModel instance) =>
    <String, dynamic>{
      'category': instance.category,
      'error': instance.error,
      'results': instance.results
    };
