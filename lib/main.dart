import 'package:flutter/material.dart';
import 'package:pickappuser/config/providers.dart';
import 'package:pickappuser/services/router.service.dart';
import 'package:provider/provider.dart';
import 'package:pickappuser/config/theme.dart' as theme;
import 'config/locator.dart';
import 'package:pickappuser/config/router.dart' as router;
import 'constants/routes.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:providers ,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PickApp',
        theme: theme.primaryTheme,
        navigatorKey: locator<RouterService>().navigatorKey,
        onGenerateRoute: router.generateRoute,
        initialRoute: AppRoutes.splashScreenRoute,
      ),
    );
  }

}