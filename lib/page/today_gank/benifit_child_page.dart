import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/bean/TodayGankBaseChildModel.dart';
import 'package:flutter_app/page/base_page_mixin.dart';
import 'package:flutter_app/utils/DownloadHelper.dart';

class BenifitChildPage extends StatefulWidget with BasePageMixin {
  BenifitChildPage({Key key}) : super(key: key);

  factory BenifitChildPage.forDesignTime() {
    // TODO: add arguments
    return new BenifitChildPage();
  }

  @override
  void set title(String _title) {
    // TODO: implement title
    super.title = _title;
  }

  @override
  void set items(List<BaseItemModel> _items) {
    // TODO: implement items
    super.items = _items;
  }

  @override
  State<StatefulWidget> createState() => new BenifitPageState();
}

class BenifitPageState extends State<BenifitChildPage> {
  @override
  void initState() {
    if (widget.items == null) {
      widget.items = new List();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new GridView.count(
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
      children: widget.items.map((BaseItemModel mode) {
        return _getItemView(context, mode);
      }).toList(),
    );
  }

  Widget _getItemView(BuildContext context, BaseItemModel data) {
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
                      data.who,
                      textAlign: TextAlign.left,
                    ),
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
}
