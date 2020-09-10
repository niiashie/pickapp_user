import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:pickappuser/models/api_response.dart';
import 'package:pickappuser/services/dialog.service.dart';
import 'package:progress_dialog/progress_dialog.dart';


class Utils {

  ProgressDialog progressDialog;


  static Widget verticalSpacer({double space = 20.0}) {
    return SizedBox(height: space);
  }

  static Widget horizontalSpacer({double space = 20.0}) {
    return SizedBox(width: space);
  }

  static String formatDateTime(String dateTime) {
    DateTime parsedDateTime = DateTime.parse(dateTime);
    return DateFormat('MMM dd, yyyy').format(parsedDateTime);
  }

  static String formatMoney(int amount) {
    return NumberFormat.currency(symbol: '\$').format(amount);
  }

  static void ShowError(String errorMessage,BuildContext context){
    DialogService().showAlertDialog(context: context, message:"You will loose all your entries",
        type: AlertDialogType.error,okayText: "Okay",
        onOkayBtnTap: (){
          Navigator.pop(context);
        },

    );
  }

   static void getProgressBar(BuildContext context,String message,String operation){
     ProgressDialog progressDialog  = ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true,showLogs: false);
     progressDialog.style(
         message: message,
         borderRadius: 5.0,
         backgroundColor: Colors.white,
         elevation: 5.0,
         insetAnimCurve: Curves.easeInOut,
         progress: 0.0,
         maxProgress: 100.0,
         progressTextStyle: TextStyle(
             color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
         messageTextStyle: TextStyle(
             color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.w600)
     );
    if(operation == "showProgress"){
      progressDialog.show();
    }
    else{
      progressDialog.hide();
    }
  }
  void hideProgressBar(){
    progressDialog.hide();
  }

  static String getTime(String dateTime, {bool showTime}) {
    DateTime parsedDateTime = DateTime.parse(dateTime);
    String format = "hh:mm a";
    if(showTime != null){
      format+=" hh:mm a";
    }
    return DateFormat(format).format(parsedDateTime);
  }

  static String getFileName(File file) {
    // if(await file.exists()){
    //   //To get file name without extension
    //   //path.basenameWithoutExtension(file.path);

    //   //return file with file extension

    // }else{
    //   return null;
    // }
    return path.basename(file.path);
  }



  static String getFileSize(File file){
    var mb = file.lengthSync() / (1024 * 1024);
    return "${mb.toStringAsFixed(2)} MB";
  }

  static ApiResponse parseApiResponse(var response) {
    int code = response.statusCode;
    Map<String, dynamic> body = jsonDecode(response.body);
    List errors = new List();
    String message = "";

    switch (code) {
      case 200:
        if (body.containsKey("data")) {
          if (body["data"] is Map) {
            message = body["data"]["message"];
          }
        }
        break;
      case 201:
        message = body["data"]["message"];
        break;
      case 204:
        message = body["data"]["message"];
        break;
      case 401:
        if (body["error"] != null) errors.add(body["error"]);
        if (body["error"] == null) {
          errors.add(body["message"]);
          // Log em out
          //locator<AuthService>().logout();
        }
        message = errors[0];

        break;
      case 422:
        body["errors"].forEach((final String key, final value) {
          for (int i = 0; i < body["errors"][key].length; i++) {
            errors.add(body["errors"][key][i]);
          }
        });
        message = errors[0];
        break;
      case 500:
        message = "Whoops! Something went wrong, please contact support.";
        break;
      default:
        message = "Unkown application error.";
        break;
    }

    return ApiResponse(
      code: code,
      message: message,
      body: body,
      errors: errors,
    );
  }
}
