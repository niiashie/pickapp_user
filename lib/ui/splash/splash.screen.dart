import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pickappuser/config/locator.dart';
import 'package:pickappuser/constants/routes.dart';
import 'package:pickappuser/services/auth.service.dart';
import 'package:pickappuser/services/data.service.dart';
import 'package:pickappuser/services/router.service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pickappuser/constants/local_storage_name.dart';



class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State {
  var auth = locator<AuthService>();
  var router = locator<RouterService>();

  @override
  initState(){
    print("Hi Emmanuel");
    checkForSharedPreferences();

    super.initState();
  }

  void checkForSharedPreferences()async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String bearerToken = _prefs.getString(LocalStorageName.bearerToken);
    if(bearerToken == null){
      router.navigateTo(AppRoutes.startScreenRoute);
    }
    else{
      router.navigateTo(AppRoutes.dashboardRoute);
    }

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
