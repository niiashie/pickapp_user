
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:pickappuser/config/locator.dart';
import 'package:pickappuser/constants/routes.dart';
import 'package:pickappuser/constants/utils.dart';
import 'package:pickappuser/models/api_response.dart';
import 'package:pickappuser/services/dialog.service.dart';
import 'package:pickappuser/services/http.service.dart';
import 'package:pickappuser/services/router.service.dart';

class RegistrationProvider with ChangeNotifier{
 // final auth = locator<AuthService>();
  final requests = locator<HttpService>();
  var router = locator<RouterService>();
  //Form Controllers
  final firstNameCtrl = TextEditingController(text:"Robert");
  final lastNameCtrl = TextEditingController(text:"Ashie");
  final phoneNumberCtrl = TextEditingController(text:"0551044551");
  final emailCtrl = TextEditingController(text:"rhemayiku@gmail.com");
  final passwordCtrl = TextEditingController(text:"10490472");

  bool isLoading = false;

  bool firstNameError = false;
  bool lastNameError = false;
  bool phoneNumberError = false;
  bool emailError = false;
  bool passwordError = false;

  String firstNameErrorMessage = "First name required please";
  String lastNameErrorMessage = "Last name required please";
  String phoneNumberErrorMessage = "Phone number must be 10 characters";
  String emailErrorMessage = "Invalid email";
  String passwordErrorMessage = "Password must be 8 characters";

  void checkFirstName(){
    if(firstNameCtrl.text.isEmpty){
      firstNameError = true;
    }
    else{
      firstNameError = false;
    }
  }
  void checkLastName(){
    if(lastNameCtrl.text.isEmpty){
      lastNameError = true;
    }
    else{
      lastNameError = false;
    }
  }
  void checkPhoneNumber(){
    if(phoneNumberCtrl.text.length!=10){
      phoneNumberError = true;
    }
    else{
      phoneNumberError = false;
    }
  }
  void checkEmail(){
    bool isValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailCtrl.text);

    if (!isValid) {
      emailError = true;
    }
    else{
      emailError = false;
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


  void registration(BuildContext context) async{
    var response;
    checkFirstName();
    checkLastName();
    checkPhoneNumber();
    checkEmail();
    checkPassword();
    notifyListeners();

    if(firstNameError == false && lastNameError == false && phoneNumberError == false && emailError == false && passwordError == false){
       isLoading = true;
       notifyListeners();

       http.Response response = await requests.registerUser(firstNameCtrl.text, lastNameCtrl.text, emailCtrl.text, phoneNumberCtrl.text, passwordCtrl.text);
       print(response);
       int code = response.statusCode;
       print("Status code:");
       print(code);
       Map<String, dynamic> body = jsonDecode(response.body);
       print(body);
       if(code == 200){
         DialogService().showAlertDialog(context: context, message:
         "Registration success, verify registration in your email", type: AlertDialogType.success,
             okayText: "Login",onOkayBtnTap: (){
               router.navigateTo(AppRoutes.loginScreenRoute);
             });
       }else if(code == 400){
         String error_message = "";
         //Check Mail error
         if(body['email'] == null){
           print("Mail Error empty");
         }
         else{
           print("Mail Error");
           error_message = error_message+"Email already registered";
         }

         //Check Phone number error
         if(body['phone'] == null){
           print("Phone Error empty");
         }
         else{
           error_message = error_message+"\n Phone number already registered";
         }

         //show Dialog
         DialogService().showAlertDialog(
           context: context,
           type: AlertDialogType.error,
           message: error_message,
         );
       }
       else{
         DialogService().showAlertDialog(
           context: context,
           type: AlertDialogType.error,
           message: "Please check Internet Settings",
         );
       }

       isLoading = false;
       notifyListeners();



    }

  }

}