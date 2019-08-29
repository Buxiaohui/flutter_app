import 'package:flutter/material.dart';

class MineTwoLineWidget extends StatefulWidget {
  String imgLocalPath;
  String mainTitle;
  String subTitle;

  MineTwoLineWidget(this.imgLocalPath, this.mainTitle, this.subTitle);

  @override
  State<StatefulWidget> createState() => new MineSingleLineWidgetState();
}

class MineSingleLineWidgetState extends State<MineTwoLineWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("buxiaohui $widget");
    print("buxiaohui " + widget.mainTitle);
    print("buxiaohui " + widget.subTitle);
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
                Align(
                  child: Text(
                    widget.mainTitle,
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  alignment: Alignment.centerLeft,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Align(
                    child: Text(
                      widget.subTitle,
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.left,
                    ),
                    alignment: Alignment.centerLeft,
                  ),
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

void main() =>
    runApp(MineTwoLineWidget("assets/images/arrow.png", "主标题", "副标题"));
