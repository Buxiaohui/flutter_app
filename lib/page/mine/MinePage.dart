import 'package:flutter/material.dart';
import 'package:flutter_app/bean/MineItemMode.dart';
import 'package:flutter_app/page/mine/MineTwoLineWidget.dart';

import 'MineSingleLineWidget.dart';

class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new MinePageState();
}

class MinePageState extends State<MinePage> {
  ScrollController _scrollController;
  List<MineItemMode> _datas = List<MineItemMode>();

  @override
  void initState() {
    super.initState();
    initData();
    _scrollController =
        ScrollController(debugLabel: "relax_read", initialScrollOffset: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('我的'),
          actions: <Widget>[new Container()],
        ),
        body: ListView.separated(
            separatorBuilder: (BuildContext c, int index) => new Divider(),
            controller: _scrollController,
            itemCount: _getItemCount(),
            itemBuilder: (context, index) {
              MineItemMode mode = _datas[index];
              return _getItemUserDefine(context, index, mode);
            }),
      ),
    );
  }

  void initData() {
    MineHeadData head = MineHeadData();
    head.type = 0;
    head.index = 0;
    head.mainTitle = "我是西门吹雪";
    head.subTitle = "微信号131-4593-8347";
    head.iconLocalPath = "assets/images/my_head.png";
    _datas.add(head);

    CollectData collectData = CollectData();
    collectData.type = 1;
    collectData.index = 1;
    collectData.mainTitle = "我的收藏";
    collectData.subTitle = "查看您收藏的内容";
    collectData.iconLocalPath = "assets/images/collect.png";
    collectData.moreIconLocalPath = "assets/images/arrow.png";
    _datas.add(collectData);

    AboutData setting = AboutData();
    setting.type = 2;
    setting.index = 2;
    setting.mainTitle = "设置";
    setting.subTitle = "";
    setting.moreIconLocalPath = "assets/images/arrow.png";
    _datas.add(setting);

    AboutData aboutData = AboutData();
    aboutData.type = 2;
    aboutData.index = 3;
    aboutData.mainTitle = "关于";
    aboutData.subTitle = "";
    aboutData.iconLocalPath = "assets/images/about.png";
    aboutData.moreIconLocalPath = "assets/images/arrow.png";
    _datas.add(aboutData);
    _datas.add(aboutData);
    _datas.add(aboutData);
    _datas.add(aboutData);
    _datas.add(aboutData);
  }

  int _getItemCount() {
    return _datas.length;
  }

  Widget _getItemUserDefine(
      BuildContext context, int index, MineItemMode mode) {
    if (mode.type == 0) {
      return Center(
        child: Center(
          child: Stack(
            children: <Widget>[
              Positioned(
                child: Image.asset("assets/images/head_bg.jpeg"),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                  child: Column(children: <Widget>[
                    ClipOval(
                      child: Image.asset(
                        mode.iconLocalPath,
                        height: 50,
                        width: 50,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        mode.mainTitle,
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        mode.subTitle,
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      );
    } else if (mode.type == 1) {
      CollectData collectData = mode as CollectData;
      return MineTwoLineWidget(
          collectData.moreIconLocalPath, mode.mainTitle, mode.subTitle);
    } else if (mode.type == 2) {
      // AboutData aboutData = mode as AboutData;
      return MineSingleLineWidget(
          (mode as AboutData).moreIconLocalPath, mode.mainTitle);
    } else {
      return Text("unknown");
    }
  }
}
