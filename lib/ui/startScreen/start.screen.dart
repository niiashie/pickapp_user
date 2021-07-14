
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pickappuser/config/locator.dart';
import 'package:pickappuser/constants/images.dart';
import 'package:pickappuser/constants/routes.dart';
import 'package:pickappuser/services/router.service.dart';
import 'package:pickappuser/ui/shared/customButton.dart';

// ignore: must_be_immutable
class StartScreen extends StatelessWidget{
  var router = locator<RouterService>();
  @override
  Widget build(BuildContext context) {

    // ignore: non_constant_identifier_names
    double device_width = MediaQuery.of(context).size.width;

    // ignore: non_constant_identifier_names
    double device_height = MediaQuery.of(context).size.height;

    final bottomWidget = Align(
     alignment: Alignment.bottomCenter,
      child: Container(
        height: 100,
        width: device_width,
        child: Row(
         children: <Widget>[
           SizedBox(width: 20,),
           Expanded(
               child: CustomButton(
                 height: 50,
                 onPressed: (){
                   router.navigateTo(AppRoutes.loginScreenRoute);
                 },
                 title: "Login",
               )
           ),
           SizedBox(width: 20,),
           Expanded(
               child: CustomButton(
                 height: 50,
                 onPressed: (){
                   router.navigateTo(AppRoutes.registrationScreenRoute);
                 },
                 title: "Register",
               )
           ),
           SizedBox(width: 20,)
           /*Container(
             width: device_width*0.5,
             height: 80,
             child: Center(
               child:  ButtonTheme(
                 minWidth: device_width*0.4,
                 height: 50,
                 child: RaisedButton(
                   child: Text(
                     "Login",
                     style: TextStyle(
                       color: Colors.white
                     ),
                   ),
                   color:Colors.amber[900],
                   shape: RoundedRectangleBorder(
                       side: BorderSide(
                           color: Colors.amber[900],
                           width: 1,
                           style: BorderStyle.solid),
                       borderRadius: BorderRadius.circular(5)),
                   onPressed: (){
                     router.navigateTo(AppRoutes.loginScreenRoute);
                   },
                 ),
               ),
             )

           ),
           Container(
               width: device_width*0.5,
               height: 80,
               child: Center(
                 child:  ButtonTheme(
                   minWidth: device_width*0.4,
                   height: 50,
                   child: RaisedButton(
                     child: Text(
                       "Register",
                       style: TextStyle(
                           color: Colors.white
                       ),
                     ),
                     color:Colors.amber[900],
                     shape: RoundedRectangleBorder(
                         side: BorderSide(
                             color: Colors.amber[900],
                             width: 1,
                             style: BorderStyle.solid),
                         borderRadius: BorderRadius.circular(5)),
                     onPressed: (){
                       router.navigateTo(AppRoutes.registrationScreenRoute);
                     },
                   ),
                 ),
               )

           )*/
         ],
        ),
      ),
    );
    final centerImg = Center(
      child: Image.asset(
        AppImages.appBanner,
        width: 200,
        height: 150,
      ),
    );
   
    return Scaffold(
       body: Container(
          width: device_width,
          height: device_height,
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              centerImg,
              bottomWidget
            ],
          ),
        )
    );

  }

}