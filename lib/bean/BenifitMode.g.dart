// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BenifitMode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BenifitMode _$BenifitModeFromJson(Map<String, dynamic> json) {
  return BenifitMode(json['id'] as String, json['url'] as String,
      json['publishedAt'] as String)
    ..createdAt = json['createdAt'] as String
    ..desc = json['desc'] as String
    ..source = json['source'] as String
    ..type = json['type'] as String
    ..used = json['used'] as bool
    ..who = json['who'] as String
    ..select = json['select'] as bool;
}

Map<String, dynamic> _$BenifitModeToJson(BenifitMode instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'desc': instance.desc,
      'publishedAt': instance.publishedAt,
      'source': instance.source,
      'type': instance.type,
      'url': instance.url,
      'used': instance.used,
      'who': instance.who,
      'select': instance.select
    };
