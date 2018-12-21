import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/testflutter/example_page.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

void main() => runApp(WebViewPage(""));

class WebViewPage extends StatefulWidget {
  String url;

  WebViewPage(this.url);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
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
    return new MaterialApp(
      title: 'Flutter WebView Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (_) => new WebviewScaffold(
              url: widget.url,
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
            ),
      },
    );
  }
}
