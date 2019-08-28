//view:listview
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/bean/ModeHelper.dart';
import 'package:flutter_app/bean/TodayGankBaseChildModel.dart';
import 'package:flutter_app/page/base_page_mixin.dart';
import 'package:flutter_app/page/webview_page.dart';
import 'package:flutter_app/utils/DownloadHelper.dart';

class TodayGankBaseChildPage extends StatefulWidget with BasePageMixin {
  TodayGankBaseChildPage({Key key}) : super(key: key);

  @override
  void set title(String _title) {
    // TODO: implement title
    super.title = _title;
  }

  @override
  void set items(List<BaseItemModel> _items) {
    // TODO: implement items
    super.items = _items;
  }

  @override
  State<StatefulWidget> createState() => new _MyListState();
}

//得到一个ListView
class _MyListState extends State<TodayGankBaseChildPage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;
  double _xHandImgOffset = 0.0;
  String tipsStr;
  var tipBannerTextArr = ["讲真，百度导航天下第一", "据说：百度导航将称霸世界", "传言：百度导航一统宇宙"];

  @override
  void initState() {
    super.initState();
    _animationController = new AnimationController(
        duration: const Duration(seconds: 2), vsync: this);
    _animation =
        new Tween<double>(begin: 5.0, end: -5.0).animate(_animationController)
          ..addListener(() {
            setState(() {
              _xHandImgOffset = _animation.value;
              print("_animation.value:$_xHandImgOffset");
            });
          })
          ..addStatusListener((status) {
            //print("status:$status");
          });
    // _animationController.repeat();
    _animationController.forward();
    tipsStr = tipBannerTextArr[Random().nextInt(tipBannerTextArr.length)];
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.items);
    return new Column(children: <Widget>[
      Text(tipsStr),
      new Flexible(
          child: new ListView.builder(
              itemCount: getItemCount(),
              itemBuilder: (context, index) {
                return getItemUserDefine(context, index);
              }))
    ]);
  }

  int getItemCount() {
    if (widget.items == null) {
      return 0;
    }
    return widget.items.length;
  }

  int getImageCount(int index) {
    if (ModeHelper.BENIFIT == widget.title) {
      if (widget.items == null ||
          widget.items.length < 1 ||
          widget.items.length <= index ||
          index < 0 ||
          widget.items[index] == null ||
          widget.items[index].url == null) {
        return 0;
      }
      return 1;
    } else if (widget.items == null ||
        widget.items.length < 1 ||
        widget.items.length <= index ||
        index < 0 ||
        widget.items[index] == null ||
        widget.items[index].images == null) {
      return 0;
    }
    return widget.items[index].images.length;
  }

  String getImageUrl(int itemIndex, int imgIndex) {
    if (ModeHelper.BENIFIT == widget.title) {
      if (widget.items == null ||
          widget.items.length < 1 ||
          widget.items.length <= itemIndex ||
          itemIndex < 0 ||
          widget.items[itemIndex] == null ||
          widget.items[itemIndex].url == null) {
        return "";
      }
      return widget.items[itemIndex].url;
    } else if (widget.items == null ||
        widget.items.length < 1 ||
        widget.items.length <= itemIndex ||
        itemIndex < 0 ||
        widget.items[itemIndex] == null ||
        widget.items[itemIndex].images == null ||
        widget.items[itemIndex].images.length <= imgIndex) {
      return "";
    }
    return widget.items[itemIndex].images[imgIndex];
    ;
  }

  String getUrl(int index) {
    if (widget.items == null ||
        widget.items.length < 1 ||
        widget.items.length <= index ||
        index < 0 ||
        widget.items[index] == null) {
      return "";
    }

    return widget.items[index].url;
  }

  String getDesc(int index) {
    if (widget.items == null ||
        widget.items.length < 1 ||
        widget.items.length < index ||
        index < 0) {
      return "";
    }
    return widget.items[index].desc;
  }

  String getWho(int index) {
    if (widget.items == null ||
        widget.items.length < 1 ||
        widget.items.length < index ||
        index < 0) {
      return "";
    }
    return "" + widget.items[index].who;
  }

  String getPublishedAt(int index) {
    if (widget.items == null ||
        widget.items.length < 1 ||
        widget.items.length < index ||
        index < 0) {
      return "";
    }
    return "" + widget.items[index].publishedAt.substring(0, 10);
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
          new Column(
            children: <Widget>[
              new Padding(
                  // 描述
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    getDesc(index),
                    softWrap: true,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
              new Row(
                // 作者
                children: <Widget>[
                  Container(
                    child: Image.asset('assets/images/author.png',
                        height: 16, width: 16),
                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  ),
                  new Expanded(
                      child: new Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                          child: new Directionality(
                              textDirection: TextDirection.rtl,
                              child: Text(getWho(index),
                                  softWrap: true, textAlign: TextAlign.left))))
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: new Row(
                  // 发布时间
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Image.asset('assets/images/calendar.png',
                          height: 16, width: 16),
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    ),
                    new Expanded(
                        child: new Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: new Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text(getPublishedAt(index),
                                    softWrap: true,
                                    textAlign: TextAlign.left))))
                  ],
                ),
              ),
              Container(
                  // 链接
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context)
                          .size
                          .width), // SizeUtils.getDevicesWidthPx()
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: new GestureDetector(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Image.asset('assets/images/link.png',
                                height: 16, width: 16),
                            Container(
                              margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                              constraints:
                                  BoxConstraints(maxWidth: getSuitableWidth()),
                              // SizeUtils.getDevicesWidthPx()
                              child: Text(
                                getUrl(index),
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                textAlign: TextAlign.left,
                                maxLines: 1,
                                style: new TextStyle(
                                    color: Colors.red,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context) {
                            return new GankWebViewPage(getUrl(index));
                          }));

                          /// 等同于下面的代码
                          /// ---start---
//                      Navigator.push(
//                          context,
//                          new MaterialPageRoute(
//                              builder: (context) =>
//                                  new WebViewPage(getUrl(index))));
                          /// ---end---
                        },
                      ))),
            ],
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
            child: new Column(
              // 图片
              children: new List.generate(getImageCount(index), (int imgIndex) {
                String url = getImageUrl(index, imgIndex);
                return new GestureDetector(
                    child: Image.network(url),
                    onLongPress: () {
                      if (ModeHelper.BENIFIT == widget.title) {
                        DownloadHelper.onImageLongPressed(context, url);
                      } else {
                        String title = widget.title;
                        print("title is $title");
                      }
                    });
              }),
            ),
          ),
          new Divider(
            height: 1,
            color: Color(0x00000000),
          ),
        ],
      ),
    );
  }

  double getSuitableWidth() {
    double width = MediaQuery.of(context).size.width;
    //print("getSuitableWidth,$width");
    width = width / 7.0 * 5.0;
    //print("getSuitableWidth,$width");
    return width;
  }
}
