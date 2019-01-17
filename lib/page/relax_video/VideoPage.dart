import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/bean/RelaxVideoModels.dart';
import 'package:flutter_app/bean/TodayGankBaseChildModel.dart';
import 'package:flutter_app/net/NetConstants.dart';
import 'package:flutter_app/net/NetController.dart';
import 'package:flutter_app/page/webview_page.dart';

// TOTO 加载更多
class VideoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new VideoPageState();
}

class VideoPageState extends State<VideoPage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;
  double _xHandImgOffset;
  RelaxVideoModels _relaxVideoModels;
  List<BaseItemModel> _items;
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
        _items = _relaxVideoModels.results;
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
    _animationController = new AnimationController(
        duration: const Duration(seconds: 2), vsync: this);
    _animation =
        new Tween<double>(begin: 5.0, end: -5.0).animate(_animationController)
          ..addListener(() {
            print("_animation.value:$_animation.value");
            setState(() {
              _xHandImgOffset = _animation.value;
            });
          })
          ..addStatusListener((status) {
            print("status:$status");
          });
    //_animationController.repeat();
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

  int getItemCount() {
    if (_items == null) {
      return 0;
    }
    return _items.length;
  }

  int getImageCount(int index) {
    if (_items == null ||
        _items.length < 1 ||
        _items.length <= index ||
        index < 0 ||
        _items[index] == null ||
        _items[index].images == null) {
      return 0;
    }
    return _items[index].images.length;
  }

  String getUrl(int index) {
    if (_items == null ||
        _items.length < 1 ||
        _items.length <= index ||
        index < 0 ||
        _items[index] == null) {
      return "";
    }

    return _items[index].url;
  }

  String getDesc(int index) {
    if (_items == null ||
        _items.length < 1 ||
        _items.length < index ||
        index < 0) {
      return "";
    }
    return _items[index].desc;
  }

  String getWho(int index) {
    if (_items == null ||
        _items.length < 1 ||
        _items.length < index ||
        index < 0) {
      return "";
    }
    return "作者:" + _items[index].who;
  }

  String getPublishedAt(int index) {
    if (_items == null ||
        _items.length < 1 ||
        _items.length < index ||
        index < 0) {
      return "";
    }
    return "发布日期:" + _items[index].publishedAt;
  }

  //ListView的Item
  Widget getItemUserDefine(BuildContext context, int index) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      textDirection: TextDirection.ltr,
      children: <Widget>[
        new Column(
          children: <Widget>[
            new Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  getDesc(index),
                  softWrap: true,
                )),
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
            return Image.network(_items[index].images[imgIndex]);
          }),
        ),
        Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context)
                    .size
                    .width), // SizeUtils.getDevicesWidthPx()
            child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 5, 16, 10),
                child: new GestureDetector(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text("link:"),
                      Container(
                        constraints:
                            BoxConstraints(maxWidth: getSuitableWidth()),
                        // SizeUtils.getDevicesWidthPx()
                        child: Text(
                          getUrl(index),
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          textAlign: TextAlign.left,
                          maxLines: 3,
                          style: new TextStyle(
                              color: Colors.red,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                      Padding(
                        child: Transform.translate(
                          offset: Offset(_xHandImgOffset, 0.0),
                          child: Image.asset(
                              'assets/images/img_hand_2_left.png',
                              height: 16,
                              width: 16),
                        ),
                        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) =>
                                new WebViewPage(getUrl(index))));
                  },
                ))),
        new Divider(
          height: 1,
          color: Color(0x66000000),
        ),
      ],
    );
  }

  double getSuitableWidth() {
    double width = MediaQuery.of(context).size.width;
    print("getSuitableWidth,$width");
    width = width / 7.0 * 5.0;
    print("getSuitableWidth,$width");
    return width;
  }
}

void main() => runApp(new VideoPage());
