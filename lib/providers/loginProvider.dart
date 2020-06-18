import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pickappuser/config/locator.dart';
import 'package:pickappuser/constants/local_storage_name.dart';
import 'package:pickappuser/constants/routes.dart';
import 'package:pickappuser/services/dialog.service.dart';
import 'package:pickappuser/services/http.service.dart';
import 'package:pickappuser/services/router.service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider with ChangeNotifier{
  final requests = locator<HttpService>();
  var router = locator<RouterService>();

  final emailPhoneCtrl = TextEditingController(text:"nabilkhafali@gmail.com");
  final passwordCtrl = TextEditingController(text:"password");

  bool emailPhoneError = false;
  bool passwordError = false;

  bool isLoading = false;

  String emailPhoneErrorMessage = "";
  String passwordErrorMessage = "Passwords must be at least 8 characters";
  String loginType;

  void checkEmailPhone(){
    if(!emailPhoneCtrl.text.contains("@")){
      loginType="phone";
      if(emailPhoneCtrl.text.length!=10){
        emailPhoneErrorMessage = "Phone number must be 10 characters";
        emailPhoneError = true;
      }
      else{
        emailPhoneErrorMessage = "";
        emailPhoneError = false;
      }
    }
    else{
      loginType = "email";
      bool isValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(emailPhoneCtrl.text);

      if (!isValid) {
        emailPhoneErrorMessage = "Email address is not valid.";
        emailPhoneError = true;
      }else{
        emailPhoneErrorMessage = "";
        emailPhoneError = false;
      }
    }
  }

  void checkPassword(){
    if(passwordCtrl.text.length<8){
      passwordError = true;
    }
    else{
      passwordError = false;
    }
  }


  void login(BuildContext context) async{
    checkPassword();
    checkEmailPhone();
    notifyListeners();

    var response;
    if( emailPhoneError == false && passwordError == false){
      print(loginType);
      isLoading = true;
      notifyListeners();
      response = await requests.loginUser(loginType, emailPhoneCtrl.text, passwordCtrl.text);
      print(response);
      int code = response.statusCode;
      print("Status code:");
      print(code);
      Map<String, dynamic> body = jsonDecode(response.body);
      print(body);

      if(code == 401){
        //show Dialog
        DialogService().showAlertDialog(
          context: context,
          type: AlertDialogType.error,
          message: "Invalid User Credentials",
        );
      }
      else if(code == 200){
        bool verification = body['user']['is_verified'];
        if(verification == true){
          print("Account verified");
          String token = body['token'];
          String id = body['user']['id'].toString();
          String name = body['user']['fullname'];
          String phone = body['user']['phone'];
          String email = body['user']['email'];
          String photo = body['user']['photo'];
          String tokenExpiry = body['expires_at'];

          saveUserData(token, id, name, phone, email, photo, tokenExpiry);
          router.navigateTo(AppRoutes.dashboardRoute);
        }
        else{
          router.navigateTo(AppRoutes.emailVerificationRoute);
        }

      }
      else{
        DialogService().showAlertDialog(
          context: context,
          type: AlertDialogType.error,
          message: "Please check Internet Settings",
        );
      }
    }

    isLoading = false;
    notifyListeners();
  }


  void saveUserData(String token,String id,String name,String phone,String mail,String avatar,String tokenExpiry) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(LocalStorageName.bearerToken, token);
    preferences.setString( LocalStorageName.tokenExpiration, tokenExpiry);
    preferences.setString( LocalStorageName.userId,id);
    preferences.setString(LocalStorageName.userName, name);
    preferences.setString( LocalStorageName.userAvatar,avatar);
    preferences.setString(LocalStorageName.userPhone, phone);
    preferences.setString(LocalStorageName.userMail, mail);

  }

}