import 'package:flutter_app/bean/ResultsMode.dart';
import 'package:json_annotation/json_annotation.dart';

part 'TodayGankMode.g.dart';

@JsonSerializable(nullable: false)
class TodayGankMode extends Object {
  List<String> category;
  bool error;
  ResultsMode results;

  TodayGankMode(this.category, this.error, this.results);

  factory TodayGankMode.fromJson(Map<String, dynamic> json) =>
      _$TodayGankModeFromJson(json);

  Map<String, dynamic> toJson() => _$TodayGankModeToJson(this);

  @override
  String toString() {
    return 'TodayGankModel{category: $category, error: $error, results: $results}';
  }
}
