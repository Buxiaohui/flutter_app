import 'package:flutter/material.dart';
import 'package:flutter_app/bean/BenifitMode.dart';
import 'package:flutter_app/utils/DownloadHelper.dart';

class BenifitDetailPage extends StatefulWidget {
  List<BenifitMode> datas;
  int initialPage;

  @override
  State<StatefulWidget> createState() => new BenifitDetailPageState();
}

class BenifitDetailPageState extends State<BenifitDetailPage>
    with SingleTickerProviderStateMixin {
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = new PageController(initialPage: widget.initialPage);
    _pageController.addListener(() {
      print("图片详情页……滑动啊啊啊啊");
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
          body: PageView.builder(
            itemBuilder: (BuildContext context, int index) {
              return _getItem(context, index);
            },
            itemCount: _getItemCount(),
            onPageChanged: (int index) {
              print("图片详情页,$index");
            },
            scrollDirection: Axis.horizontal,
            controller: _pageController,
          )),
    );
  }

  _getItem(BuildContext context, int index) {
    return Container(
      child: Image.network(widget.datas[index].url),
    );
  }

  int _getItemCount() {
    if (widget.datas != null) {
      return widget.datas.length;
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

void main() => runApp(new BenifitDetailPage());
