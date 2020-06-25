
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pickappuser/constants/images.dart';
import 'package:pickappuser/models/carrier_item.dart';

class LocalNotification extends StatefulWidget{
  @override
  LocalNotificationState createState() => LocalNotificationState();
}

class LocalNotificationState extends State<LocalNotification>{
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidInitializationSettings;
  IOSInitializationSettings iosInitializationSettings;
  InitializationSettings initializationSettings;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializing();
  }
  void initializing()async{
    /* androidInitializationSettings = AndroidInitializationSettings("app_icon");
     iosInitializationSettings = IOSInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification);
     initializationSettings = InitializationSettings(androidInitializationSettings,iosInitializationSettings);
     await flutterLocalNotificationsPlugin.initialize(initializationSettings,onSelectNotification: onSelectNotification);*/

// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  void _showNotifications(){
    //notification();
    notification("Order Matched","Your order placed on 2nd October has been matched");
    //_showBigTextNotification();
    //_showNotificationMediaStyle();
  }

  Future<void>  notification(String title,String message) async{
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, title, message, platformChannelSpecifics,
        payload: 'item x');
  /*  AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      "Channel ID","Channel title","Channel body",
      priority: Priority.High,
      importance: Importance.Max,
      ticker: 'test'
    );

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    NotificationDetails notificationDetails = NotificationDetails(androidNotificationDetails,iosNotificationDetails);

    await flutterLocalNotificationsPlugin.show(0,"PickApp", "Hi Emmanuel", notificationDetails,payload: 'itemx'); */

  }



  Future<String> _downloadAndSaveFile(String url, String fileName) async {
    var directory = await getApplicationDocumentsDirectory();
    var filePath = '${directory.path}/$fileName';
    var response = await http.get(url);
    var file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }




  Future<void> _showNotificationMediaStyle(String title,String message) async {
    var largeIconPath = await _downloadAndSaveFile(
        AppImages.bannerURL, 'largeIcon');
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'media channel id',
      'media channel name',
      'media channel description',
      largeIcon: FilePathAndroidBitmap(largeIconPath),
      styleInformation: MediaStyleInformation(),
    );
    var platformChannelSpecifics =
    NotificationDetails(androidPlatformChannelSpecifics, null);
    await flutterLocalNotificationsPlugin.show(
        0, title, message, platformChannelSpecifics,
    payload:"Media Type Notification");
  }



  Future onSelectNotification(String payLoad){
    if(payLoad !=null){
      print(payLoad);
    }
    else{
      print("PayLoad Empty");
    }
  }

  Future onDidReceiveLocalNotification(int id,String title,String body,String payload)async{
     return CupertinoAlertDialog(
       title: Text(title),
       content: Text(body),
       actions: <Widget>[
         CupertinoDialogAction(
           isDefaultAction: true,
           onPressed: (){
             print("");
           },
           child: Text("Okay"),
         )
       ],
     );
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              color: Colors.blue,
              onPressed:_showNotifications,
              child: Text(
                "Show Notification",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}