
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:pickappuser/config/locator.dart';
import 'package:pickappuser/constants/app_constants.dart';
import 'package:pickappuser/constants/routes.dart';
import 'package:pickappuser/constants/utils.dart';
import 'package:pickappuser/models/carrier_information_model.dart';
import 'package:pickappuser/models/recipient_information_model.dart';
import 'package:pickappuser/models/sender_information_model.dart';
import 'package:pickappuser/services/data.service.dart';
import 'package:pickappuser/services/dialog.service.dart';
import 'package:pickappuser/services/http.service.dart';
import 'package:pickappuser/services/local.notification.service.dart';
import 'package:pickappuser/services/router.service.dart';
import 'package:pickappuser/ui/shared/customButton.dart';
import 'package:pickappuser/ui/shared/myTextInput.dart';


class CreateOrderProvider extends ChangeNotifier{

  TabController tabController;
  CarrierInformationModel carrierDetails = new CarrierInformationModel();
  SenderInformationModel senderDetails = new SenderInformationModel();
  List<RecipientInformationModel>recipientsDetails = [];
  var recipientsDetailsHeight = 0.00;
  var serviceCharge ="";
  var orderCode = "";

  final requests = locator<HttpService>();
  final router = locator<RouterService>();

  initialize(){

  }

  void totalDistanceTravelled(BuildContext context) async {
      double totalDistance = 0;
      //Get distance between geo coordinates using google direction matrix api
      String url = "https://maps.googleapis.com/maps/api/distancematrix/json"
          "?units=imperial&origins=${senderDetails.pickUpLatitude},${senderDetails.pickUpLongitude}&destinations=";

      for(int y=0;y<recipientsDetails.length;y++){
        int finalIndex = recipientsDetails.length - 1;
        if(y == finalIndex){
          url = url+recipientsDetails[y].recipientDeliveryLatitude+"%2C"+recipientsDetails[y].recipientDeliveryLongitude;
        }
        else{
          url = url+recipientsDetails[y].recipientDeliveryLatitude+"%2C"+recipientsDetails[y].recipientDeliveryLongitude+"%7C";
        }
      }
      url = url+"&key="+AppConstants.googlePlacesAPIKey;
      print(url);

      Utils.getProgressBar(context, "Loading,please wait..", "showProgress");

      var response = await requests.getDistanceAndTime(url);
      print(response);
      int code = response.statusCode;
      print(code);
      if(code == 200){
        Map<String, dynamic> body = jsonDecode(response.body);
        List<dynamic>results = body['rows'];
        List<dynamic>element = results[0]['elements'];
        for(int i =0;i<element.length;i++){
          Map<String,dynamic>object = element[i];
          Map<String,dynamic>distanceObject = object['distance'];
          int distanceValue = distanceObject['value'];
          double distanceInKilometers = distanceValue/1000;
          print(distanceInKilometers);
          totalDistance = totalDistance + distanceInKilometers;
        }

      }
      else{
        print("Please check Internet");
      }
      String tDist = totalDistance.toString();

      var serviceChargeResponse = await requests.getServiceCharge(tDist, carrierDetails.selectedCarrierType.carrierId);
      Map<String, dynamic> body2 = jsonDecode(serviceChargeResponse.body);
      var charge = body2['charge'];
      double rounded = charge.roundToDouble();
      serviceCharge = rounded.toString();


      Utils.getProgressBar(context, "Loading,please wait..", "");
      router.navigateTo(AppRoutes.paymentScreenRoute);



  }

