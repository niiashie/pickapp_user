import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pickappuser/config/locator.dart';
import 'package:pickappuser/constants/local_storage_name.dart';
import 'package:pickappuser/constants/routes.dart';
import 'package:pickappuser/services/auth.service.dart';
import 'package:pickappuser/services/router.service.dart';
import 'package:pickappuser/services/storage.service.dart';


class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State {
  final auth = locator<AuthService>();
  var router = locator<RouterService>();

  @override
  initState(){
    auth.isAuthenticated().then((authenticated) {
      if (authenticated) {
        print("authenticated");
        router.navigateToAndReplace(AppRoutes.dashboardRoute);
      } else {
        print("not authenticated");
        router.navigateToAndReplace(AppRoutes.startScreenRoute);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
