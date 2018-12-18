// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RelaxVideoModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RelaxVideoModel _$RelaxVideoModelFromJson(Map<String, dynamic> json) {
  return RelaxVideoModel(
      json['_id'] as String,
      json['createdAt'] as String,
      json['desc'] as String,
      json['publishedAt'] as String,
      json['source'] as String,
      json['type'] as String,
      json['url'] as String,
      json['used'] as bool,
      json['who'] as String);
}

Map<String, dynamic> _$RelaxVideoModelToJson(RelaxVideoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'desc': instance.desc,
      'publishedAt': instance.publishedAt,
      'source': instance.source,
      'type': instance.type,
      'url': instance.url,
      'used': instance.used,
      'who': instance.who
    };
