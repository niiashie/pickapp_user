
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pickappuser/config/locator.dart';
import 'package:pickappuser/constants/app_constants.dart';
import 'package:pickappuser/constants/local_storage_name.dart';
import 'package:pickappuser/constants/routes.dart';
import 'package:pickappuser/providers/drawer.provider.dart';
import 'package:pickappuser/services/dialog.service.dart';
import 'package:pickappuser/services/http.service.dart';
import 'package:pickappuser/services/router.service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileProvider extends DrawerStateInfo{
  final requests = locator<HttpService>();
  TextEditingController firstNameCtrl = new TextEditingController();
  TextEditingController lastNameCtrl = new TextEditingController();
  TextEditingController emailCtrl = new TextEditingController();
  TextEditingController phoneCtrl = new TextEditingController();
  BuildContext pageContext;
  var router = locator<RouterService>();

  bool first_name_error = false,last_name_error = false, email_error = false, phone_error = false,loading = false;

  checkFirstName(){
    if(firstNameCtrl.text.isEmpty){
      first_name_error = true;
    }
    else{
      first_name_error = false;
    }
    notifyListeners();
  }

  checkLastName(){
    if(lastNameCtrl.text.isEmpty){
      last_name_error = true;
    }
    else{
      last_name_error = false;
    }
    notifyListeners();
  }

  checkMail(){
    bool isValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailCtrl.text);
    if(!isValid){
      email_error = true;
    }
    else{
      email_error = false;
    }
    notifyListeners();
  }

  checkPhone(){
     if(phoneCtrl.text.length!=10){
       phone_error = true;
     }
     else{
       phone_error = false;
     }
     notifyListeners();
  }

  void updateProfileDetail(BuildContext context)async{
    checkLastName();checkFirstName();checkMail();checkPhone();
    if(phone_error == false && email_error == false && first_name_error == false && last_name_error == false){
      loading = true;
      notifyListeners();
      var response = await requests.updateProfile(firstNameCtrl.text,lastNameCtrl.text,emailCtrl.text,phoneCtrl.text);
      loading = false;
      notifyListeners();
      Map<String, dynamic> body = jsonDecode(response.body);
      print(body);
      List<dynamic>phoneError = body['phone'];
      if(phoneError != null){
        DialogService().showAlertDialog(context: context, message: "Sorry, phone number already registered", type:AlertDialogType.error,showCancelBtn: false);
      }
      else{
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String firstName = firstNameCtrl.text;
        String lastName = lastNameCtrl.text;
        String fullName = "$firstName $lastName";
        preferences.setString(LocalStorageName.userName,fullName);
        preferences.setString(LocalStorageName.userPhone,phoneCtrl.text);
        preferences.setString(LocalStorageName.userMail, emailCtrl.text);
        firstNameCtrl.text = "";
        lastNameCtrl.text = "";
        emailCtrl.text = "";
        phoneCtrl.text = "";
        notifyListeners();
        DialogService().showAlertDialog(context: context, message:"Successfully updated profile", type:AlertDialogType.success,
        showCancelBtn: false,showOkayBtn: true,okayText:"Okay",onOkayBtnTap: (){
               Navigator.pop(pageContext);
            });
      }
    }
  }
}