import 'package:flutter/material.dart';

class VideoPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new VideoPageState();
}
class VideoPageState extends State<VideoPage> {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('想法'),
          actions: <Widget>[
            new Container()
          ],
        ),
        body: new Center(
          child: null,
        ),
      ),
    );
  }
}