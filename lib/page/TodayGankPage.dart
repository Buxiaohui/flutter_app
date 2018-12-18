import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/bean/TodayGankModel.dart';
import 'package:flutter_app/net/NetConstants.dart';
import 'package:flutter_app/net/NetController.dart';

class TodayGankPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new TodayGankPageState();
}

class TodayGankPageState extends State<TodayGankPage> {
  int _currentPageIndex = 0;
  var _pageController = new PageController(initialPage: 0);
  TodayGankModel _todayGankModel;

  @override
  void initState() {
    super.initState();
    // 网络请求
    NetController.request(NetConstants.TODAY_GANK_URL,
        (request, response, bodyData) {
      try {
        _todayGankModel = TodayGankModel.fromJson(json.decode(bodyData));
      } catch (exception) {
        print("initState,error,$exception");
      }
      print("initState,_todayGankModel,$_todayGankModel");
      // flutter 通过这种方式更新UI
      setState(() {
        print("initState,setState,_todayGankModel,$_todayGankModel");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("今日干货"),
          centerTitle: false,
        ),
        body: new PageView.builder(
          onPageChanged: _pageChange,
          controller: _pageController,
          itemBuilder: (BuildContext context, int index) {
            print("build,getText,$index");
            return new Text(getItemName(index));
          },
          itemCount: getItemCount(),
        ),
      ),
    );
  }

  String getItemName(int index) {
    if (_todayGankModel != null && _todayGankModel.category != null) {
      return _todayGankModel.category[index];
    }
    return "pps, error";
  }

  int getItemCount() {
    if (_todayGankModel == null) {
      return 0;
    }
    if (_todayGankModel.category == null) {
      return 0;
    }
    return _todayGankModel.category.length;
  }

  // bottomnaviagtionbar 和 pageview 的联动
  void onTap(int index) {
    // 过pageview的pagecontroller的animateToPage方法可以跳转
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void _pageChange(int index) {
    setState(() {
      if (_currentPageIndex != index) {
        _currentPageIndex = index;
      }
    });
  }
}
