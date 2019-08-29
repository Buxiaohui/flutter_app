import 'package:flutter/material.dart';

class MineSingleLineWidget extends StatefulWidget {
  String imgLocalPath;
  String mainTitle;

  MineSingleLineWidget(this.imgLocalPath, this.mainTitle);

  @override
  State<StatefulWidget> createState() => new MineTwoLineWidgetState();
}

class MineTwoLineWidgetState extends State<MineSingleLineWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("buxiaohui $widget");
    print("buxiaohui " + widget.mainTitle);
    print("buxiaohui " + widget.imgLocalPath);

    return Container(
      height: 60,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Stack(children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
//                textDirection: TextDirection.ltr,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  widget.mainTitle,
                  textDirection: TextDirection.ltr,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Image.asset(
              "assets/images/arrow.png",
              width: 20,
              height: 20,
            ),
          ),
        ]),
      ),
    );
  }
}

void main() => runApp(MineSingleLineWidget("assets/images/arrow.png", "主标题"));
