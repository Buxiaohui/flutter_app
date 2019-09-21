import 'package:flutter_app/bean/BaseItemMode.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ResultsMode.g.dart';

@JsonSerializable(nullable: false)
class ResultsMode {
  List<BaseItemMode> App;
  List<BaseItemMode> front;
  List<BaseItemMode> Android;
  List<BaseItemMode> iOS;
  List<BaseItemMode> mRelaxVideoModels;
  List<BaseItemMode> mStretchResModels;
  List<BaseItemMode> mFreeRecomModels;
  List<BaseItemMode> mBenifitModels;

  ResultsMode(
      this.Android,
      this.front,
      this.App,
      this.iOS,
      this.mRelaxVideoModels,
      this.mStretchResModels,
      this.mFreeRecomModels,
      this.mBenifitModels);

  factory ResultsMode.fromJson(Map<String, dynamic> json) =>
      _$ResultsModeFromJson(json);

  Map<String, dynamic> toJson() => _$ResultsModeToJson(this);

  @override
  String toString() {
    return 'ResultsModel{Android: $Android, App: $App, iOS: $iOS, mRelaxVideoModels: $mRelaxVideoModels, mStretchResModels: $mStretchResModels, mFreeRecomModels: $mFreeRecomModels, mBenifitModels: $mBenifitModels}';
  }
}
