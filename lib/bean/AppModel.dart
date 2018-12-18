//part 'AppModel.g.dart';
import 'package:json_annotation/json_annotation.dart';

part 'AppModel.g.dart';

@JsonSerializable()
class AppModel extends Object {
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

  AppModel(this.id, this.createdAt, this.desc, this.images, this.publishedAt,
      this.source, this.type, this.url, this.used, this.who);

  factory AppModel.fromJson(Map<String, dynamic> json) =>
     _$AppModelFromJson(json);

}
