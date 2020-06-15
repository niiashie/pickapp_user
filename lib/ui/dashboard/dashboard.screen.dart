
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pickappuser/config/locator.dart';
import 'package:pickappuser/constants/app_constants.dart';
import 'package:pickappuser/constants/routes.dart';
import 'package:pickappuser/services/router.service.dart';
import 'package:pickappuser/ui/shared/myBaseScreen.dart';
import 'package:pickappuser/constants/utils.dart';

class DashBoardScreen extends StatefulWidget{

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}
class _DashBoardScreenState extends State<DashBoardScreen>{
  @override
  Widget build(BuildContext context) {
    var router = locator<RouterService>();
    double device_width = MediaQuery.of(context).size.width;
    double device_height = MediaQuery.of(context).size.height;
    // TODO: implement build
    return BaseScreen(
      title: "Orders",
      body: Container(
        width: device_width,
        height: device_height,
        padding: EdgeInsets.only(left:20,right: 20),
        color: Colors.white,
        child: Center(
          child: Text(AppConstants.dashBoardIntroText,
          style: TextStyle(
            color:Colors.black,
            fontSize: 15
          ),
          textAlign: TextAlign.center,),
        ),
      ),
      fab: FloatingActionButton(
        onPressed: (){
         // Utils.getProgressBar(context,"Loading,Please wait","showProgress");
          router.navigateTo(AppRoutes.newOrderScreenRoute);
          print("Floating action button clicked");
        },
        backgroundColor: Colors.amber[900],
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
  
}