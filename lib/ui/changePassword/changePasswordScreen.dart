import 'package:flutter/material.dart';
import 'package:pickappuser/ui/shared/customButton.dart';
import 'package:pickappuser/ui/shared/myTextInput.dart';

class ChangePasswordScreen extends StatefulWidget{
  @override
  _ChangePasswordState createState() => _ChangePasswordState();

}

class _ChangePasswordState extends State<ChangePasswordScreen>{
  @override
  Widget build(BuildContext context) {

    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    final oldPassword = Container(
      height: 60,
      child: MyTextInputField(
        leadingIcon: true,
        leadIcon: Icons.lock,
        isPasswordField: true,
        label: "Old Password",
      ),
    );

    final newPassword = Container(
      height: 60,
      child: MyTextInputField(
        leadingIcon: true,
        leadIcon: Icons.lock,
        isPasswordField: true,
        label: "New Password",
      ),
    );

    final confirmPassword = Container(
      height: 60,
      child: MyTextInputField(
        leadingIcon: true,
        leadIcon: Icons.lock,
        isPasswordField: true,
        label: "Confirm New Password",
      ),
    );

    final update = Container(
      height: 50,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: CustomButton(
              title: "Change Password",
              onPressed: (){

              },
              height: 50,
            )
            
          )
        ],
      ),
    );

    return WillPopScope(
      // ignore: missing_return
      onWillPop: (){
        Navigator.pop(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Change Password",
            style: TextStyle(
                color: Colors.white
            ),),
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          backgroundColor: Colors.purple[900],
        ),
        body: Container(
          width: deviceWidth,
          height: deviceHeight,
          margin: EdgeInsets.only(left:20,right:20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(height: 10,),
              oldPassword,
              SizedBox(height: 5,),
              newPassword,
              SizedBox(height: 5,),
              confirmPassword,
              SizedBox(height: 5,),
              update
            ],
          ),

        )
      ),
    );
  }

}