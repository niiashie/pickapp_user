

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pickappuser/constants/routes.dart';
import 'package:pickappuser/ui/createOrder/newOrder.screen.dart';
import 'package:pickappuser/ui/dashboard/dashboard.screen.dart';
import 'package:pickappuser/ui/emailVerification/emailVerification.screen.dart';
import 'package:pickappuser/ui/fcm/fcmTest.dart';
import 'package:pickappuser/ui/loclaNoti/localNotification.dart';
import 'package:pickappuser/ui/login/login.screen.dart';
import 'package:pickappuser/ui/orderDetail/orderDetail.screen.dart';
import 'package:pickappuser/ui/orderDetail2/orderDetail2.screen.dart';
import 'package:pickappuser/ui/orderSummary/orderSummary.screen.dart';
import 'package:pickappuser/ui/payment/payment.screen.dart';
import 'package:pickappuser/ui/placesSearch/searchPlacesScreen.dart';
import 'package:pickappuser/ui/registration/registration.screen.dart';
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
      return MaterialPageRoute(builder: (context) => FCMessaging());
    case AppRoutes.localNotificationRoute:
      return MaterialPageRoute(builder: (context) => LocalNotification());
    case AppRoutes.orderDetailsRoute:
      return MaterialPageRoute(builder: (context) => OrderDetailScreen());
    default:
      return MaterialPageRoute(builder: (context) => StartScreen());
  }
}