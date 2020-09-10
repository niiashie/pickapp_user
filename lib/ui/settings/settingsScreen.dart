import 'package:flutter/material.dart';
import 'package:pickappuser/config/locator.dart';
import 'package:pickappuser/constants/app_constants.dart';
import 'package:pickappuser/constants/routes.dart';
import 'package:pickappuser/providers/drawer.provider.dart';
import 'package:pickappuser/services/dialog.service.dart';
import 'package:pickappuser/services/router.service.dart';
import 'package:pickappuser/ui/shared/dialogs/log_out.dialog.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget{
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<SettingsScreen>{
  var router = locator<RouterService>();
  var vm;
  @override
  void initState() {
    // TODO: implement initState
    vm = context.read<DrawerStateInfo>();
    super.initState();
  }


  Future<bool> backPressed() async {
    vm.setCurrentDrawer(
      drawerItem: AppConstants.drawerItems()[0],
      index: 0,
    );
    router.navigateTo(AppRoutes.dashboardRoute);
    return await true;
  }

  @override
  Widget build(BuildContext context) {

    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    final editProfile = InkWell(
      onTap: (){
        router.navigateTo(AppRoutes.editProfileRoute);
      },
      child: Container(
        width: deviceWidth,
        margin: EdgeInsets.only(left: 20,right: 20),
        height: 60,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Edit Profile",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Divider(
                color: Colors.grey,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.arrow_right,
                size: 20,
              ),
            )
          ],
        ),
      ),
    );

    final changePassword = InkWell(
      onTap: (){
        router.navigateTo(AppRoutes.changePasswordRoute);
      },
      child: Container(
        width: deviceWidth,
        margin: EdgeInsets.only(left: 20,right: 20),
        height: 60,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Change Password",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Divider(
                color: Colors.grey,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.arrow_right,
                size: 20,
              ),
            )
          ],
        ),
      ),
    );
    // TODO: implement build
    return WillPopScope(
      onWillPop: (){
        backPressed();
      },
      child:Scaffold(
        appBar:  AppBar(
          title: Text(
            "Settings",
            style: TextStyle(
                color: Colors.white
            ),),
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          backgroundColor: Colors.purple[900],
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.power_settings_new,
                color: Colors.white,
              ),
              onPressed: (){
                DialogService().showCustomDialog(context: context, customDialog: LogOutDialog());
              },
            )
          ],
        ),
        body: Container(
          width: deviceWidth,
          height: deviceHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              editProfile,
              changePassword
            ],
          ),
        ),
      )
    );

  }

}