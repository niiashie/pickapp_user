
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pickappuser/models/message.dart';

class FCMessaging extends StatefulWidget{
  @override
  FCMessagingState createState() => FCMessagingState();
}
class FCMessagingState extends State<FCMessaging>{
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final List<Message>mesages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        final notification = message['notification'];
        setState(() {
          mesages.add(Message(title: notification['title'],body: notification['body']));
        });
        //_showItemDialog(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        //_navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        //_navigateToItemDetail(message);
      },
    );

    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));
  }

  @override
  Widget build(BuildContext context) => ListView(
    children:mesages.map(buildMessage).toList(),
  );

   Widget buildMessage(Message message) => ListTile(
       title: Text(message.title,style: TextStyle(color: Colors.white),),
       subtitle: Text(message.body,style: TextStyle(color: Colors.white)),
      );

}