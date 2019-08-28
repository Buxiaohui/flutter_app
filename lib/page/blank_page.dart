import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/**
 * 空白页，error页，loading页
 */
class BlankPage extends StatefulWidget {
  static const int LOADING = 0;
  static const int FAIL = 1;
  static const int SUCCESS = 2;
  static const int UNKNOWN = 3;
  void main() => runApp(new BlankPage());
  int pageState;

  BlankPage({int pageState}) : this.pageState = pageState;

  @override
  State<StatefulWidget> createState() => new BlankPageState();
}

class BlankPageState extends State<BlankPage> {
  @override
  Widget build(BuildContext context) {
    int pageState = widget.pageState;
    print("BlankPage State is $pageState");
    switch (widget.pageState) {
      case BlankPage.LOADING:
        return Text("loading......");
      case BlankPage.SUCCESS:
        return Text("success......");
      case BlankPage.FAIL:
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/error.png', width: 100, height: 100),
              Text("呐，发生了错误……我也不想的")
            ],
          ),
        );
      default:
        return Text("sorry......");
    }
  }
}
