import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/bean/BenifitMode.dart';
import 'package:flutter_app/net/NetConstants.dart';
import 'package:flutter_app/net/NetController.dart';
import 'package:flutter_app/utils/DownloadHelper.dart';

class BenifitPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new BenifitPageState();
}

class BenifitPageState extends State<BenifitPage>
    with SingleTickerProviderStateMixin {
  List<BenifitMode> _datas;
  int _page = 1;
  int _count = 10;

  Future<void> _request(int _requestType) async {
    if (_requestType == 0) {
      _count = 10;
      _page = 1;
    } else {
      _page++;
    }
    // 网络请求
    String finalInitUrl = NetConstants.BENIFIT_BASE_URL + "$_count/$_page";
    print("refresh,firatInitUrl,$finalInitUrl");
    NetController.request(finalInitUrl, _requestType,
        (request, response, bodyData, requestType) {
      try {
        final body = json.decode(bodyData);
        final results = body["results"];
        List<BenifitMode> newDatas = new List();
        results.forEach((item) {
          newDatas
              .add(BenifitMode(item["_id"], item["url"], item["publishedAt"]));
        });
        print("request,_datas,$newDatas");
        if (requestType == 0) {
          _datas.clear();
          _datas.addAll(newDatas);
        } else {
          _datas.addAll(newDatas);
        }
      } catch (exception) {
        print("refresh,error,$exception");
      }
      // flutter 通过这种方式更新UI
      setState(() {});
    });
  }

  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _datas = new List();
    _scrollController =
        new ScrollController(debugLabel: "debug_hui", initialScrollOffset: 0.0);
    _request(0);

    _scrollController.addListener(() {
      print('_scrollController.position.pixels ' +
          _scrollController.position.pixels.toString());
      print(' _scrollController.position.maxScrollExtent' +
          _scrollController.position.maxScrollExtent.toString());
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('滑动到了最底部');
        _request(1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
        appBar: AppBar(
          title: Text("福利"),
          centerTitle: false,
        ),
        body: RefreshIndicator(
          child: new GridView.count(
            controller: _scrollController,
            crossAxisCount: 2,
            // 每行几个item
            scrollDirection: Axis.vertical,
            // 滚动方向
            mainAxisSpacing: 3,
            // item 垂直方向的间隔距离
            crossAxisSpacing: 2,
            // item 水平方向的间隔距离
//      childAspectRatio: 2/5,// 宽高比
            padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
            // 整体的padding，非每个item
            children: _datas.map((BenifitMode mode) {
              return _getItemView(context, mode);
            }).toList(),
          ),
          onRefresh: () {
            _request(0);
          },
        ),
      ),
    );
  }

  int getItemCount() {
    if (_datas != null) {
      return _datas.length;
    }
    return 0;
  }

  String _getIconUrl(BenifitMode mode) {
    if (mode != null) {
      return mode.url;
    }
    return "";
  }

  String _getPublishedAt(BenifitMode mode) {
    if (mode != null) {
      return "发布日期:" + mode.publishedAt.substring(0, 10);
    }
    return "";
  }

  Widget _getItemView(BuildContext context, BenifitMode data) {
    return InkWell(
      onTap: () {},
      child: Card(
        elevation: 4,
        child: Stack(
          children: <Widget>[
            GestureDetector(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.network(
                  data.url,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
//                child: FadeInImage.memoryNetwork(
                // placeholder: kTransparentImage,
//                  image: 'https://picsum.photos/250?image=9',
              ),
//              ),
              onLongPress: () {
                DownloadHelper.onImageLongPressed(context, data.url);
              },
            ),
            Positioned(
              bottom: 2,
              right: 0,
              left: 0,
              child: Offstage(
                offstage: true, // true：: invisible
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      data.publishedAt.substring(0, 10),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _getSuitableWidth() {
    double width = MediaQuery.of(context).size.width;
    print("getSuitableWidth,$width");
    width = width / 7.0 * 5.0;
    print("getSuitableWidth,$width");
    return width;
  }
}

void main() => runApp(new BenifitPage());
