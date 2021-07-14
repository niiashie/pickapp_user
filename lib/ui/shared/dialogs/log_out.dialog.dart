
import 'package:flutter/material.dart';
import 'package:pickappuser/config/locator.dart';

import 'package:pickappuser/constants/images.dart';
import 'package:pickappuser/constants/routes.dart';
import 'package:pickappuser/services/router.service.dart';
import 'package:pickappuser/ui/shared/customButton.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LogOutDialog extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var router = locator<RouterService>();
   
    return Container(
      height: 300,
      child: Stack(
        children: <Widget>[
          Container(
            height: 150,
            decoration: BoxDecoration(
                color: Colors.purple[900],
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
            ),
            child: Center(
              child: Image.asset(AppImages.shutDown,height: 70,width: 70,),
            ),
          ),
          Container(
                height: 150,
                margin: EdgeInsets.only(top:150),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))
                ),
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: EdgeInsets.only(top:15),
                        child: Text(
                          "Do you really want to log Out?",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 17,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: EdgeInsets.only(top:70),
                        height: 70,
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                             Expanded(
                               child: Center(
                                 child: ButtonTheme(
                                   minWidth: 100,
                                   height: 40,
                                   child: TextButton(
                                     child: Text(
                                       "Cancel",
                                       style: TextStyle(
                                         color: Colors.grey
                                       ),
                                     ),
                                     onPressed: (){
                                       Navigator.pop(context);
                                     },
                                   ),
                                 ) ,
                               ),
                             ),
                             SizedBox(width: 10,),
                             Expanded(
                               child: Center(
                                 child: CustomButton(
                                   setWidth: true,
                                   width: 100,
                                   height: 40,
                                   title: "Log Out",
                                   onPressed: ()async{
                                      SharedPreferences _prefs = await SharedPreferences.getInstance();
                                       _prefs.clear();
                                       router.navigateToAndReplace(AppRoutes.loginScreenRoute);
                                   },
                                 )
                                 
                                 
                               ),
                             )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
        ],
      ),
    );
  }

}