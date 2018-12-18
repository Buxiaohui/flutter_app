import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailPage extends StatefulWidget {
  final String title;

  DetailPage({Key key, this.title}) : super(key: key);

  @override
  _DetailPageState createState() {
    return _DetailPageState();
  }
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    var widget = new Container(
        decoration: new BoxDecoration(
          color: Colors.white,
        ),
        padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 15.0),
        child: new Column(
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
//            new Row(
//              textDirection: TextDirection.ltr,
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                new Expanded(
//                    child: new Column(
//                  children: <Widget>[
//                    new Container(
//                      padding: new EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
//                      color: Colors.lightBlue,
//                      child: new Row(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        textDirection: TextDirection.ltr,
//                        children: <Widget>[
//                          Text(
//                            'detail page',
//                            textDirection: TextDirection.ltr,
//                            style: new TextStyle(color: Colors.black),
//                          ),
//                          new Image.asset(
//                            'images/ic_detail.png',
//                            height: 32,
//                            width: 32,
//                          ),
//                        ],
//                      ),
//                    )
//                  ],
//                ))
//              ],
//            ),
//            // 详情 TODO
//            new Row(
//              mainAxisAlignment: MainAxisAlignment.center,
//              textDirection: TextDirection.ltr,
//              children: <Widget>[
//                Expanded(
//                  child: new Image.network(
//                      "http://b-ssl.duitang.com/uploads/item/201805/27/20180527001952_kzxlx.thumb.700_0.jpeg"),
//                )
//              ],
//            ),
//            // 拓展listview TODO
            new MyListView(items:getData())
          ],
        ));
    return widget;
  }
}

//view:listview
class MyListView extends StatefulWidget {
  final List<ItemData> items;

  MyListView({Key key, @required this.items}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new MyListState();
}

//得到一个ListView
class MyListState extends State<MyListView> {

  @override
  Widget build(BuildContext context) {
    print(widget.items);
    return new Flexible(child:
       new ListView.builder(itemCount: widget.items.length, itemBuilder: getItemUserDefine)
    );
  }

  //ListView的Item
  Widget getItemUserDefine(BuildContext context, int index) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      textDirection: TextDirection.ltr,
      children: <Widget>[
        Image.network(widget.items[index]._url),
        Text(widget.items[index]._desc)
      ],
    );
  }
}

List<ItemData> getData() {
  for (var i = 0; i < urlList.length; i++) {
    dataList.add(new ItemData()
      .._desc = "pic-$i"
      .._index = i
      .._url = "https://timgsa.baidu"
          ".com/timg?image&quality=80&size=b9999_10000&sec=1543221361645&di"
          "=216689053ea7f8cdec0002926abeee5b&imgtype=0&src=http%3A%2F"
          "%2Fpic1.win4000.com%2Fwallpaper%2F5%2F598abb9ab5116.jpg");
    //.._url = urlList[new Random().nextInt(urlList.length-1)]);
  }
  return dataList;
}

var urlList = [
  "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec"
      "=1543221252127&di=647b5a86a193d4bf4aa0cedbdb15e140&imgtype=0&src=http%3A%2F%2Fpc.073img.com%2Fuploads%2Ftuji%2F20170728%2F109fbf35f0a361812cff604309b7443c.jpg",
  "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec"
      "=1543"
      "221361646&di=cd6acd73ffbdc7cb8b27bf70ff46afda&imgtype=0&src=http%3A%2F%2Fi1.hdslb.com%2Fbfs%2Farchive%2F1206957fced9e18fc1a385d23b880cbb92996d32.jpg",
  "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1543221361645&di=216689053ea7f8cdec0002926abeee5b&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2F5%2F598abb9ab5116.jpg",
  "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1543221361644&di=934a24ebce0eb8ae4bb382b25728d32c&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2F5%2F598abba032b0b.jpg",
  "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1543221552351&di=4ac960ddbbb5b56d7322981d684c1368&imgtype=0&src=http%3A%2F%2Fdb.gamedog.cn%2Fuploads%2Fwzry%2F7e04aa5310b8e0002214646670856601.jpg",
  "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec"
      "=1543221552350&di=80e2c6d6dfe94c9e0478b625d168fbe4&imgtype=0&src=http"
      "%3A%2F%2Fcyimg.quji.com%2Fnewsimg%2F2015%2F09%2F25%2F604dfe25ac52.png"
];
var dataList = List<ItemData>();

class ItemData {
  String _url;

  String get url => _url;

  set url(String value) {
    _url = value;
  }

  String _desc;
  int _index;

  String get desc => _desc;

  set desc(String value) {
    _desc = value;
  }

  int get index => _index;

  set index(int value) {
    _index = value;
  }

  @override
  String toString() {
    return 'ItemData{_url: $_url, _desc: $_desc, _index: $_index}';
  }

}

void main() {
  debugPrint("window.physicalSize.width ${window.physicalSize.width}");
  debugPrint("window.physicalSize.height ${window.physicalSize.height}");
  runApp(new DetailPage());
}
