//1. 模仿MediaQuery。简单的让这个持有我们想要保存的data
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/bean/TodayGankModel.dart';

class InheritedStateContainer extends InheritedWidget {
  final TodayGankModel data;

  //我们知道InheritedWidget总是包裹的一层，所以它必有child
  InheritedStateContainer(
      {Key key, @required this.data, @required Widget child})
      : super(key: key, child: child);

  //参考MediaQuery,这个方法通常都是这样实现的。如果新的值和旧的值不相等，就需要notify
  @override
  bool updateShouldNotify(InheritedStateContainer oldWidget) =>
      data != oldWidget.data;
}
