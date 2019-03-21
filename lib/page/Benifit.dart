import 'package:flutter/material.dart';

class Benifit extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _BenifitState();
}

class _BenifitState extends State<Benifit> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('福利'),
          actions: <Widget>[new Container()],
        ),
        body: new Center(
          child: null,
        ),
      ),
    );
  }
}
