//part 'IOSModel.g.dart';
import 'package:json_annotation/json_annotation.dart';

part 'IOSModel.g.dart';

@JsonSerializable()
class IOSModel extends Object  {
  String id;
  String createdAt;
  String desc;
  String publishedAt;
  String source;
  String type;
  String url;
  bool used;
  String who;

  IOSModel(this.id, this.createdAt, this.desc, this.publishedAt, this.source,
      this.type, this.url, this.used, this.who);

  factory IOSModel.fromJson(Map<String, dynamic> json) =>
      _$IOSModelFromJson(json);
}
