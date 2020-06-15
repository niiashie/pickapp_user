import 'package:flutter/widgets.dart';
import 'package:pickappuser/constants/app_constants.dart';
import 'package:pickappuser/models/drawer_item.dart';


class DrawerStateInfo with ChangeNotifier {
  int _currentDrawerIndex = 0;
  DrawerItem _currentDrawer = AppConstants.drawerItems()[0];
  int get getCurrentDrawerIndex => _currentDrawerIndex;
  DrawerItem get getCurrentDrawer => _currentDrawer;

  void setCurrentDrawer({DrawerItem drawerItem, int index}) {
    _currentDrawer = drawerItem;
    _currentDrawerIndex = index;
    notifyListeners();
  }
}
