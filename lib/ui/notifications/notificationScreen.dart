import 'package:flutter/material.dart';
import 'package:pickappuser/config/locator.dart';
import 'package:pickappuser/constants/app_constants.dart';
import 'package:pickappuser/constants/images.dart';
import 'package:pickappuser/constants/routes.dart';
import 'package:pickappuser/providers/drawer.provider.dart';
import 'package:pickappuser/services/data.service.dart';
import 'package:pickappuser/services/dialog.service.dart';
import 'package:pickappuser/services/router.service.dart';
import 'package:pickappuser/ui/shared/myBaseScreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationScreen extends StatefulWidget{
  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<NotificationScreen>{
  var vm;
  var router = locator<RouterService>();
  bool notificationEmpty = true;
  List<String>notificationDates = new List<String>();
  List<String>notificationMessages = new List<String>();
  @override
  void initState() {
    // TODO: implement initState
    vm = context.read<DrawerStateInfo>();
    checkNotifications();
    super.initState();
  }

  checkNotifications()async{
    notificationDates  = await DataService().getStringList("notificationDates");
    notificationMessages = await DataService().getStringList("notificationBody");

    if(notificationMessages.length>0){
      setState(() {
        notificationEmpty = false;
      });
    }
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

    // TODO: implement build
    return BaseScreen(
      title: "Notifications",
      hasElevation: true,
      body: Stack(
          children: <Widget>[
            ListView.builder(
              itemCount: notificationMessages.length,
              itemBuilder: (context,index){
                return Container(
                  width: deviceWidth,
                  margin: EdgeInsets.only(left:20,right: 20,top:10),
                  padding: EdgeInsets.only(top:10,bottom: 10,left: 10,right: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        height: 30,
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                notificationDates[index],
                                style: TextStyle(
                                  color: Colors.purple[900],
                                  fontSize: 17
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                icon:Icon(
                                    Icons.clear,
                                  size: 20,
                                  color: Colors.purple[900],
                                ),
                                onPressed: (){
                                  DialogService().showCustomDialog(context: context,
                                      customDialog: Container(
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
                                                child: Image.asset(AppImages.question,height: 70,width: 70,),
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
                                                      padding: EdgeInsets.only(left:5,right: 5),
                                                      child: Text(
                                                        "Do you really want to delete this notification",
                                                        textAlign: TextAlign.center,
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
                                                                  child: FlatButton(
                                                                    child: Text(
                                                                      "No",
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
                                                                child: ButtonTheme(
                                                                  minWidth: 100,
                                                                  height: 40,
                                                                  child: RaisedButton(
                                                                    color: Colors.amber[900],
                                                                    child: Text(
                                                                      "Yes",
                                                                      style: TextStyle(
                                                                          color: Colors.white
                                                                      ),
                                                                    ),
                                                                    shape: RoundedRectangleBorder(
                                                                        side: BorderSide(
                                                                            color: Colors.amber[900],
                                                                            width: 1,
                                                                            style: BorderStyle.solid),
                                                                        borderRadius: BorderRadius.circular(5)),
                                                                    onPressed: ()async{

                                                                        setState(() {
                                                                          notificationMessages.removeAt(index);
                                                                          notificationDates.removeAt(index);
                                                                        });
                                                                         SharedPreferences _prefs = await SharedPreferences.getInstance();
                                                                         _prefs.setStringList("notificationDates", notificationDates);
                                                                         _prefs.setStringList("notificationBody", notificationMessages);
                                                                         checkNotifications();
                                                                         Navigator.pop(context);
                                                                    },
                                                                  ),
                                                                ),
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
                                      )
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          notificationMessages[index],
                          style: TextStyle(
                            color: Colors.grey
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
            Visibility(
              visible: notificationEmpty,
              child: Container(
                width: deviceWidth,
                height: deviceHeight,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                       Image.asset(AppImages.bell,width: 80,height: 80,),
                      SizedBox(height: 10,),
                      Text(
                          "Currently no notifications yet.",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        )
    );

  }
  /*Stack(
          children: <Widget>[
            ListView.builder(
              itemCount: notificationMessages.length,
              itemBuilder: (context,index){
                return Container(
                  width: deviceWidth,
                  margin: EdgeInsets.only(left:20,right: 20,top:10),
                  padding: EdgeInsets.only(top:10,bottom: 10,left: 10,right: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        height: 30,
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                notificationDates[index],
                                style: TextStyle(
                                  color: Colors.purple[900],
                                  fontSize: 17
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                icon:Icon(
                                    Icons.clear,
                                  size: 20,
                                  color: Colors.purple[900],
                                )
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          notificationMessages[index],
                          style: TextStyle(
                            color: Colors.grey
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
            Visibility(
              visible: notificationEmpty,
              child: Container(
                width: deviceWidth,
                height: deviceHeight,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                       Image.asset(AppImages.bell,width: 80,height: 80,),
                      SizedBox(height: 10,),
                      Text(
                          "Current no notifications yet.",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),*/
}