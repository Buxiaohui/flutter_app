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
  double _xHandImgOffset = 0;
  List<BaseItemModel> _items;
  int _page = 1;
  int _count = 10;

  Future<void> _request(int _requestType) async {
    if (_requestType == 0) {
      _count = 10;
      _page = 1;
    } else {
      _page++;
    }
    // 网络请求
    String finalInitUrl =
        NetConstants.RELAX_VIDEO_BASE_URL + "count/$_count/page/$_page";
    print("refresh,firatInitUrl,$finalInitUrl");
    NetController.request(finalInitUrl, _requestType,
        (request, response, bodyData, requestType) {
      if (response.statusCode != null) {
        // TODO
        print("getMore,maybe success");
      } else {
        print("getMore,fail");
        // error
      }
      try {
        RelaxVideoModels _relaxVideoModels =
            RelaxVideoModels.fromJson(json.decode(bodyData));
        if (requestType == 0) {
          _items = _relaxVideoModels.results;
        } else {
          _items.addAll(_relaxVideoModels.results);
        }
      } catch (exception) {
        print("refresh,error,$exception");
      }
      // flutter 通过这种方式更新UI
      setState(() {});
    });
  }

  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController =
        new ScrollController(debugLabel: "debug_hui", initialScrollOffset: 0.0);
    _animationController = new AnimationController(
        duration: const Duration(seconds: 2), vsync: this);
    _animation =
        new Tween<double>(begin: 5.0, end: -5.0).animate(_animationController)
          ..addListener(() {
            // print("_animation.value:$_animation.value");
            setState(() {
              print("_animation.value:$_animation.value");
              _xHandImgOffset = _animation.value;
            });
          })
          ..addStatusListener((status) {
            print("status:$status");
          });
    //_animationController.repeat();
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
        appBar: AppBar(
          title: Text("视频"),
        ),
        body: RefreshIndicator(
          child: new ListView.builder(
              controller: _scrollController,
              itemCount: _getItemCount(),
              itemBuilder: (context, index) {
                return _getItemUserDefine(context, index);
              }),
          onRefresh: () {
            _request(0);
          },
        ),
      ),
    );
  }

  int _getItemCount() {
    if (_items == null) {
      return 0;
    }
    return _items.length;
  }

  int _getImageCount(int index) {
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

  String _getUrl(int index) {
    if (_items == null ||
        _items.length < 1 ||
        _items.length <= index ||
        index < 0 ||
        _items[index] == null) {
      return "";
    }

    return _items[index].url;
  }

  String _getDesc(int index) {
    if (_items == null ||
        _items.length < 1 ||
        _items.length < index ||
        index < 0) {
      return "";
    }
    return _items[index].desc;
  }

  String _getWho(int index) {
    if (_items == null ||
        _items.length < 1 ||
        _items.length < index ||
        index < 0) {
      return "";
    }
    return "作者:" + _items[index].who;
  }

  String _getPublishedAt(int index) {
    if (_items == null ||
        _items.length < 1 ||
        _items.length < index ||
        index < 0) {
      return "";
    }
    String publishTime = _items[index].publishedAt;
    if (publishTime != null && _items[index].publishedAt.length >= 10) {
      return "发布日期:" + publishTime.substring(0, 10);
    }
    return "";
  }

  //ListView的Item
  Widget _getItemUserDefine(BuildContext context, int index) {
    return Card(
      margin: EdgeInsets.fromLTRB(8, 4, 8, 4),
      elevation: 4,
      child: getItemUserDefineInner(context, index),
    );
  }

  Widget getItemUserDefineInner(BuildContext context, int index) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      textDirection: TextDirection.ltr,
      children: <Widget>[
        new Column(
          children: <Widget>[
            new Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  _getDesc(index),
                  softWrap: true,
                )),
            new Row(
              children: <Widget>[
                new Expanded(
                    child: new Padding(
                        padding: const EdgeInsets.fromLTRB(16, 5, 16, 0),
                        child: new Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text(_getWho(index),
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
                            child: Text(_getPublishedAt(index),
                                softWrap: true, textAlign: TextAlign.left))))
              ],
            )
          ],
        ),
        new Column(
          children: new List.generate(_getImageCount(index), (int imgIndex) {
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
                            BoxConstraints(maxWidth: _getSuitableWidth()),
                        // SizeUtils.getDevicesWidthPx()
                        child: Text(
                          _getUrl(index),
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          textAlign: TextAlign.left,
                          maxLines: 3,
                          style: new TextStyle(
                              color: Colors.red,
                              decoration: TextDecoration.underline),
                        ),
                      ),
//                      Padding(
//                        child: Transform.translate(
//                          offset: Offset(_xHandImgOffset, 0.0),
//                          child: Image.asset(
//                              'assets/images/img_hand_2_left.png',
//                              height: 16,
//                              width: 16),
//                        ),
//                        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) =>
                                new GankWebViewPage(_getUrl(index))));
                  },
                ))),
      ],
    );
  }

  double _getSuitableWidth() {
    double width = MediaQuery.of(context).size.width;
    print("getSuitableWidth,$width");
    width = width / 7.0 * 5.0;
    print("getSuitableWidth,$width");
    return width;
  }
}

void main() => runApp(new VideoPage());
