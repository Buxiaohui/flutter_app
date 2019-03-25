import 'package:flutter_app/bean/ReadDetailSiteMode.dart';

class ReadDetailMode extends Object {
  String _id;
  String content;
  String created_at;
  String published_at;
  int crawled;
  String cover;
  bool deleted;
  String raw;
  String title;
  String uid;
  String url;
  ReadDetailSiteMode site;

  setId(String value) {
    _id = value;
  }

  @override
  String toString() {
    return 'ReadDetailMode{_id: $_id, content: $content, created_at: $created_at, published_at: $published_at, crawled: $crawled, cover: $cover, deleted: $deleted, raw: $raw, title: $title, uid: $uid, url: $url, site: $site}';
  }
}
