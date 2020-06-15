import 'package:flutter/material.dart';

class RouterService {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState.pushNamed(routeName);
  }

  Future<dynamic> navigateToAndReplace(String routeName) {
    return navigatorKey.currentState.pushReplacementNamed(routeName);
  }

  Future<dynamic> pushNamedAndRemoveUntil(String routeName) {
    return navigatorKey.currentState.pushNamedAndRemoveUntil(
      routeName,
      (Route<dynamic> route) => false,
    );
  }

  goBack() {
    navigatorKey.currentState.pop();
  }
}
