//view:listview
import 'package:flutter/widgets.dart';
import 'package:flutter_app/bean/AndroidModel.dart';
import 'package:flutter_app/bean/StretchResModel.dart';

class StretchResPage extends StatefulWidget {
  List<StretchResModel> items;

  StretchResPage({Key key, this.items}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _MyListState();
}

//得到一个ListView
class _MyListState extends State<StretchResPage> {
  @override
  Widget build(BuildContext context) {
    print(widget.items);
    return new Column(children: <Widget>[
      Text("############## 拓展资源 ##############"),
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

    return "gayhub:" + widget.items[index].url;
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
            return Image.network(widget.items[index].images[imgIndex]);
          }),
        ),
        new Row(
          children: <Widget>[
            new Expanded(
                child: new Padding(
                    padding: const EdgeInsets.fromLTRB(16, 5, 16, 10),
                    child: new Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(getUrl(index),
                            softWrap: true, textAlign: TextAlign.left,style: new TextStyle(color: Color.alphaBlend(Color(0xff00ff00), Color(0xff000000))),))))
          ],
        ),
      ],
    );
  }
}
