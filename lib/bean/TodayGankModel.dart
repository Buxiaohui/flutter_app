import 'package:flutter_app/bean/ResultsModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'TodayGankModel.g.dart';

@JsonSerializable()
class TodayGankModel extends Object {
  List<String> category;
  bool error;
  ResultsModel results;

  TodayGankModel(this.category, this.error, this.results);

  factory TodayGankModel.fromJson(Map<String, dynamic> json) =>
      _$TodayGankModelFromJson(json);

  @override
  String toString() {
    return 'TodayGankModel{category: $category, error: $error, results: $results}';
  }


}
