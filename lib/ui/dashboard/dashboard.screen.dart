
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pickappuser/config/locator.dart';
import 'package:pickappuser/constants/app_constants.dart';
import 'package:pickappuser/constants/images.dart';
import 'package:pickappuser/models/order_item2.dart';
import 'package:pickappuser/models/order_recipient.dart';
import 'package:pickappuser/providers/newOrder.provider.dart';
import 'package:pickappuser/services/http.service.dart';
import 'package:pickappuser/services/local.notification.service.dart';
import 'package:pickappuser/services/router.service.dart';
import 'package:pickappuser/ui/createOrder2/createOrder.screen.dart';
import 'package:pickappuser/ui/orderDetail2/orderDetail2.screen.dart';
import 'package:pickappuser/ui/shared/myBaseScreen.dart';
import 'package:provider/provider.dart';

class DashBoardScreen extends StatefulWidget{

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}
class _DashBoardScreenState extends State<DashBoardScreen>{
  var router = locator<RouterService>();
  final requests = locator<HttpService>();
  var localNotification = locator<LocalNotificationService>();


  bool loading = true;
  List<Order2>myOrders = [];
  @override
  void initState() {
   
    super.initState();
    checkForOrders();
  }

  void checkForOrders()async{

 

    var response = await requests.getOrders();
    int statusCode = response.statusCode;
    if(statusCode == 200){
      List<dynamic> body = jsonDecode(response.body);
      for(int y=0;y<body.length;y++){
        Map<String,dynamic>object = body[y];
        Map<String,dynamic>carrierObject = object['carrier_type'];
        int id = carrierObject['id'];
        String carrierName = "";
        String carrierPhoto = "";

        //Getting Carrier details
        if(id == 1){
          carrierName = "Cargo Truck";
          carrierPhoto = AppImages.cargoTruck;
        }
        else if(id == 2){
          carrierName = "Mini Truck";
          carrierPhoto = AppImages.miniTruck;
        }
        else if(id == 3){
          carrierName = "Motor Cycle";
          carrierPhoto = AppImages.motorCycle;
        }
        else if(id == 4){
          carrierName = "Postman";
          carrierPhoto = AppImages.postman;
        }

        //Getting Package Details
        Map<String,dynamic>packageObject = object['package_size'];
        String packageDimension = "";
        String packageImage = "";
        int packageId = packageObject['id'];

        if(packageId == 1){
          packageDimension = AppConstants.envelopeDimension;
          packageImage = AppImages.envelope;
        }
        else if(packageId == 2){
          packageDimension = AppConstants.box2Dimension;
          packageImage = AppImages.box2;
        }
        else if(packageId == 3){
          packageDimension = AppConstants.box3Dimension;
          packageImage = AppImages.box3;
        }
        else if(packageId == 4){
          packageDimension = AppConstants.box4Dimension;
          packageImage = AppImages.box4;
        }

        String orderDescription = object['description'];
        int quantity = object['quantity'];
        String orderQuantity = "$quantity";
        String serviceCharge = object['cost'];
        int orderId = object['id'];
        String orderCode = object['code'];
        String orderFragile = "";
        String orderStatus = object['status'];
        bool isOrderFragile = object['is_fragile'];
        if(isOrderFragile == true){
          orderFragile = "Yes";
        }else{ orderFragile = "No";}
        String pickupLocationAddress = object['pickup_location_address'];
        String pickUpTime = object['pickup_at'];
        String pickUpCode = object['pickapp_code'];


        //Sender Object
        Map<String,dynamic>senderObject = object['issuer'];
        String senderName = senderObject['first_name']+" "+ senderObject['last_name'];
        String senderPhone = senderObject['phone'];

        List<dynamic>recipients = object['recipient'];
        List<Recipient>myRecipients = [];
        for(int i=0;i<recipients.length;i++){
          Map<String,dynamic>recipientObject = recipients[i];
          String recipientName = recipientObject['name'];
          String recipientPhone = recipientObject['phone'];
          String deliveryLocation = recipientObject['address'];
          String recipientConfirmationCode = recipientObject['confirmation_code'];
          myRecipients.add(
            new Recipient(
                name: recipientName,
                phone: recipientPhone,
                deliveryLocation: deliveryLocation,
                confirmationCode: recipientConfirmationCode,
                cardExpanded: false)
          );
        }
        myOrders.add(new Order2(
            packageSize: packageDimension,
            packageImageUrl: packageImage,
            carrierName: carrierName,
            carrierImageUrl: carrierPhoto,
            orderDescription: orderDescription,
            orderQuantity: orderQuantity,
            orderCharge: serviceCharge,
            orderCode: orderCode,
            orderStatus: orderStatus,
            orderFragile: orderFragile,
            senderName: senderName,
            senderPhone: senderPhone,
            pickUpLocation: pickupLocationAddress,
            pickUpCode: pickUpCode,
            pickUpDateTime: pickUpTime,
            recipients: myRecipients,
            orderId: "$orderId"
          )
        );

      }

    }
    setState(() {
      loading = !loading;
    });

  }

