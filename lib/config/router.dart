

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pickappuser/constants/routes.dart';
import 'package:pickappuser/ui/changePassword/changePasswordScreen.dart';
import 'package:pickappuser/ui/createOrder/newOrder.screen.dart';
import 'package:pickappuser/ui/createOrder2/createOrder.screen.dart';
import 'package:pickappuser/ui/dashboard/dashboard.screen.dart';
import 'package:pickappuser/ui/editProfile/editProfileScreen.dart';
import 'package:pickappuser/ui/emailVerification/emailVerification.screen.dart';
import 'package:pickappuser/ui/loclaNoti/localNotification.dart';
import 'package:pickappuser/ui/login/login.screen.dart';
import 'package:pickappuser/ui/notifications/notificationScreen.dart';
import 'package:pickappuser/ui/orderDetail/orderDetail.screen.dart';
import 'package:pickappuser/ui/orderSummary/orderSummary.screen.dart';
import 'package:pickappuser/ui/payment/payment.screen.dart';
import 'package:pickappuser/ui/placesSearch/searchPlacesScreen.dart';
import 'package:pickappuser/ui/registration/registration.screen.dart';
import 'package:pickappuser/ui/settings/settingsScreen.dart';
import 'package:pickappuser/ui/splash/splash.screen.dart';
import 'package:pickappuser/ui/startScreen/start.screen.dart';

Route<dynamic> generateRoute(RouteSettings settings){
  switch(settings.name){
    case AppRoutes.startScreenRoute:
      return MaterialPageRoute(builder: (context) => StartScreen());
    case AppRoutes.registrationScreenRoute:
      return MaterialPageRoute(builder: (context) => RegisterScreen(fromLogin: false,));
    case AppRoutes.loginScreenRoute:
      return MaterialPageRoute(builder: (context) =>  LoginScreen());
    case AppRoutes.registrationFromLoginRoute:
      return MaterialPageRoute(builder: (context) => RegisterScreen(fromLogin: true,));
    case AppRoutes.emailVerificationRoute:
      return MaterialPageRoute(builder: (context) => EmailVerificationScreen());
    case AppRoutes.dashboardRoute:
      return MaterialPageRoute(builder: (context) => DashBoardScreen());
    case AppRoutes.splashScreenRoute:
      return MaterialPageRoute(builder: (context) => SplashScreen());
    case AppRoutes.newOrderScreenRoute:
      return MaterialPageRoute(builder: (context) => NewOrderScreen());
    case AppRoutes.placesSearchScreenRoute:
      return MaterialPageRoute(builder: (context) => CustomSearchScreen());
    case AppRoutes.orderSummaryScreenRoute:
      return MaterialPageRoute(builder: (context) => OrderSummaryScreen());
    case AppRoutes.paymentScreenRoute:
      return MaterialPageRoute(builder: (context)=> PaymentScreen());
    case AppRoutes.notificationRoute:
      return MaterialPageRoute(builder: (context) => NotificationScreen());
    case AppRoutes.localNotificationRoute:
      return MaterialPageRoute(builder: (context) => LocalNotification());
    case AppRoutes.orderDetailsRoute:
      return MaterialPageRoute(builder: (context) => OrderDetailScreen());
    case AppRoutes.settingsRoute:
      return MaterialPageRoute(builder: (context)=> SettingsScreen());
    case AppRoutes.editProfileRoute:
      return MaterialPageRoute(builder: (context) => EditProfileScreen());
    case AppRoutes.changePasswordRoute:
      return MaterialPageRoute(builder: (context) => ChangePasswordScreen());
    case AppRoutes.createOrderRoute:
      return MaterialPageRoute(builder: (context)=> CreateOrderScreen());
    default:
      return MaterialPageRoute(builder: (context) => StartScreen());
  }
}