import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatListViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  // 可以通过state获取到一些数据
  // 需要提供setter/getter方法或者公开的属性(不推荐)
  ChatScreenState chatScreenState;

  @override
  State createState() {
    chatScreenState = new ChatScreenState();
    return chatScreenState;
  }
}

class ChatScreenState extends State<ChatScreen> {
  var _testParam; // 提供setter/getter 可被持有者获取
  get getTestParamMethod => _testParam;

  set setTestParamMethod(num val) => _testParam = val;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('列表页'),
      ),
      body: new Column(
        children: <Widget>[
          new Flexible(
              child: new ListView.builder(
            padding: new EdgeInsets.all(8.0),
            reverse: false,
            itemBuilder: (_, int index) => _messages[index],
            itemCount: _messages.length,
          ))
        ],
      ),
    );
//    return new ListView.builder(
//      padding: new EdgeInsets.all(8.0),
//      reverse: false,
//      itemBuilder: (_, int index) => _messages[index],
//      itemCount: _messages.length,
//    );
  }
}

const String _name = "what is it?";

class ChatMessage extends StatelessWidget {
  final String text;
  final int index;

  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: new InkWell(
          child: new Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Container(
                  margin: const EdgeInsets.only(right: 16.0),
                  child: new CircleAvatar(child: new Text(_name[0])),
                ),
                new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(_name,
                          style: Theme.of(context).textTheme.display1),
                      new Text(_name, style: TextStyle(fontSize: 20)),
                      new Container(
                        margin: const EdgeInsets.only(top: 5.0),
                        child: new Text(text, style: TextStyle(fontSize: 20)),
                      )
                    ])
              ]),
          onTap: () {
            print("$text $index");
          },
        ));
  }

  //ChatMessage(this.text, this.ind);
  ChatMessage({this.text, this.index});
}

final _messages = new List<ChatMessage>.generate(
    10000, (i) => new ChatMessage(text: "item $i", index: i));

void main() {
  runApp(new ChatListViewPage());
}
