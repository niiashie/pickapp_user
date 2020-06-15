import 'package:flutter/widgets.dart';

class DrawerItem {
  String title;
  IconData icon;
  String route;

  DrawerItem({
    @required this.title,
    @required this.icon,
    @required this.route,
  });
}
