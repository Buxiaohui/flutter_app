import 'package:flutter_app/bean/RelaxVideoModel.dart';
import 'package:json_annotation/json_annotation.dart';
part 'RelaxVideoModels.g.dart';

@JsonSerializable()
class RelaxVideoModels extends Object {
  int count;

  bool error;
  List<RelaxVideoModel> results;

  RelaxVideoModels(this.count, this.error, this.results);

  @override
  String toString() {
    return 'RelaxVideoModels{count: $count, error: $error, results: $results}';
  }

  factory RelaxVideoModels.fromJson(Map<String, dynamic> json) =>
      _$RelaxVideoModelsFromJson(json);
}
