//part 'BenifitModel.g.dart';
import 'package:json_annotation/json_annotation.dart';

part 'BenifitModel.g.dart';

@JsonSerializable()
class BenifitModel extends Object {
  String id;
  String createdAt;
  String desc;
  String publishedAt;
  String source;
  String type;
  String url;
  bool used;
  String who;

  BenifitModel(this.id, this.createdAt, this.desc, this.publishedAt,
      this.source, this.type, this.url, this.used, this.who);

  factory BenifitModel.fromJson(Map<String, dynamic> json) =>
     _$BenifitModelFromJson(json);
}
