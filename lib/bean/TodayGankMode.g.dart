// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TodayGankMode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodayGankMode _$TodayGankModeFromJson(Map<String, dynamic> json) {
  return TodayGankMode(
      (json['category'] as List).map((e) => e as String).toList(),
      json['error'] as bool,
      ResultsMode.fromJson(json['results'] as Map<String, dynamic>));
}

Map<String, dynamic> _$TodayGankModeToJson(TodayGankMode instance) =>
    <String, dynamic>{
      'category': instance.category,
      'error': instance.error,
      'results': instance.results
    };
