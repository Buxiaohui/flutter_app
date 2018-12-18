//part 'AndroidModel.g.dart';
import 'package:json_annotation/json_annotation.dart';

part 'AndroidModel.g.dart';

@JsonSerializable()
class AndroidModel extends Object {
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

  AndroidModel(this.id, this.createdAt, this.desc, this.images,
      this.publishedAt, this.source, this.type, this.url, this.used, this.who);

  factory AndroidModel.fromJson(Map<String, dynamic> json) =>
      _$AndroidModelFromJson(json);
}
