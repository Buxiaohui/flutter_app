//view:listview
import 'package:flutter/widgets.dart';
import 'package:flutter_app/bean/AndroidModel.dart';
import 'package:flutter_app/bean/IOSModel.dart';

class IOSPage extends StatefulWidget {
  List<IOSModel> items;

  IOSPage({Key key, this.items}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _MyListState();
}

//得到一个ListView
class _MyListState extends State<IOSPage> {
  @override
  Widget build(BuildContext context) {
    print(widget.items);
    return new Column(children: <Widget>[
      Text("############## IOS ##############"),
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
      mainAxisAlignment: MainAxisAlignment.start,
      textDirection: TextDirection.ltr,
      children: <Widget>[
        Text(
            "======================================================================="),
        new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Padding(
                padding: const EdgeInsets.all(16),
                child: Text(getDesc(index),
                    softWrap: true, textAlign: TextAlign.left)),
            new Padding(
                padding: const EdgeInsets.all(16),
                child: Text(getWho(index),
                    softWrap: true, textAlign: TextAlign.left)),
            new Padding(
                padding: const EdgeInsets.all(16),
                child: new Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(getPublishedAt(index),
                        softWrap: true, textAlign: TextAlign.right)))
          ],
        ),
        new Column(
          children: new List.generate(getImageCount(index), (int imgIndex) {
            return Image.network(widget.items[index].images[imgIndex]);
          }),
        ),
        Text(widget.items[index].url)
      ],
    );
  }
}

//int typeImage = 1;
//int typeTitle = 2;
//int typeURL = 3;
//int typeDesc = 4;
//void main() {
//  runApp(new TodayAndroidChildPage());
//}
