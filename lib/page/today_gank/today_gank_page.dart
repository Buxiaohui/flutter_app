import 'dart:collection';
import 'dart:convert';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bean/ModeHelper.dart';
import 'package:flutter_app/bean/TodayGankBaseChildModel.dart';
import 'package:flutter_app/bean/TodayGankModel.dart';
import 'package:flutter_app/net/NetConstants.dart';
import 'package:flutter_app/net/NetController.dart';
import 'package:flutter_app/page/base_page_mixin.dart';
import 'package:flutter_app/page/today_gank/benifit_child_page.dart';
import 'package:flutter_app/page/today_gank/today_base_child_page.dart';

import '../blank_page.dart';

void main() => runApp(TodayGankPage());

class TodayGankPage extends StatefulWidget {
  TodayGankPage();

  factory TodayGankPage.forDesignTime() {
    // TODO: add arguments
    return new TodayGankPage();
  }

  @override
  State<StatefulWidget> createState() => new TodayGankPageState();
}

class TodayGankPageState extends State<TodayGankPage>
    with TickerProviderStateMixin {
  TodayGankModel _todayGankModel;
  List<Text> _tabTitleWidgetList;
  HashMap<String, dynamic> _pageMap;
  final List<Tab> tabs = [];
  Future<void> _mFuture;

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    print("***********initState()***********");
    _mFuture = _request(); // 防止setState后触发build，导致不停请求数据
    _pageMap = new HashMap<String, dynamic>();
    _tabTitleWidgetList = new List();
    _asyncMemoizer = AsyncMemoizer();
    _voidCallback = () {
      print("initState,_tabControllert" + tabs.toString());
    };
  }

  AsyncMemoizer _asyncMemoizer;

  // TODO error
  _requestInner() {
    print("***********_requestInner***********");
    return _asyncMemoizer.runOnce(() {
      return _request();
    });
  }

  Future<void> _request() async {
    print("***********_request request data AAAAAA***********");
    NetController.request(NetConstants.TODAY_GANK_URL, 0,
        (request, response, bodyData, requestType) {
      try {
        print("***********_request request data***********");
        _todayGankModel = TodayGankModel.fromJson(json.decode(bodyData));
      } catch (exception) {
        print("_request,error,$exception");
      }
      print("_request,tabs.length:" + tabs.length.toString());
      print("_request,tabs.length:" + tabs.toString());
      if (tabs != null) {
        tabs.clear();
      }
      if (_todayGankModel != null && _todayGankModel.category.length > 0) {
        for (int i = 0; i < _todayGankModel.category.length; i++) {
          BasePageMixin childPage = getTabPage(_todayGankModel.category[i]);
          _pageMap[_todayGankModel.category[i]] = childPage;

          _tabTitleWidgetList.add(new Text(_todayGankModel.category[i],
              style: new TextStyle(fontSize: 20.0)));
          tabs.add(new Tab(child: _tabTitleWidgetList[i]));
        }
      }
      _tabController =
          TabController(length: tabs.length, initialIndex: 0, vsync: this);
      _tabController.removeListener(_voidCallback);
      _tabController.addListener(_voidCallback);
      print("_request,setState,_todayGankModel,$_todayGankModel");
      setState(() {
        print("_request,setState");
      });
    });
  }

  VoidCallback _voidCallback;

  BasePageMixin getTabPage(String category) {
    switch (category) {
      case ModeHelper.APP:
        BasePageMixin childPage = new TodayGankBaseChildPage();
        childPage.items = getDatas(category);
        childPage.title = category;
        return childPage;
      case ModeHelper.FRONT:
        BasePageMixin childPage = new TodayGankBaseChildPage();
        childPage.items = getDatas(category);
        childPage.title = category;
        return childPage;
      case ModeHelper.ANDROID:
        BasePageMixin childPage = new TodayGankBaseChildPage();
        childPage.items = getDatas(category);
        childPage.title = category;
        return childPage;
      case ModeHelper.STRETCH_RES:
        BasePageMixin childPage = new TodayGankBaseChildPage();
        childPage.items = getDatas(category);
        childPage.title = category;
        return childPage;
      case ModeHelper.RECOM:
        BasePageMixin childPage = new TodayGankBaseChildPage();
        childPage.items = getDatas(category);
        childPage.title = category;
        return childPage;
      case ModeHelper.IOS:
        BasePageMixin childPage = new TodayGankBaseChildPage();
        childPage.items = getDatas(category);
        childPage.title = category;
        return childPage;
      case ModeHelper.BENIFIT:
        BasePageMixin childPage = new BenifitChildPage();
        childPage.items = getDatas(category);
        childPage.title = category;
        return childPage;
      case ModeHelper.RELAX_VIDEO:
        BasePageMixin childPage = new TodayGankBaseChildPage();
        childPage.items = getDatas(category);
        childPage.title = category;
        return childPage;
      default:
        return null;
    }
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
    print("TodayGankPage,build");
    FutureBuilder futureBuilder = FutureBuilder<void>(
        future: _mFuture,
        builder: (BuildContext context, AsyncSnapshot<void> asyncSnapshot) {
          print("build,,," + asyncSnapshot.connectionState.toString());
          switch (asyncSnapshot.connectionState) {
            case ConnectionState.none:
              return BlankPage(pageState: BlankPage.FAIL);
            case ConnectionState.active:
              return BlankPage(pageState: BlankPage.LOADING);
            case ConnectionState.done:
              return _getItem();
            case ConnectionState.waiting:
              return BlankPage(pageState: BlankPage.LOADING);
            default:
              return Text("ConnectionState.default");
          }
        });
    return futureBuilder;
  }

  _getItem() {
    print("_getItem,tabs.length:" + tabs.length.toString());
    print("_getItem,tabs.length:" + tabs.toString());
    if (tabs == null || tabs.length < 1) {
      return BlankPage(pageState: BlankPage.FAIL);
    }
    return new DefaultTabController(
      length: tabs.length,
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text("今日干货"),
          centerTitle: false,
          bottom: new TabBar(
            controller: _tabController,
            isScrollable: true,
            tabs: tabs,
          ),
        ),
        body: new TabBarView(
          controller: _tabController,
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

  //当整个页面dispose时，记得把控制器也dispose掉，释放内存
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
