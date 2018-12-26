import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/bean/AndroidModel.dart';
import 'package:flutter_app/bean/AppModel.dart';
import 'package:flutter_app/bean/BenifitModel.dart';
import 'package:flutter_app/bean/FreeRecomModel.dart';
import 'package:flutter_app/bean/IOSModel.dart';
import 'package:flutter_app/bean/RelaxVideoModel.dart';
import 'package:flutter_app/bean/StretchResModel.dart';
import 'package:flutter_app/bean/TodayGankModel.dart';
import 'package:flutter_app/net/NetConstants.dart';
import 'package:flutter_app/net/NetController.dart';
import 'package:flutter_app/page/today_gank/android_child_page.dart';
import 'package:flutter_app/page/today_gank/app_child_page.dart';
import 'package:flutter_app/page/today_gank/benifit_child_page.dart';
import 'package:flutter_app/page/today_gank/free_recom_child_page.dart';
import 'package:flutter_app/page/today_gank/ios_child_page.dart';
import 'package:flutter_app/page/today_gank/relax_video_child_page.dart';
import 'package:flutter_app/page/today_gank/stretch_resource_child_page.dart';
void main() => runApp(TodayGankPage());
class TodayGankPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new TodayGankPageState();
}

class TodayGankPageState extends State<TodayGankPage> {
  List<StatefulWidget> _childPageList; // 存放对应的页面
  List<AndroidModel> androidModels;
  List<AppModel> appModels;
  List<IOSModel> iosModels;
  List<RelaxVideoModel> relaxVideoModels;
  List<StretchResModel> stretchResModels;
  List<FreeRecomModel> freeRecomModels;
  List<BenifitModel> benifitModels;

  AndroidPage androidPage;
  AppPage appPage;
  IOSPage iosPage;
  RelaxVideoPage relaxVideoPage;
  StretchResPage stretchResPage;
  FreeRecomPage freeRecomPage;
  BenifitPage benifitPage;

  int _currentPageIndex = 0;
  var _pageController = new PageController(initialPage: 0);
  TodayGankModel _todayGankModel;

  @override
  void initState() {
    super.initState();
    androidPage = AndroidPage(items: androidModels);
    appPage = AppPage(items: appModels);
    iosPage = IOSPage(items: iosModels);
    relaxVideoPage = RelaxVideoPage(items: relaxVideoModels);
    stretchResPage = StretchResPage(items: stretchResModels);
    freeRecomPage = FreeRecomPage(items: freeRecomModels);
    benifitPage = BenifitPage(items: benifitModels);
    // 网络请求
    NetController.request(NetConstants.TODAY_GANK_URL,
        (request, response, bodyData) {
      try {
        _todayGankModel = TodayGankModel.fromJson(json.decode(bodyData));
      } catch (exception) {
        print("initState,error,$exception");
      }
      // 存放页面
      _childPageList = <StatefulWidget>[
        androidPage,
        appPage,
        iosPage,
        relaxVideoPage,
        stretchResPage,
        freeRecomPage,
        benifitPage
      ];
      print("initState,_todayGankModel,$_todayGankModel");
      // flutter 通过这种方式更新UI
      setState(() {
        print("initState,setState,_todayGankModel,$_todayGankModel");
        if (_todayGankModel != null && _todayGankModel.results != null) {
          androidModels = _todayGankModel.results.Android;
          appModels = _todayGankModel.results.App;
          iosModels = _todayGankModel.results.iOS;
          relaxVideoModels = _todayGankModel.results.mRelaxVideoModels;
          stretchResModels = _todayGankModel.results.mStretchResModels;
          freeRecomModels = _todayGankModel.results.mFreeRecomModels;
          benifitModels = _todayGankModel.results.mBenifitModels;

          androidPage.items = androidModels;
          appPage.items = appModels;
          iosPage.items = iosModels;
          relaxVideoPage.items = relaxVideoModels;
          stretchResPage.items = stretchResModels;
          freeRecomPage.items = freeRecomModels;
          benifitPage.items = benifitModels;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
//    return WillPopScope(
//        child: new MaterialApp(
        return new MaterialApp(
          home: new Scaffold(
            appBar: new AppBar(
              title: new Text("今日干货"),
              centerTitle: false,
            ),
            body: new PageView.builder(
              pageSnapping: true,
              onPageChanged: _pageChange,
              controller: _pageController,
              itemBuilder: (BuildContext context, int index) {
                print("build,getText,$index");
                return getItem(index);
              },
              itemCount: getItemCount(),
            ),
          ),
        );
//        onWillPop: _onWillPop);
  }

  Future<bool> _onWillPop() async {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
                title: new Text('Are you sure?'),
                content: new Text('Do you want to exit an App'),
                actions: <Widget>[
                  new FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: new Text('No'),
                  ),
                  new FlatButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: new Text('Yes'),
                  ),
                ],
              ),
        ) ??
        false;
  }

  StatefulWidget getItem(int index) {
    if (_childPageList != null && _childPageList.length > index && index >= 0) {
      return _childPageList[index];
    }
    return null;
  }

  String getItemName(int index) {
    if (_todayGankModel != null && _todayGankModel.category != null) {
      return _todayGankModel.category[index];
    }
    return "opps, error";
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
