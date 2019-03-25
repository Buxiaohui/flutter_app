import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/bean/ReadDetailMode.dart';
import 'package:flutter_app/bean/ReadDetailSiteMode.dart';
import 'package:flutter_app/net/NetConstants.dart';
import 'package:flutter_app/net/NetController.dart';
import 'package:flutter_html/flutter_html.dart';

void main() => runApp(RelaxReadDetailPage());

class RelaxReadDetailPage extends StatefulWidget {
  RelaxReadDetailPage();

  String category;

  factory RelaxReadDetailPage.forDesignTime() {
    // TODO: add arguments
    return new RelaxReadDetailPage();
  }

  @override
  State<StatefulWidget> createState() => new RelaxReadDetailPageState();
}

class RelaxReadDetailPageState extends State<RelaxReadDetailPage>
    with SingleTickerProviderStateMixin {
  List<ReadDetailMode> _datas;
  ScrollController _scrollController;
  int _count = 10;
  int _page = 1;

  @override
  void initState() {
    super.initState();
    print("***********initState***********");
    _scrollController = new ScrollController(
        debugLabel: "relax_read", initialScrollOffset: 0.0);
    _datas = new List();
    _request(0);

    _scrollController.addListener(() {
      print('_scrollController.position.pixels ' +
          _scrollController.position.pixels.toString());
      print(' _scrollController.position.maxScrollExtent' +
          _scrollController.position.maxScrollExtent.toString());
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('滑动到了最底部');
        _request(1);
      }
    });
  }

  Future<void> _request(int _requestType) async {
    if (_requestType == 0) {
      _count = 10;
      _page = 1;
    } else {
      _page++;
    }
    NetController.request(
        NetConstants.READ_BASE_URL +
            widget.category +
            "/count/$_count/page/$_page",
        0, (request, response, bodyData, requestType) {
      try {
        final body = json.decode(bodyData);
        final results = body["results"];
        List<ReadDetailMode> newDatas = new List();
        results.forEach((item) {
          ReadDetailMode readDetailMode = new ReadDetailMode();
          ReadDetailSiteMode readDetailSiteMode = new ReadDetailSiteMode();
          readDetailMode.site = readDetailSiteMode;
          readDetailMode.title = item["title"];
          readDetailMode.url = item["url"];
          readDetailMode.content = item["content"];
          readDetailMode.published_at = item["published_at"];
          readDetailMode.cover = item["cover"];
          readDetailMode.crawled = item["crawled"];
          readDetailMode.created_at = item["created_at"];
          readDetailMode.raw = item["raw"];
          readDetailMode.setId(item["_id"]);
          // site
          readDetailSiteMode.cat_cn = item["site"]["cat_cn"];
          readDetailSiteMode.cat_en = item["site"]["cat_en"];
          readDetailSiteMode.desc = item["site"]["desc"];
          readDetailSiteMode.id = item["site"]["id"];
          readDetailSiteMode.icon = item["site"]["icon"];
          readDetailSiteMode.feed_id = item["site"]["feed_id"];
          readDetailSiteMode.type = item["site"]["type"];
          readDetailSiteMode.url = item["site"]["url"];
          readDetailSiteMode.name = item["site"]["name"];
          readDetailSiteMode.subscribers = item["site"]["subscribers"];
          newDatas.add(readDetailMode);
        });
        print("request,_datas,$newDatas");
        if (requestType == 0) {
          _datas.clear();
          _datas.addAll(newDatas);
        } else {
          _datas.addAll(newDatas);
        }
      } catch (exception) {
        print("initState,error,$exception");
      }
      print("initState,setState,_datas:$_datas");
      setState(() {
        print("initState,setState");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
        appBar: AppBar(
          title: Text("Infinite ListView"),
        ),
        body: RefreshIndicator(
          child: new ListView.builder(
              controller: _scrollController,
              itemCount: _getItemCount(),
              itemBuilder: (context, index) {
                ReadDetailMode mode = _datas[index];
                return _getItemUserDefine(context, index, mode);
              }),
          onRefresh: () {
            _request(0);
          },
        ),
      ),
    );
  }

  int _getItemCount() {
    if (_datas != null) {
      return _datas.length;
    }
    return 0;
  }

  String _getContent(ReadDetailMode mode) {
    if (mode != null) {
      if (mode.content.isNotEmpty) {
        return mode.content;
      }
      if (mode.raw.isNotEmpty) {
        return mode.raw;
      }
    }
    return "";
  }

  String _getPublishedAt(int index) {
    if (_datas != null && _datas.length > index) {
      return "发布日期:" + _datas[index].published_at.substring(0, 10);
    }
    return "";
  }

  //ListView的Item
  Widget _getItemUserDefine(
      BuildContext context, int index, ReadDetailMode mode) {
    return Card(
      margin: EdgeInsets.fromLTRB(4, 4, 4, 4),
      elevation: 4,
      child: getItemUserDefineInner(context, index, mode),
    );
  }

  Widget getItemUserDefineInner(
      BuildContext context, int index, ReadDetailMode mode) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      textDirection: TextDirection.ltr,
      children: <Widget>[
        new Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                new Expanded(
                    child: new Padding(
                        padding: const EdgeInsets.fromLTRB(16, 5, 16, 0),
                        child: new Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text(mode.title,
                                softWrap: true, textAlign: TextAlign.left))))
              ],
            ),
            Row(
              children: <Widget>[
                new Expanded(
                    child: new Padding(
                        padding: const EdgeInsets.fromLTRB(16, 5, 16, 2),
                        child: new Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text(_getPublishedAt(index),
                                softWrap: true, textAlign: TextAlign.left))))
              ],
            ),
            Padding(
              child: Html(data: _getContent(mode)),
              padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
            ),
            Padding(
              child: Text(
                mode.url,
                softWrap: true,
                style: new TextStyle(
                    color: Colors.red, decoration: TextDecoration.underline),
              ),
              padding: EdgeInsets.fromLTRB(4, 4, 4, 4),
            ),
          ],
        ),
//
      ],
    );
  }
}
