import 'package:json_annotation/json_annotation.dart';

part 'BenifitMode.g.dart';

@JsonSerializable(nullable: false)
class BenifitMode extends Object {
  String id;
  String createdAt;
  String desc;
  String publishedAt;
  String source;
  String type;
  String url;
  bool used;
  String who;
  bool select = false;

  BenifitMode(this.id, this.url, this.publishedAt);

  Map<String, dynamic> toJson() => _$BenifitModeToJson(this);

  factory BenifitMode.fromJson(Map<String, dynamic> json) =>
      _$BenifitModeFromJson(json);

  @override
  String toString() {
    return 'BenifitMode{_id: $id, publishedAt: $publishedAt, url: $url}';
  }
}