  String restructureDate(String date){
    // ignore: non_constant_identifier_names
    String date_year  = date.substring(0,4);
    // ignore: non_constant_identifier_names
    String date_month;
    if(date.substring(5,7).contains("01")){
      date_month = "Jan";
    }else if(date.substring(5,7).contains("02")){
      date_month = "Feb";
    }else if(date.substring(5,7).contains("03")){
      date_month = "Mar";
    }else if(date.substring(5,7).contains("04")){
      date_month = "Apr";
    }else if(date.substring(5,7).contains("05")){
      date_month = "May";
    }else if(date.substring(5,7).contains("06")){
      date_month = "Jun";
    }else if(date.substring(5,7).contains("07")){
      date_month = "Jul";
    }else if(date.substring(5,7).contains("08")){
      date_month = "Aug";
    }else if(date.substring(5,7).contains("09")){
      date_month = "Sep";
    }else if(date.substring(5,7).contains("10")){
      date_month = "Oct";
    }else if(date.substring(5,7).contains("11")){
      date_month = "Nov";
    }else{
      date_month = "Dec";
    }
    // ignore: non_constant_identifier_names
    String date_day = date.substring(8,10);
    return date_day+" "+date_month+" "+date_year;
  }

  String restructureTime(String date){
    String category = "";
    String actualHour = "";
    String hour = date.substring(11,13);
    String minuites = date.substring(14,16);
    int d = int.parse(hour);
    if(d>12){
      category = "PM";
      d = d-12;
      actualHour = d.toString();
    }
    else{
      category = "AM";
      actualHour = d.toString();
    }
    return "$actualHour:$minuites $category";
  }

  @override
  Widget build(BuildContext context) {

    final vm2 = Provider.of<NewOrderProvider>(context);
    // ignore: non_constant_identifier_names
    double device_width = MediaQuery.of(context).size.width;
    // ignore: non_constant_identifier_names
    double device_height = MediaQuery.of(context).size.height;


    Widget orderListItem(Order2 content,index){
      var statusColor;
      if(content.orderStatus == "awaiting-pickup"){
        statusColor = Colors.red;
      }
      else if(content.orderStatus == "accepted"){
        statusColor = Colors.amber;
      }
      else if(content.orderStatus == "delivered"){
        statusColor = Colors.green;
      }
      else{
        statusColor = Colors.grey;
      }

      return Container(
          width: device_width,
          height: 110,
          margin: EdgeInsets.only(left:20,right: 20,top:10),
          child: Stack(
            children: <Widget>[
              Card(
                elevation: 3,
                color: Colors.white,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      color: statusColor,
                      width: 3,
                      height: 100,
                    ),
                    Expanded(
                      child: Container(
                        height: 100,
                        margin: EdgeInsets.only(left:15,right: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 20,),
                            Row(
                              children: <Widget>[
                                Text("Sender:",style: TextStyle(color: Colors.grey),),
                                SizedBox(width: 10,),
                                Text(content.senderName,style: TextStyle(color: Colors.black),)
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: <Widget>[
                                Text("Order Code:",style: TextStyle(color: Colors.grey),),
                                SizedBox(width: 10,),
                                Text(content.orderCode,style: TextStyle(color: Colors.black),)
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: <Widget>[
                                Text("Date:",style: TextStyle(color: Colors.grey),),
                                SizedBox(width: 10,),
                                Text(restructureDate(content.pickUpDateTime),style: TextStyle(color: Colors.black),)
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 100,
                      child: Center(
                        child: Icon(Icons.arrow_right,color: Colors.grey,size: 30,),
                      ),
                    )
                  ],
                ),
              ),
              new Positioned.fill(
                  child: new Material(
                      color: Colors.transparent,
                      child: new InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderDetail2Screen(myOrder:content),
                            ),
                          );
                        },
                      )))
            ],
          )
        );

    }

  
    return BaseScreen(
      title: "Orders",
      body: Stack(
        children: <Widget>[
          Container(
            width: device_width,
            height: device_height,
            padding: EdgeInsets.only(left:10,right: 10),
            color: Colors.white,
            child: myOrders.length>0?
                ListView.builder(
                  itemCount: myOrders.length,
                  itemBuilder: (context,index){
                    return orderListItem(myOrders[index], index);
                  },
                )
                : Center(
              child: Text(AppConstants.dashBoardIntroText,
                style: TextStyle(
                    color:Colors.black,
                    fontSize: 15
                ),
                textAlign: TextAlign.center,),
            ),
          ),
          Visibility(
            visible:loading,
            child: Container(
              width: device_width,
              height: device_height,
              color: Colors.black12,
              child: Center(
                child: Container(
                  height: 80,
                  color: Colors.white,
                  width: device_width,
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
                              "Loading orders,please wait",
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
          ),
        ],
      ),
      fab: FloatingActionButton(
        onPressed: (){
        //  localNotification.showPlainNotification("Name","Emmanuel Ashie");
         // Utils.getProgressBar(context,"Loading,Please wait","showProgress");
          vm2.initializeVariables();
          Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateOrderScreen()));
          print("Floating action button clicked");
        },
        backgroundColor: Colors.amber[900],
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
  
}