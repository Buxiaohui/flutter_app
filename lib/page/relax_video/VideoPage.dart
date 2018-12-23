import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/bean/RelaxVideoModel.dart';
import 'package:flutter_app/bean/RelaxVideoModels.dart';
import 'package:flutter_app/net/NetConstants.dart';
import 'package:flutter_app/net/NetController.dart';
import 'package:flutter_app/page/webview_page.dart';

// TOTO 加载更多
class VideoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new VideoPageState();
}

class VideoPageState extends State<VideoPage> {
  RelaxVideoModels _relaxVideoModels;
  List<RelaxVideoModel> _relaxVideoModelItems;
  int _page = 1;
  int _count = 10;

  Future<Null> _refresh() async {
    // 网络请求
    String finalInitUrl =
        NetConstants.RELAX_VIDEO_BASE_URL + "count/$_count/page/$_page";
    print("refresh,firatInitUrl,$finalInitUrl");
    NetController.request(finalInitUrl, (request, response, bodyData) {
      try {
        _relaxVideoModels = RelaxVideoModels.fromJson(json.decode(bodyData));
        _relaxVideoModelItems = _relaxVideoModels.results;
      } catch (exception) {
        print("refresh,error,$exception");
      }
      print("refresh,_relaxVideoModels,$_relaxVideoModels");
      // flutter 通过这种方式更新UI
      setState(() {});
    });
    return null;
  }

  @override
  void initState() {
    super.initState();
    _refresh();
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
                itemCount: getItemCount(),
                itemBuilder: (context, index) {
                  return getItemUserDefine(context, index);
                }),
            onRefresh: _refresh),
      ),
    );
  }

  int getImageCount(int index) {
    if (_relaxVideoModelItems == null ||
        _relaxVideoModelItems.length < 1 ||
        _relaxVideoModelItems.length <= index ||
        index < 0 ||
        _relaxVideoModelItems[index] == null ||
        _relaxVideoModelItems[index].images == null) {
      return 0;
    }
    return _relaxVideoModelItems[index].images.length;
  }

  String getUrl(int index) {
    if (_relaxVideoModelItems == null ||
        _relaxVideoModelItems.length < 1 ||
        _relaxVideoModelItems.length <= index ||
        index < 0 ||
        _relaxVideoModelItems[index] == null) {
      return "";
    }

    return _relaxVideoModelItems[index].url;
  }

  String getDesc(int index) {
    if (_relaxVideoModelItems == null ||
        _relaxVideoModelItems.length < 1 ||
        _relaxVideoModelItems.length < index ||
        index < 0) {
      return "";
    }
    return _relaxVideoModelItems[index].desc;
  }

  String getWho(int index) {
    if (_relaxVideoModelItems == null ||
        _relaxVideoModelItems.length < 1 ||
        _relaxVideoModelItems.length < index ||
        index < 0) {
      return "";
    }
    return "作者:" + _relaxVideoModelItems[index].who;
  }

  String getPublishedAt(int index) {
    if (_relaxVideoModelItems == null ||
        _relaxVideoModelItems.length < 1 ||
        _relaxVideoModelItems.length < index ||
        index < 0) {
      return "";
    }
    return "发布日期:" + _relaxVideoModelItems[index].publishedAt;
  }

  //ListView的Item
  Widget getItemUserDefine(BuildContext context, int index) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      textDirection: TextDirection.ltr,
      children: <Widget>[
        Text(
            "======================================================================="),
        new Column(
          children: <Widget>[
            new Padding(
                padding: const EdgeInsets.all(16),
                child: Text(getDesc(index), softWrap: true)),
            new Row(
              children: <Widget>[
                new Expanded(
                    child: new Padding(
                        padding: const EdgeInsets.fromLTRB(16, 5, 16, 0),
                        child: new Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text(getWho(index),
                                softWrap: true, textAlign: TextAlign.left))))
              ],
            ),
            new Row(
              children: <Widget>[
                new Expanded(
                    child: new Padding(
                        padding: const EdgeInsets.fromLTRB(16, 5, 16, 2),
                        child: new Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text(getPublishedAt(index),
                                softWrap: true, textAlign: TextAlign.left))))
              ],
            )
          ],
        ),
        new Column(
          children: new List.generate(getImageCount(index), (int imgIndex) {
            return Image.network(_relaxVideoModelItems[index].images[imgIndex]);
          }),
        ),
        new Row(
          children: <Widget>[
            new Expanded(
              child: new Padding(
                  padding: const EdgeInsets.fromLTRB(16, 5, 16, 10),
                  child: new Directionality(
                      textDirection: TextDirection.rtl,
                      child: new GestureDetector(
                        child: Text(
                          getUrl(index),
                          softWrap: true,
                          textAlign: TextAlign.left,
                          style: new TextStyle(
                              color: Color.alphaBlend(
                                  Color(0xff00ff00), Color(0xff000000))),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) =>
                                      new WebViewPage(getUrl(index))));
                        },
                      ))),
            )
          ],
        ),
      ],
    );
  }

  int getItemCount() {
    if (_relaxVideoModelItems != null) {
      return _relaxVideoModelItems.length;
    }
    return 0;
  }
}

void main() => runApp(new VideoPage());
