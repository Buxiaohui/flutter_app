class ReadCategoryChild extends Object {
  String _id;
  String id;
  String created_at;
  String icon;
  String title;

  ReadCategoryChild(this._id, this.id, this.created_at, this.icon, this.title);

  @override
  String toString() {
    return 'ReadCategoryChild{_id: $_id, id: $id, created_at: $created_at, icon: $icon, title: $title}';
  }
}
