
import 'package:flutter/material.dart';
import 'package:pickappuser/constants/routes.dart';
import 'package:pickappuser/models/drawer_item.dart';

class AppConstants {
  static const String appName = "PickAppUser";
  static const dashBoardIntroText = "NO ORDER(S)\n\n Press the + button shown below to place/make your first order";
  static List<DrawerItem> drawerItems() {
    return [
      DrawerItem(
        title: "Orders",
        icon: Icons.timelapse,
        route: AppRoutes.loginScreenRoute,
      ),
      DrawerItem(
          title: "Create Order",
          icon: Icons.create,
          route: AppRoutes.newOrderScreenRoute,
      ),
      DrawerItem(
        title: "Notifications",
        icon: Icons.notifications,
        route: AppRoutes.loginScreenRoute,
      ),
      DrawerItem(
        title: "Settings",
        icon: Icons.settings,
        route: AppRoutes.loginScreenRoute,
      ),
      DrawerItem(
        title: "Logout",
        icon: Icons.lock,
        route: AppRoutes.loginScreenRoute,
      ),

    ];
  }

}