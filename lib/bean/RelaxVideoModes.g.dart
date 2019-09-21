// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RelaxVideoModes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RelaxVideoModes _$RelaxVideoModesFromJson(Map<String, dynamic> json) {
  return RelaxVideoModes(
      json['count'] as int,
      json['error'] as bool,
      (json['results'] as List)
          .map((e) => BaseItemMode.fromJson(e as Map<String, dynamic>))
          .toList());
}

Map<String, dynamic> _$RelaxVideoModesToJson(RelaxVideoModes instance) =>
    <String, dynamic>{
      'count': instance.count,
      'error': instance.error,
      'results': instance.results
    };
