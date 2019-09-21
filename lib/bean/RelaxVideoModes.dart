import 'package:json_annotation/json_annotation.dart';

import 'BaseItemMode.dart';

part 'RelaxVideoModes.g.dart';

@JsonSerializable(nullable: false)
class RelaxVideoModes extends Object {
  int count;
  bool error;
  List<BaseItemMode> results;

  RelaxVideoModes(this.count, this.error, this.results);

  @override
  String toString() {
    return 'RelaxVideoModels{count: $count, error: $error, results: $results}';
  }

  factory RelaxVideoModes.fromJson(Map<String, dynamic> json) =>
      _$RelaxVideoModesFromJson(json);

  Map<String, dynamic> toJson() => _$RelaxVideoModesToJson(this);
}
