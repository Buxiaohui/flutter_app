import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/gank_main_entrance.dart';
import 'package:flutter_app/page/music/page_music_player.dart';

void main() => runApp(_widgetForRoute("route1"));

Widget _widgetForRoute(String route) {
  switch (route) {
    case 'route1':
      return new MyApp();
    case 'route2':
      return new MusicPage();
    default:
      return Center(
        child: Text('Unknown route: $route', textDirection: TextDirection.ltr),
      );
  }
}
