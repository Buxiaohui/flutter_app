import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

void main() => runApp(WebViewApp());

class WebViewApp extends StatefulWidget {
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<WebViewApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   return new MaterialApp(
      routes: {
        "/": (_) =>
        new WebviewScaffold(
          url: "https://v.douyin.com/8AQBdu/",
          appBar: new AppBar(
            title: new Text("Widget webview"),
          ),
        ),
      },
    );
  }
}
