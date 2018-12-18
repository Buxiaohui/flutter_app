//part 'FreeRecomModel.g.dart';
import 'package:json_annotation/json_annotation.dart';

part 'FreeRecomModel.g.dart';

@JsonSerializable()
class FreeRecomModel extends Object  {
  String id;
  String createdAt;
  String desc;
  List<String> images;
  String publishedAt;
  String source;
  String type;
  String url;
  bool used;
  String who;

  FreeRecomModel(this.id, this.createdAt, this.desc, this.images,
      this.publishedAt, this.source, this.type, this.url, this.used, this.who);

  factory FreeRecomModel.fromJson(Map<String, dynamic> json) =>
      _$FreeRecomModelFromJson(json);
}
