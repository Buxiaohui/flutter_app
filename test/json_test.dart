import 'dart:convert';

import 'package:flutter_app/bean/TodayGankMode.dart';
import 'package:flutter_test/flutter_test.dart';

import 'JsonStrings.dart';

void main() {
  group('jsonparse test', () {
    test('mockdata test', () {
      TodayGankMode todayGankModel =
          TodayGankMode.fromJson(json.decode(JsonStrings.TODAY_GANK_JSON));
      print(todayGankModel);
    });
  });
}
