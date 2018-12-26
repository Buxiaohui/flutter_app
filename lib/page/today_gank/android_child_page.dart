//view:listview
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/bean/AndroidModel.dart';
import 'package:flutter_app/page/webview_page.dart';
import 'package:flutter_app/utils/size_utils.dart';

class AndroidPage extends StatefulWidget {
  List<AndroidModel> items;

  AndroidPage({Key key, this.items}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _MyListState();
}

//得到一个ListView
class _MyListState extends State<AndroidPage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<int> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = new AnimationController(
        duration: Duration(milliseconds: 10), vsync: this);
    _animation = new Tween(begin: 0, end: 100).animate(_animationController)
      ..addListener(() {
        setState(() {
          print("_animation.value:$_animation.value");
        });
      })
      ..addStatusListener((status) {
        print("status:$status");
      });
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.items);
    return new Column(children: <Widget>[
      Text("############## Android ##############"),
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
    if (widget.items == null ||
        widget.items.length < 1 ||
        widget.items.length <= index ||
        index < 0 ||
        widget.items[index] == null ||
        widget.items[index].images == null) {
      return 0;
    }
    return widget.items[index].images.length;
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
    return "作者:" + widget.items[index].who;
  }

  String getPublishedAt(int index) {
    if (widget.items == null ||
        widget.items.length < 1 ||
        widget.items.length < index ||
        index < 0) {
      return "";
    }
    return "发布日期:" + widget.items[index].publishedAt;
  }

  //ListView的Item
  Widget getItemUserDefine(BuildContext context, int index) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      textDirection: TextDirection.ltr,
      children: <Widget>[
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
            return Image.network(widget.items[index].images[imgIndex]);
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
                      Text("gayhub:"),
                      Container(
                        constraints: BoxConstraints(
                            maxWidth: getSuitableWidth()), // SizeUtils.getDevicesWidthPx()
                        child: Text(
                          getUrl(index),
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          textAlign: TextAlign.left,
                          maxLines: 3,
                          style: new TextStyle(
                              color: Color.alphaBlend(
                                  Color(0xffF08080), Color(0xff000000)),
                              decoration: TextDecoration.underline),
                        ),
                      ),
                      Padding(
                        child: Image.asset('assets/images/img_hand_2_left.png',
                            height: 16, width: 16),
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
    width =  width / 7.0 * 5.0;
    print("getSuitableWidth,$width");
    return width ;
  }
}
