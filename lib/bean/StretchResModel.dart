import 'package:json_annotation/json_annotation.dart';

part 'StretchResModel.g.dart';

@JsonSerializable()
class StretchResModel extends Object  {
  String id;
  String createdAt;
  String desc;
  String publishedAt;
  String source;
  String type;
  String url;
  bool used;
  String who;

  StretchResModel(this.id, this.createdAt, this.desc, this.publishedAt,
      this.source, this.type, this.url, this.used, this.who);

  factory StretchResModel.fromJson(Map<String, dynamic> json) =>
      _$StretchResModelFromJson(json);
}
