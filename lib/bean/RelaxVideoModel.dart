//part 'RelaxVideoModel.g.dart';
import 'package:json_annotation/json_annotation.dart';

part 'RelaxVideoModel.g.dart';

@JsonSerializable()
class RelaxVideoModel extends Object  {
  String id;
  String createdAt;
  String desc;
  String publishedAt;
  String source;
  String type;
  String url;
  bool used;
  String who;

  RelaxVideoModel(this.id, this.createdAt, this.desc, this.publishedAt,
      this.source, this.type, this.url, this.used, this.who);

  factory RelaxVideoModel.fromJson(Map<String, dynamic> json) =>
      _$RelaxVideoModelFromJson(json);
}
