import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

void main() => runApp(GankWebViewPage(""));

class GankWebViewPage extends StatefulWidget {
  String url;

  GankWebViewPage(this.url);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<GankWebViewPage> {
  FlutterWebviewPlugin flutterWebviewPlugin;

  @override
  void initState() {
    super.initState();
    flutterWebviewPlugin = new FlutterWebviewPlugin();

    // 监听器
    flutterWebviewPlugin.onUrlChanged.listen((String url) {
      print("initState url, $url");
    });
    flutterWebviewPlugin.onScrollXChanged.listen(_onData,
        onError: _onError, onDone: _onDone, cancelOnError: true);
  }

  _onDone() {}

  _onError(Object event) {}

  _onData(Object event) {}

  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
      url: widget.url,
      appBar: new AppBar(
        title: const Text('Widget webview'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                flutterWebviewPlugin.close();
              },
              tooltip: MaterialLocalizations.of(context).backButtonTooltip,
            );
          },
        ),
      ),
      withZoom: true,
      withLocalStorage: true,
      // hidden 设置为true后在loading时会显示默认loading页面
      hidden: true,
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
