//part 'AndroidModel.g.dart';
import 'package:json_annotation/json_annotation.dart';

part 'TodayGankBaseChildModel.g.dart';

@JsonSerializable()
class BaseItemModel extends Object {
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

  BaseItemModel(this.id, this.createdAt, this.desc, this.images,
      this.publishedAt, this.source, this.type, this.url, this.used, this.who);

  factory BaseItemModel.fromJson(Map<String, dynamic> json) =>
      _$BaseItemModelFromJson(json);

  @override
  String toString() {
    return 'BaseItemModel{id: $id, createdAt: $createdAt, desc: $desc, images: $images, publishedAt: $publishedAt, source: $source, type: $type, url: $url, used: $used, who: $who}';
  }
}
