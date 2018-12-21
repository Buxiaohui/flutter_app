import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/testflutter/example_page.dart';
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
    final flutterWebviewPlugin = new FlutterWebviewPlugin();

    // 监听器
    flutterWebviewPlugin.onUrlChanged.listen((String url) {
      print("initState url, $url");
    });
  }

  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
      url: "https://v.douyin.com/8AQBdu/",
      appBar: new AppBar(
        title: const Text('Widget webview'),
      ),
      withZoom: true,
      withLocalStorage: true,
      // hidden 设置为true后在loading时会显示默认loading页面
      hidden: false,
      // initialChild设置以后，在loading时会显示自定义的loading页面
      initialChild: Container(
        color: Colors.redAccent,
        child: const Center(
          child: Text('Waiting.....'),
        ),
      ),
    );
  }
}
