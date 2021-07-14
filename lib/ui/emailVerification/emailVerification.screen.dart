
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pickappuser/constants/images.dart';
import 'package:pickappuser/providers/emailVerificationProvider.dart';
import 'package:pickappuser/ui/shared/customButton.dart';
import 'package:pickappuser/ui/shared/myTextInput.dart';
import 'package:provider/provider.dart';

class EmailVerificationScreen extends StatefulWidget{
  @override
  _EmailVerificationState createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerificationScreen>{
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<EmailVerificationProvider>(context);
    // ignore: non_constant_identifier_names
    double device_width = MediaQuery.of(context).size.width;
    // ignore: non_constant_identifier_names
    double device_height = MediaQuery.of(context).size.height;
  
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Email Verification",
          style: TextStyle(
              color: Colors.white
          ),),
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: Colors.purple[900],
      ),
      body: Container(
        width: device_width,
        height: device_height,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: device_width ,
                height: 250,
                margin: EdgeInsets.only(top:20),
                child: Center(
                  child: Image.asset(AppImages.mailVerification,
                  height: 170,
                  width: 250,),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Enter verification code sent to your mail",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 10),
              Container(
                width: 300,
                height: 60,
                child: MyTextInputField(
                   label: "Verification Code",
                   textEntryType: TextInputType.number,
                   controller: vm.emailVerificationCtrl,
                ),
              ),
              Container(
                width: 300,
                margin: EdgeInsets.only(top:10),
                child: Center(
                  child: CustomButton(
                    setWidth: true,
                    width: 300,
                    height: 50,
                    title:"Verify",
                    onPressed: (){
                       print("Email verification code");
                    },
                  )
                  
                  
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}