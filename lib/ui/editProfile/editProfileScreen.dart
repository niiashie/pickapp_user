import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pickappuser/config/locator.dart';
import 'package:pickappuser/providers/editProfileProvider.dart';
import 'package:pickappuser/services/router.service.dart';
import 'package:pickappuser/ui/shared/customButton.dart';
import 'package:pickappuser/ui/shared/myTextInput.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget{
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen>{
  var router = locator<RouterService>();
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    final vm = Provider.of<EditProfileProvider>(context);
    vm.pageContext = context;

    final fName = Container(
      height: 60,
      child: MyTextInputField(
        label: "First Name",
        leadingIcon: true,
        textEntryType: TextInputType.text,
        leadIcon: Icons.person,
        controller: vm.firstNameCtrl,
        error: vm.first_name_error,
        errorText: "First Name required please",
      ),
    );

    final lName = Container(
      height: 60,
      child: MyTextInputField(
        label: "Last Name",
        leadingIcon: true,
        textEntryType: TextInputType.text,
        leadIcon: Icons.person,
        controller: vm.lastNameCtrl,
        error: vm.last_name_error,
        errorText: "Last name required please",
      ),
    );

    final email = Container(
      height: 60,
      child: MyTextInputField(
        label: "Email Address",
        leadingIcon: true,
        textEntryType: TextInputType.emailAddress,
        leadIcon: Icons.mail,
        controller: vm.emailCtrl,
        error: vm.email_error,
        errorText: "Invalid email",
      ),
    );

    final phone = Container(
      height: 60,
      child: MyTextInputField(
        label: "Phone",
        leadingIcon: true,
        textEntryType: TextInputType.phone,
        leadIcon: Icons.phone,
        controller: vm.phoneCtrl,
        error: vm.phone_error,
        errorText: "Invalid Phone number",
      ),
    );

    final update = Container(
       height: 50,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: CustomButton(
              height: 50,
              title:  "Update Account",
              onPressed: (){
                vm.updateProfileDetail(context);
              },
            )
            
            
          )
        ],
      ),
    );

    final loader = Visibility(
      visible:vm.loading,
      child: Container(
        width: deviceWidth,
        height: deviceHeight,
        color: Colors.black26,
        child: Center(
          child: Container(
            height: 80,
            color: Colors.white,
            width: deviceWidth,
            margin: EdgeInsets.only(left:20,right: 20),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(width: 10,),
                SizedBox(
                  height: 80,
                  width: 50,
                  child: Center(
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Loading,please wait",
                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );

   
    return WillPopScope(
      // ignore: missing_return
      onWillPop: (){
        Navigator.pop(context);
        //router.navigateTo(AppRoutes.settingsRoute);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Edit Profile",
            style: TextStyle(
                color: Colors.white
            ),),
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          backgroundColor: Colors.purple[900],
        ),
        body: Stack(
          children: <Widget>[
            Container(
              width: deviceWidth,
              height: deviceHeight,
              margin: EdgeInsets.only(left:20,right:20),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(height: 10,),
                  fName,
                  SizedBox(height: 5,),
                  lName,
                  SizedBox(height: 5,),
                  email,
                  SizedBox(height: 5,),
                  phone,
                  SizedBox(height: 5,),
                  update

                ],
              ),
            ),
            loader
          ],
        )

      ),
    );
  }
  
}