

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pickappuser/config/locator.dart';
import 'package:pickappuser/constants/routes.dart';
import 'package:pickappuser/services/dialog.service.dart';
import 'package:pickappuser/services/router.service.dart';
import 'package:pickappuser/ui/shared/dialogs/log_out.dialog.dart';
import 'package:pickappuser/ui/shared/nav_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';


class BaseScreen extends StatefulWidget {
  final Widget body;
  final String title;
  final FloatingActionButton fab;
  final bool hasElevation;
  final bool showBoardSelector;
  const BaseScreen({
    Key key,
    @required this.title,
    @required this.body,
    this.fab,
    this.showBoardSelector = false,
    this.hasElevation = true,
  });
  @override
  _BaseScreenState createState() => _BaseScreenState();

}

class _BaseScreenState extends State<BaseScreen> {


  @override
  Widget build(BuildContext context) {
    var router = locator<RouterService>();
     ThemeData theme = Theme.of(context);
    final header = Text(
      widget.title,
      style: TextStyle(
        color: Colors.white
      ),
    );
    // TODO: implement build
    return WillPopScope(
        onWillPop: (){
          // Show em dialog and if yes, allow em to quit app
          return Future.delayed(Duration(microseconds: 1), () => false);
        },
        child:Scaffold(
          appBar: AppBar(
            title: header,
            backgroundColor: Colors.purple[900],
            iconTheme: IconThemeData(
              color: Colors.white, //change your color here
            ),
            elevation: widget.hasElevation ? theme.appBarTheme.elevation : 0,
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.power_settings_new,
                  color: Colors.white,
                ),
                onPressed: (){
                  //DialogService().showCustomDialog(context: context, customDialog: LogOutDialog());
                  DialogService().showAlertDialog(context: context,
                      message: "Do you really want to log out?",
                      type: AlertDialogType.warning,
                      okayText: "Yes",
                      cancelText: "No",
                      onOkayBtnTap: ()async{
                        SharedPreferences _prefs = await SharedPreferences.getInstance();
                        _prefs.clear();
                        router.navigateTo(AppRoutes.loginScreenRoute);
                      },
                    onCancelBtnTap: (){
                      Navigator.pop(context);
                    }

                  );
                },
              )
            ],
          ),
          body: widget.body,
          drawer: NavDrawer(),
          floatingActionButton: widget.fab,
        )
    );
  }

}