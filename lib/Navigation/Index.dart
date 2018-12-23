import 'package:flutter/material.dart';
import 'package:flutter_app/page/HomePage.dart';
import 'package:flutter_app/page/relax_video/VideoPage.dart';
import 'package:flutter_app/page/today_gank/TodayGankPage.dart';
import 'package:flutter_app/page/RelaxReadPage.dart';
import 'package:flutter_app/page/MinePage.dart';
import 'package:flutter_app/Navigation/NavigationBar.dart';

// 创建一个 带有状态的 Widget Index
class Index extends StatefulWidget {
  //  固定的写法
  @override
  State<StatefulWidget> createState() => new _IndexState();
}

// 要让主页面 Index 支持动效，要在它的定义中附加mixin类型的对象TickerProviderStateMixin
class _IndexState extends State<Index> with TickerProviderStateMixin {
  int _currentIndex = 0; // 当前界面的索引值
  List<NavigationBar> _navigationViews; // 底部图标按钮区域
  List<StatefulWidget> _pageList; // 用来存放我们的图标对应的页面
  StatefulWidget _currentPage; // 当前的显示页面

  // 定义一个空的设置状态值的方法
  void _rebuild() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    // 初始化导航图标
    _navigationViews = <NavigationBar>[
      new NavigationBar(
          icon: new Icon(Icons.assessment),
          title: new Text("今日干货"),
          backgroundColor: Colors.lightGreen,
          vsync: this),
      // vsync 默认属性和参数
      new NavigationBar(
          icon: new Icon(Icons.add_box),
          title: new Text("闲读"),
          backgroundColor: Colors.lightBlue,
          vsync: this),
      new NavigationBar(
          icon: new Icon(Icons.account_balance),
          backgroundColor: Colors.deepPurpleAccent,
          title: new Text("主页"),
          vsync: this),
      new NavigationBar(
          icon: new Icon(Icons.all_inclusive),
          title: new Text("视频"),
          backgroundColor: Colors.lightBlue,
          vsync: this),
      new NavigationBar(
          icon: new Icon(Icons.adb),
          title: new Text("我的"),
          backgroundColor: Colors.deepPurpleAccent,
          vsync: this),
    ];

    // 给每一个按钮区域加上监听
    for (NavigationBar view in _navigationViews) {
      view.controller.addListener(_rebuild);
    }

    // 将我们 bottomBar 上面的按钮图标对应的页面存放起来，方便我们在点击的时候
    _pageList = <StatefulWidget>[
      new TodayGankPage(),
      new RelaxReadPage(),
      new HomePage(),
      new VideoPage(),
      new MinePage(),
    ];
    _currentPage = _pageList[_currentIndex];
  }

  @override
  Widget build(BuildContext context) {
    // 声明定义一个 底部导航的工具栏
    final BottomNavigationBar bottomNavigationBar = new BottomNavigationBar(
      items: _navigationViews
          .map((NavigationBar NavigationBar) => NavigationBar.item)
          .toList(), // 添加 icon 按钮
      currentIndex: _currentIndex, // 当前点击的索引值
      // type: BottomNavigationBarType.shifting, // 设置底部导航工具栏的类型：fixed 固定
      type: BottomNavigationBarType.fixed,    // 设置底部导航工具栏的类型：fixed 固定
      onTap: (int index) {
        // 添加点击事件
        setState(() {
          // 点击之后，需要触发的逻辑事件
          _navigationViews[_currentIndex].controller.reverse();
          _currentIndex = index;
           _navigationViews[_currentIndex].controller.forward();
          _currentPage = _pageList[_currentIndex];
        });
      },
    );

    return new MaterialApp(
      home: new Scaffold(
        body: new Center(child: _currentPage // 动态的展示我们当前的页面
            ),
        bottomNavigationBar: bottomNavigationBar, // 底部工具栏
      ),
      theme: new ThemeData(
        primarySwatch: Colors.blue, // 设置主题颜色
      ),
    );
  }
}
