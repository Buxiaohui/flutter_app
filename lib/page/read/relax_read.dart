import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/bean/ReadCategory.dart';
import 'package:flutter_app/net/NetConstants.dart';
import 'package:flutter_app/net/NetController.dart';
import 'package:flutter_app/page/blank_page.dart';
import 'package:flutter_app/page/read/relax_read_child_page.dart';

void main() => runApp(RelaxReadPage());

class RelaxReadPage extends StatefulWidget {
  RelaxReadPage();

  factory RelaxReadPage.forDesignTime() {
    // TODO: add arguments
    return new RelaxReadPage();
  }

  @override
  State<StatefulWidget> createState() => new RelaxReadPageState();
}

class RelaxReadPageState extends State<RelaxReadPage>
    with SingleTickerProviderStateMixin {
  List<ReadCategory> _datas;
  List<Text> _tabTitleWidgetList;
  HashMap<String, dynamic> _pageMap;
  final List<Tab> tabs = [];
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    print("***********initState***********");
    _pageMap = new HashMap<String, dynamic>();
    _datas = new List();
    _tabTitleWidgetList = new List();
    _tabController =
        TabController(length: tabs.length, initialIndex: 0, vsync: this);
    _request(0);
  }

  Future<void> _request(int _requestType) async {
    NetController.request(NetConstants.RELAX_READ_CATEGORY_URL, 0,
        (request, response, bodyData, requestType) {
      try {
        print("***********initState request data***********");
        print("***********initState$_datas");
        final body = json.decode(bodyData);
        final results = body["results"];
        _datas.clear();
        results.forEach((item) {
          _datas.add(ReadCategory(
              item["_id"], item["en_name"], item["name"], item["rank"]));
        });
      } catch (exception) {
        print("initState,error,$exception");
      }
      if (_datas != null && _datas.length > 0) {
        for (int i = 0; i < _datas.length; i++) {
          _tabTitleWidgetList.add(
              new Text(_datas[i].name, style: new TextStyle(fontSize: 20.0)));
          tabs.add(new Tab(child: _tabTitleWidgetList[i]));
          RelaxReadBaseChildPage childPage =
              getTabPage(_datas[i].en_name, _datas[i].name);
          _pageMap[_datas[i].name] = childPage;
        }
      }
      _tabController =
          TabController(length: tabs.length, initialIndex: 0, vsync: this);
      _tabController.addListener(() {
        print("initState,_tabController");
      });
      print("initState,setState,_datas:$_datas");
      setState(() {
        print("initState,setState");
      });
    });
  }

  RelaxReadBaseChildPage getTabPage(String en_name, String name) {
    RelaxReadBaseChildPage childPage = new RelaxReadBaseChildPage();
    childPage.en_name = en_name;
    childPage.name = name;
    return childPage;
  }

  @override
  Widget build(BuildContext context) {
    if (tabs == null || tabs.length <= 0) {
      return BlankPage(
        pageState: 2,
      );
    }
    print("tabs.length:" + tabs.length.toString());
    print("tabs.length:" + tabs.toString());
    return new DefaultTabController(
      length: tabs.length,
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text("闲读"),
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
    if (_datas != null && _datas.length > index) {
      return _datas[index].name;
    }
    return "opps, error";
  }

  int getItemCount() {
    if (_datas == null) {
      return 0;
    }
    if (_datas.length == null) {
      return 0;
    }
    return _datas.length;
  }

  //当整个页面dispose时，记得把控制器也dispose掉，释放内存
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