  void paymentDialog(BuildContext context,String network){
    TextEditingController networkController = new TextEditingController(text:network);
    String amountToPay = "GHS $serviceCharge";
    DialogService().showCustomDialog(context: context,
        customDialog: Container(
          height: 450,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 15),
                height: 150,
                width: 250,
                child: Center(
                  child: Lottie.asset("assets/animations/mobile_payment0.json")
                ),
              ),
              SizedBox(height: 10,),
              Text(
                amountToPay,
                style: TextStyle(
                    color: Colors.purple[900],
                    fontWeight: FontWeight.w700,
                    fontSize: 18
                ),
              ),
              Container(
                margin: EdgeInsets.only(left:10,right:10,top: 10,bottom: 5),
                child: MyTextInputField(
                  label: "Network",
                  readOnly: true,
                  controller: networkController,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left:10,right:10,top:5,bottom: 5),
                child: MyTextInputField(
                  label: "Name",
                  textEntryType: TextInputType.text,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left:10,right:10,top: 5,bottom: 5),
                child: MyTextInputField(
                  label: "Phone",
                  textEntryType: TextInputType.phone,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left:10,right:10,top: 5,bottom: 5),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: CustomButton(
                        title: "Pay",
                        height: 50,
                        onPressed: (){
                          print("Order Process Pending");
                          //router.navigateTo(AppRoutes.dashboardRoute);
                          saveOrder(context);
                        },
                      )

                      /*ButtonTheme(
                        height: 50,
                        child: RaisedButton(
                          color: Colors.amber[900],
                          child: Text(
                            "Pay",
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Colors.amber[900],
                                  width: 1,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(5)),
                          onPressed: (){
                            print("Order Process Pending");
                            //router.navigateTo(AppRoutes.dashboardRoute);
                            saveOrder(context);
                          },
                        ),
                      ),*/
                    )
                  ],
                ),
              )

            ],
          ),
        ));
  }

  void saveOrder(BuildContext context)async{


    

    // ignore: unused_local_variable
    String amSender ="",amSenderBool;
    // ignore: unused_local_variable
    String packaFrag="",packageFragileBool;
    if(senderDetails.iAmSender == true){
      amSender = "1";
      amSenderBool = "true";
    }else{
      amSender = "0";
      amSenderBool = "false";
    }
    if(carrierDetails.packageFragile == true){
      packaFrag = "1";
      packageFragileBool = "true";
    }
    else{
      packaFrag = "0";
      packageFragileBool = "false";
    }

    Utils.getProgressBar(context, "Loading,please wait..", "showProgress");

    var response = await requests.saveOrder(
        carrierDetails.selectedCarrierType.carrierId,
        carrierDetails.selectedPackageSize.packageId,
        carrierDetails.itemQuantity, amSender,
        carrierDetails.itemDescription, packaFrag,
        serviceCharge,
        senderDetails.senderName,senderDetails.senderPhone,
        senderDetails.pickUpDescription,
        senderDetails.pickUpLatitude,
        senderDetails.pickUpLongitude,senderDetails.pickUpTime,
        recipientsDetails
    );

    //Get Storage Preferences
    //SharedPreferences _prefs = await SharedPreferences.getInstance();
    //String bearerToken = _prefs.getString(LocalStorageName.bearerToken);
    //String senderImg = _prefs.getString(LocalStorageName.userAvatar);

    if(response.statusCode < 400){
      Map<String, dynamic> body = jsonDecode(response.body);

      String orderId = body['order_id'].toString() ?? null;
      orderCode = body['order_code'].toString() ?? null;

      updateOrderStatus(context,orderId);
      //pushOrderToFirebase(context,orderId,apiToken,firebaseToken,orderCode,packageFragileBool,senderImg);

    }else{
      //print("Error");\
      Map<String, dynamic> errorBody = jsonDecode(response.body);
      print("$errorBody \n Error");

    }



  }

  void updateOrderStatus(BuildContext context,String orderId){
    final  orderTrackingReference = FirebaseDatabase.instance.reference().child("Flutter").child("Order Tracking")
        .child(orderId);
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm EEE d MMM').format(now);
    orderTrackingReference.child("a1").set(
        {
          "time":formattedDate,
          "status":"Order placed successfully"
        }
    ).then((value) => notifyLocally(context));
  }

  String getMonth(int month){
    if(month == 1){
      return "January";
    }
    else if(month == 2){
      return "Febuary";
    }
    else if(month == 3){
      return "March";
    }
    else if(month == 4){
      return "April";
    }
    else if(month == 5){
      return "May";
    }
    else if(month == 6){
      return "June";
    }
    else if(month == 7){
      return "July";
    }
    else if(month == 8){
      return "August";
    }
    else if(month == 9){
      return "September";
    }
    else if(month == 10){
      return "October";
    }
    else if(month == 11){
      return "November";
    }
    else {
      return "December";
    }
  }

  notifyLocally(BuildContext context)async{
    Utils.getProgressBar(context, "Loading,please wait..", "");
    print("Locally notified");
    List<String>notificationDates = await DataService().getStringList("notificationDates");
    var date = new DateTime.now().toString();
    var dateParse = DateTime.parse(date);
    String month = getMonth(dateParse.month);
    String formattedDate = "${dateParse.day} $month ${dateParse.year}";
    notificationDates.add(formattedDate);
    DataService().setStringList("notificationDates",notificationDates);

    //Get Notification body
    List<String>notificationBody = await DataService().getStringList("notificationBody");
    notificationBody.add("Successfully placed order for pick up");
    DataService().setStringList("notificationBody",notificationBody);

    LocalNotificationService().showNotificationMediaStyle("PickApp Order","Successfully placed order for pick up",AppRoutes.orderDetailsRoute);


    router.navigateTo(AppRoutes.dashboardRoute);
  }

}