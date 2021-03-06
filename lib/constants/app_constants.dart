
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
        route: AppRoutes.dashboardRoute,
      ),
      DrawerItem(
          title: "Create Order",
          icon: Icons.create,
          route: AppRoutes.newOrderScreenRoute,
      ),
      DrawerItem(
        title: "Notifications",
        icon: Icons.notifications,
        route: AppRoutes.notificationRoute,
      ),
      DrawerItem(
        title: "Settings",
        icon: Icons.settings,
        route: AppRoutes.settingsRoute,
      ),

    ];
  }

  static const carrierTypeError = "Carrier type equired";
  static const packageSizeError = "Package size required";
  static const packageQuantityError = "Package quantity required";
  static const itemDescriptionError = "Package description required";
  static const fullNameError = "Full name required";
  static const phoneError = "Phone number invalid";
  static const pickUpLocationError = "Please specify your pick up location";
  static const googlePlacesAPIKey = "AIzaSyD4uWQdcGhkShEFEFVFztGCdiHMm9Yw1SE";
  static const deliveryLocationError = "Delivery location required";
  static const envelopeDimension = "27 x 35 x 2cm";
  static const box2Dimension = "34 x 18 x 10cm";
  static const box3Dimension = "34 x 32 x 10cm";
  static const box4Dimension = "34 x 32 x 18cm";

}