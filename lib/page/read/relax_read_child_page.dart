//view:listview
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/bean/ReadCategoryChild.dart';
import 'package:flutter_app/net/NetConstants.dart';
import 'package:flutter_app/net/NetController.dart';

class RelaxReadBaseChildPage extends StatefulWidget {
  RelaxReadBaseChildPage({Key key}) : super(key: key);
  String name;
  String en_name;

  @override
  State<StatefulWidget> createState() => new _MyListState();
}

//得到一个ListView
class _MyListState extends State<RelaxReadBaseChildPage>
    with SingleTickerProviderStateMixin {
  double _xHandImgOffset = 0.0;
  String tipsStr;
  var tipBannerTextArr = ["讲真，百度导航天下第一", "据说：百度导航将称霸世界", "传言：百度导航一统宇宙"];
  List<ReadCategoryChild> _datas;

  @override
  void initState() {
    super.initState();
    _datas = new List();
    _request(0);
  }

  Future<void> _request(int _requestType) async {
    NetController.request(
        NetConstants.RELAX_READ_CHILD_CATEGORY_BASE_URL + widget.en_name, 0,
        (request, response, bodyData, requestType) {
      try {
        print("***********initState request data***********$_datas");
        final body = json.decode(bodyData);
        final results = body["results"];
        _datas.clear();
        results.forEach((item) {
          _datas.add(ReadCategoryChild(item["_id"], item["id"],
              item["created_at"], item["icon"], item["title"]));
        });
      } catch (exception) {
        print("initState,error,$exception");
      }
      setState(() {
        print("initState,setState,,,$_datas");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Column(children: <Widget>[
      new Flexible(
          child: new ListView.builder(
              itemCount: getItemCount(),
              itemBuilder: (context, index) {
                return getItemUserDefine(context, index);
              }))
    ]);
  }

  int getItemCount() {
    if (_datas != null) {
      return _datas.length;
    }
    return 0;
  }

  String getIconUrl(int index) {
    if (_datas != null && _datas.length > index) {
      return _datas[index].icon;
    }
    return "";
  }

  String getTitle(int index) {
    if (_datas != null && _datas.length > index) {
      return _datas[index].title;
    }
    return "";
  }

  String getPublishedAt(int index) {
    if (_datas != null && _datas.length > index) {
      return "发布日期:" + _datas[index].created_at.substring(0, 10);
    }
    return "";
  }

  //ListView的Item
  Widget getItemUserDefine(BuildContext context, int index) {
    // 根据文档描述，没有指定card的shape屎，使用主题默认的shape，是一个圆角的shape，圆角4dp
    return Card(
      elevation: 4,
      margin: EdgeInsets.fromLTRB(8, 4, 8, 4),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          textDirection: TextDirection.ltr,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: Image.network(
                getIconUrl(index),
                fit: BoxFit.cover,
                width: 80,
                height: 80,
              ),
            ),
            Text(getTitle(index)),
            Text(getPublishedAt(index)),
          ]),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
