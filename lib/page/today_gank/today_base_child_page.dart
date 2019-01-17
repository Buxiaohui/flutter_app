//view:listview
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/bean/ModeHelper.dart';
import 'package:flutter_app/bean/TodayGankBaseChildModel.dart';
import 'package:flutter_app/page/webview_page.dart';
import 'package:flutter_app/utils/DownloadHelper.dart';
import 'package:flutter_app/utils/Md5Helper.dart';
import 'package:flutter_app/utils/PathHelper.dart';
import 'package:simple_permissions/simple_permissions.dart';

class TodayGankBaseChildPage extends StatefulWidget {
  List<BaseItemModel> items;
  String title;

  TodayGankBaseChildPage({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _MyListState();
}

//得到一个ListView
class _MyListState extends State<TodayGankBaseChildPage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;
  double _xHandImgOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _animationController = new AnimationController(
        duration: const Duration(seconds: 2), vsync: this);
    _animation =
        new Tween<double>(begin: 5.0, end: -5.0).animate(_animationController)
          ..addListener(() {
            setState(() {
              _xHandImgOffset = _animation.value;
              print("_animation.value:$_xHandImgOffset");
            });
          })
          ..addStatusListener((status) {
            //print("status:$status");
          });
    // _animationController.repeat();
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.items);
    return new Column(children: <Widget>[
      Text("-----我不管我要做一楼----"),
      new Flexible(
          child: new ListView.builder(
              itemCount: getItemCount(),
              itemBuilder: (context, index) {
                return getItemUserDefine(context, index);
              }))
    ]);
  }

  int getItemCount() {
    if (widget.items == null) {
      return 0;
    }
    return widget.items.length;
  }

  int getImageCount(int index) {
    if (ModeHelper.BENIFIT == widget.title) {
      if (widget.items == null ||
          widget.items.length < 1 ||
          widget.items.length <= index ||
          index < 0 ||
          widget.items[index] == null ||
          widget.items[index].url == null) {
        return 0;
      }
      return 1;
    } else if (widget.items == null ||
        widget.items.length < 1 ||
        widget.items.length <= index ||
        index < 0 ||
        widget.items[index] == null ||
        widget.items[index].images == null) {
      return 0;
    }
    return widget.items[index].images.length;
  }

  String getImageUrl(int itemIndex, int imgIndex) {
    if (ModeHelper.BENIFIT == widget.title) {
      if (widget.items == null ||
          widget.items.length < 1 ||
          widget.items.length <= itemIndex ||
          itemIndex < 0 ||
          widget.items[itemIndex] == null ||
          widget.items[itemIndex].url == null) {
        return "";
      }
      return widget.items[itemIndex].url;
    } else if (widget.items == null ||
        widget.items.length < 1 ||
        widget.items.length <= itemIndex ||
        itemIndex < 0 ||
        widget.items[itemIndex] == null ||
        widget.items[itemIndex].images == null ||
        widget.items[itemIndex].images.length <= imgIndex) {
      return "";
    }
    return widget.items[itemIndex].images[imgIndex];
    ;
  }

  String getUrl(int index) {
    if (widget.items == null ||
        widget.items.length < 1 ||
        widget.items.length <= index ||
        index < 0 ||
        widget.items[index] == null) {
      return "";
    }

    return widget.items[index].url;
  }

  String getDesc(int index) {
    if (widget.items == null ||
        widget.items.length < 1 ||
        widget.items.length < index ||
        index < 0) {
      return "";
    }
    return widget.items[index].desc;
  }

  String getWho(int index) {
    if (widget.items == null ||
        widget.items.length < 1 ||
        widget.items.length < index ||
        index < 0) {
      return "";
    }
    return "作者:" + widget.items[index].who;
  }

  String getPublishedAt(int index) {
    if (widget.items == null ||
        widget.items.length < 1 ||
        widget.items.length < index ||
        index < 0) {
      return "";
    }
    return "发布日期:" + widget.items[index].publishedAt;
  }

  //ListView的Item
  Widget getItemUserDefine(BuildContext context, int index) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      textDirection: TextDirection.ltr,
      children: <Widget>[
        new Column(
          children: <Widget>[
            new Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  getDesc(index),
                  softWrap: true,
                )),
            new Row(
              children: <Widget>[
                new Expanded(
                    child: new Padding(
                        padding: const EdgeInsets.fromLTRB(16, 5, 16, 0),
                        child: new Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text(getWho(index),
                                softWrap: true, textAlign: TextAlign.left))))
              ],
            ),
            new Row(
              children: <Widget>[
                new Expanded(
                    child: new Padding(
                        padding: const EdgeInsets.fromLTRB(16, 5, 16, 2),
                        child: new Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text(getPublishedAt(index),
                                softWrap: true, textAlign: TextAlign.left))))
              ],
            )
          ],
        ),
        new Column(
          children: new List.generate(getImageCount(index), (int imgIndex) {
            String url = getImageUrl(index, imgIndex);
            return new GestureDetector(
                child: Image.network(url),
                onLongPress: () {
                  if (ModeHelper.BENIFIT == widget.title) {
                    onImageLongPressed(url);
                  } else {
                    String title = widget.title;
                    print("title is $title");
                  }
                });
          }),
        ),
        Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context)
                    .size
                    .width), // SizeUtils.getDevicesWidthPx()
            child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 5, 16, 10),
                child: new GestureDetector(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text("link:"),
                      Container(
                        constraints:
                            BoxConstraints(maxWidth: getSuitableWidth()),
                        // SizeUtils.getDevicesWidthPx()
                        child: Text(
                          getUrl(index),
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          textAlign: TextAlign.left,
                          maxLines: 3,
                          style: new TextStyle(
                              color: Colors.red,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                      Padding(
                        child: Transform.translate(
                          offset: Offset(_xHandImgOffset, 0.0),
                          child: Image.asset(
                              'assets/images/img_hand_2_left.png',
                              height: 16,
                              width: 16),
                        ),
                        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) =>
                                new WebViewPage(getUrl(index))));
                  },
                ))),
        new Divider(
          height: 1,
          color: Color(0x66000000),
        ),
      ],
    );
  }

  Future<bool> onImageLongPressed(String url) async {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
                title: new Text('Download'),
                content: new Text('下载图片到本地'),
                actions: <Widget>[
                  new FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: new Text('No'),
                  ),
                  new FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                      downloadImage(url);
                    },
                    child: new Text('Yes'),
                  ),
                ],
              ),
        ) ??
        false;
  }

  requestPermission(Permission permission) async {
    final res = await SimplePermissions.requestPermission(permission);
    print("permission request result is " + res.toString());
  }

  checkPermission(Permission permission) async {
    bool res = await SimplePermissions.checkPermission(permission);
    print("permission is " + res.toString());
  }

  getPermissionStatus(Permission permission) async {
    final res = await SimplePermissions.getPermissionStatus(permission);
    print("permission status is " + res.toString());
  }

  void downloadImage(String url) async {
    bool resCheck = await SimplePermissions.checkPermission(
        Permission.WriteExternalStorage);
    if (resCheck) {
      realDownload(url);
    } else {
      PermissionStatus permissionStatus =
          await SimplePermissions.requestPermission(
              Permission.WriteExternalStorage);
      if (PermissionStatus.authorized == permissionStatus) {
        realDownload(url);
      }
    }
  }

  void realDownload(String url) async {
    String path = await PathHelper.getExternalStorageDir();
    List<String> strs = url.split(".");
    path =
        path + "/" + Md5Helper.generateMd5(url) + "." + strs[strs.length - 1];
    DownloadHelper.download(url, path,
        (String url, String path, Response response) {
      print("downloadImage $url ...  $path");
      if (response != null) {
        print("downloadImage $response.data");
      }
    }, onDownloadProgress: (int received, int total) {
      double d = (received / total) * 100;
      String dp = d.toString() + "%";
      print("downloadImage $total ...  $received ... $dp");
    });
  }

  double getSuitableWidth() {
    double width = MediaQuery.of(context).size.width;
    //print("getSuitableWidth,$width");
    width = width / 7.0 * 5.0;
    //print("getSuitableWidth,$width");
    return width;
  }
}
