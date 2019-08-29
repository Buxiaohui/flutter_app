abstract class MineItemMode {
  int index;
  String mainTitle;
  String subTitle;
  int type;
  String iconLocalPath;
}

class MineHeadData extends MineItemMode {}

class AboutData extends MineItemMode {
  String moreIconLocalPath;
}

class CollectData extends MineItemMode {
  String moreIconLocalPath;
}
