//part 'RelaxVideoModel.g.dart';
import 'package:json_annotation/json_annotation.dart';

part 'RelaxVideoModel.g.dart';

@JsonSerializable()
class RelaxVideoModel extends Object {
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

  RelaxVideoModel(this.id, this.createdAt, this.desc, this.images,
      this.publishedAt, this.source, this.type, this.url, this.used, this.who);

  @override
  String toString() {
    return 'RelaxVideoModel{id: $id, createdAt: $createdAt, desc: $desc, images: $images, publishedAt: $publishedAt, source: $source, type: $type, url: $url, used: $used, who: $who}';
  }

  factory RelaxVideoModel.fromJson(Map<String, dynamic> json) =>
      _$RelaxVideoModelFromJson(json);
}
