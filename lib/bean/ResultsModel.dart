import 'package:flutter_app/bean/TodayGankBaseChildModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ResultsModel.g.dart';

@JsonSerializable()
class ResultsModel {
  List<BaseItemModel> App;
  List<BaseItemModel> front;
  List<BaseItemModel> Android;
  List<BaseItemModel> iOS;
  List<BaseItemModel> mRelaxVideoModels;
  List<BaseItemModel> mStretchResModels;
  List<BaseItemModel> mFreeRecomModels;
  List<BaseItemModel> mBenifitModels;

  ResultsModel(
      this.Android,
      this.front,
      this.App,
      this.iOS,
      this.mRelaxVideoModels,
      this.mStretchResModels,
      this.mFreeRecomModels,
      this.mBenifitModels);

  factory ResultsModel.fromJson(Map<String, dynamic> json) =>
      _$ResultsModelFromJson(json);

  @override
  String toString() {
    return 'ResultsModel{Android: $Android, App: $App, iOS: $iOS, mRelaxVideoModels: $mRelaxVideoModels, mStretchResModels: $mStretchResModels, mFreeRecomModels: $mFreeRecomModels, mBenifitModels: $mBenifitModels}';
  }
}
