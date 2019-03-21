import 'package:flutter/material.dart';

class RelaxReadPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new RelaxReadPageState();
}

class RelaxReadPageState extends State<RelaxReadPage> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
          appBar: new AppBar(
        title: new Text('市场'),
        // 后面的省略
        // ......
      )),
    );
  }
}
