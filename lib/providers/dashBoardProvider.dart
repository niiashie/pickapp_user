
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:pickappuser/config/locator.dart';
import 'package:pickappuser/constants/images.dart';
import 'package:pickappuser/constants/utils.dart';
import 'package:pickappuser/models/carrier_item.dart';
import 'package:pickappuser/models/order_item.dart';
import 'package:pickappuser/models/order_item2.dart';
import 'package:pickappuser/models/order_recipient.dart';
import 'package:pickappuser/models/package_item.dart';
import 'package:pickappuser/services/http.service.dart';
import 'package:pickappuser/services/router.service.dart';
import 'package:provider/provider.dart';

class DashBoardProvider extends ChangeNotifier{
  final requests = locator<HttpService>();
  final router = locator<RouterService>();
  bool loading = true;
  bool senderCardExpanded = false;
  List<Order2>orders = [];

  void getUserOrders()async{
    var response = await requests.getOrders();
    int statusCode = response.statusCode;
    if(statusCode == 200){

    }
   /* if(statusCode == 200){
      List<dynamic> body = jsonDecode(response.body);
      print(body);
      for(int y=0;y<body.length;y++){
        Map<String,dynamic>object = body[y];
        Map<String,dynamic>carrierObject = object['carrier_type'];
        String id = carrierObject['id'];
        String carrierName = "";
        String carrierPhoto = "";

        if(id == "1"){
          carrierName = "Cargo Truck";
          carrierPhoto = AppImages.cargoTruck;
        }
        else if(id == ""){

        }
      }
    } */
   loading = false;
   notifyListeners();
  }

  void senderCardArrowClicked(){
    senderCardExpanded = !senderCardExpanded;
    notifyListeners();
  }

  void recipientCardArrowClicked(List<Recipient>recipientList, index){
    getRecipientsHeight(recipientList);
    recipientList[index].cardExpanded = !recipientList[index].cardExpanded;
    notifyListeners();
  }

  double getRecipientsHeight(List<Recipient>recipientList){
    int closedHeight = 100;
    int openHeight = 350;
    int total = 0;
    for(int i=0;i<recipientList.length;i++){
      if(recipientList[i].cardExpanded == true){
        total = total + openHeight;
      }
      else{
        total = total + closedHeight;
      }
    }
    return total.toDouble();
  }

}