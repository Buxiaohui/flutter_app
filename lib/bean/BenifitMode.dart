class BenifitMode extends Object {
  String _id;
  String createdAt;
  String desc;
  String publishedAt;
  String source;
  String type;
  String url;
  bool used;
  String who;

  BenifitMode(this._id, this.url, this.publishedAt);

  @override
  String toString() {
    return 'BenifitMode{_id: $_id, publishedAt: $publishedAt, url: $url}';
  }
}
