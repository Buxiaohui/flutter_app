import 'package:json_annotation/json_annotation.dart';

part 'BaseItemMode.g.dart';

@JsonSerializable(nullable: false)
class BaseItemMode extends Object {
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

  BaseItemMode(this.id, this.createdAt, this.desc, this.images,
      this.publishedAt, this.source, this.type, this.url, this.used, this.who);

  @override
  String toString() {
    return 'BaseItemModel{id: $id, createdAt: $createdAt, desc: $desc, images: $images, publishedAt: $publishedAt, source: $source, type: $type, url: $url, used: $used, who: $who}';
  }

  factory BaseItemMode.fromJson(Map<String, dynamic> json) =>
      _$BaseItemModeFromJson(json);

  Map<String, dynamic> toJson() => _$BaseItemModeToJson(this);
}
