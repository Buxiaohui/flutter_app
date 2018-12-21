import 'package:flutter_app/bean/AndroidModel.dart';
import 'package:flutter_app/bean/AppModel.dart';
import 'package:flutter_app/bean/BenifitModel.dart';
import 'package:flutter_app/bean/FreeRecomModel.dart';
import 'package:flutter_app/bean/IOSModel.dart';
import 'package:flutter_app/bean/RelaxVideoModel.dart';
import 'package:flutter_app/bean/StretchResModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ResultsModel.g.dart';

@JsonSerializable()
class ResultsModel {
  List<AndroidModel> Android;
  List<AppModel> App;
  List<IOSModel> iOS;
  List<RelaxVideoModel> mRelaxVideoModels;
  List<StretchResModel> mStretchResModels;
  List<FreeRecomModel> mFreeRecomModels;
  List<BenifitModel> mBenifitModels;

  ResultsModel(this.Android, this.App, this.iOS, this.mRelaxVideoModels,
      this.mStretchResModels, this.mFreeRecomModels, this.mBenifitModels);

  factory ResultsModel.fromJson(Map<String, dynamic> json) =>
      _$ResultsModelFromJson(json);

  @override
  String toString() {
    return 'ResultsModel{Android: $Android, App: $App, iOS: $iOS, mRelaxVideoModels: $mRelaxVideoModels, mStretchResModels: $mStretchResModels, mFreeRecomModels: $mFreeRecomModels, mBenifitModels: $mBenifitModels}';
  }
}
