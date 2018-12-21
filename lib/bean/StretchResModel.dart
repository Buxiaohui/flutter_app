import 'package:json_annotation/json_annotation.dart';

part 'StretchResModel.g.dart';

@JsonSerializable()
class StretchResModel extends Object {
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

  StretchResModel(this.id, this.createdAt, this.desc, this.images,
      this.publishedAt, this.source, this.type, this.url, this.used, this.who);

  @override
  String toString() {
    return 'RelaxVideoModel{id: $id, createdAt: $createdAt, desc: $desc, images: $images, publishedAt: $publishedAt, source: $source, type: $type, url: $url, used: $used, who: $who}';
  }

  factory StretchResModel.fromJson(Map<String, dynamic> json) =>
      _$StretchResModelFromJson(json);
}
