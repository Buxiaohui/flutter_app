import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/bean/ModeHelper.dart';
import 'package:flutter_app/bean/TodayGankBaseChildModel.dart';
import 'package:flutter_app/bean/TodayGankModel.dart';
import 'package:flutter_app/net/NetConstants.dart';
import 'package:flutter_app/net/NetController.dart';
import 'package:flutter_app/page/today_gank/today_base_child_page.dart';

void main() => runApp(TodayGankPage());

class TodayGankPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new TodayGankPageState();
}

class TodayGankPageState extends State<TodayGankPage>
    with SingleTickerProviderStateMixin {
  int _currentPageIndex = 0;
  var _pageController = new PageController(initialPage: 0);
  TodayGankModel _todayGankModel;
  List<Text> _tabTitleWidgetList;
  HashMap<String, dynamic> _pageMap;
  final List<Tab> tabs = [];

  @override
  void initState() {
    super.initState();
    print("***********initState***********");
    _pageMap = new HashMap<String, dynamic>();
    _tabTitleWidgetList = new List();
    for (int i = 0; i < ModeHelper.TITLES.length; i++) {
      _tabTitleWidgetList.add(
          new Text(ModeHelper.TITLES[i], style: new TextStyle(fontSize: 20.0)));
      tabs.add(new Tab(child: _tabTitleWidgetList[i]));
    }
    NetController.request(NetConstants.TODAY_GANK_URL,
        (request, response, bodyData) {
      try {
        print("***********initState request data***********");
        _todayGankModel = TodayGankModel.fromJson(json.decode(bodyData));
      } catch (exception) {
        print("initState,error,$exception");
      }

      print("initState,setState,_todayGankModel,$_todayGankModel");
      setState(() {
        if (_todayGankModel != null && _todayGankModel.category.length > 0) {
          for (int i = 0; i < _todayGankModel.category.length; i++) {
            TodayGankBaseChildPage todayGankBaseChildPage =
                new TodayGankBaseChildPage(title: _todayGankModel.category[i]);
            todayGankBaseChildPage.items =
                getDatas(_todayGankModel.category[i]);
            _pageMap[_todayGankModel.category[i]] = todayGankBaseChildPage;
          }
        }
      });
    });
  }

  List<BaseItemModel> getDatas(String category) {
    if (_todayGankModel == null ||
        _todayGankModel.results == null ||
        category == null ||
        category.isEmpty) {
      return null;
    }
    switch (category) {
      case ModeHelper.APP:
        return _todayGankModel.results.App;
      case ModeHelper.FRONT:
        return _todayGankModel.results.front;
      case ModeHelper.ANDROID:
        return _todayGankModel.results.Android;
      case ModeHelper.STRETCH_RES:
        return _todayGankModel.results.mStretchResModels;
      case ModeHelper.RECOM:
        return _todayGankModel.results.mFreeRecomModels;
      case ModeHelper.IOS:
        return _todayGankModel.results.iOS;
      case ModeHelper.BENIFIT:
        return _todayGankModel.results.mBenifitModels;
      case ModeHelper.RELAX_VIDEO:
        return _todayGankModel.results.mRelaxVideoModels;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
//    return WillPopScope(
//        child: new MaterialApp(
    return new DefaultTabController(
      length: tabs.length,
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text("今日干货"),
          centerTitle: false,
          bottom: new TabBar(
            isScrollable: true,
            tabs: tabs,
          ),
        ),
        body: new TabBarView(
          children: _tabTitleWidgetList.map((Text titleTextWidget) {
            return new Center(child: _pageMap[titleTextWidget.data]);
          }).toList(),
        ),
      ),
    );
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
