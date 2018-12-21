//part 'IOSModel.g.dart';
import 'package:json_annotation/json_annotation.dart';

part 'IOSModel.g.dart';

@JsonSerializable()
class IOSModel extends Object {
  String id;
  String createdAt;
  String desc;
  String publishedAt;
  String source;
  String type;
  List<String> images;
  String url;
  bool used;
  String who;

  IOSModel(this.id, this.createdAt, this.desc, this.images, this.publishedAt,
      this.source, this.type, this.url, this.used, this.who);

  @override
  String toString() {
    return 'IOSModel{id: $id, createdAt: $createdAt, desc: $desc, publishedAt: $publishedAt, source: $source, type: $type, images: $images, url: $url, used: $used, who: $who}';
  }

  factory IOSModel.fromJson(Map<String, dynamic> json) =>
      _$IOSModelFromJson(json);
}
