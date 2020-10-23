
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:pickappuser/config/locator.dart';
import 'package:pickappuser/models/order_item2.dart';
import 'package:pickappuser/models/order_recipient.dart';
import 'package:pickappuser/models/order_status.dart';
import 'package:pickappuser/services/http.service.dart';
import 'package:pickappuser/services/router.service.dart';


class DashBoardProvider extends ChangeNotifier{
  final requests = locator<HttpService>();
  final router = locator<RouterService>();
  bool loading = true;
  bool senderCardExpanded = false;
  bool riderCardExpanded = false;
  Order2 selectedOrder;
  bool showRiderCard;
  List<Order2>orders = [];
  String riderImage="",riderName="",riderPhone="",riderVehicleMake="",riderVehicleRegistration="";
  List<String>orderStatusList = new List();
  List<OrderStatus>orderStatusList2 = new List();

  void initializeProvider(Order2 order2){
    this.selectedOrder = order2;
    showRiderCard = false;
    orderStatusList.clear();
    orderStatusList2.clear();
    checkForRider();
    notifyListeners();
  }

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

  void riderCardArrowClicked(){
    riderCardExpanded = !riderCardExpanded;
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

  void checkForRider(){
    final matchingReference = FirebaseDatabase.instance.reference().child("Flutter").child("Matchings")
        .child(selectedOrder.orderId);
    matchingReference.once().then((DataSnapshot snapshot){
      if(snapshot.value!=null){
        showRiderCard = true;
        //snapshot.value['']
        riderImage = snapshot.value['driverImage'];
        riderName = snapshot.value['driverName'];
        riderPhone = snapshot.value['driverPhone'];
        riderVehicleMake = snapshot.value['vehicleName'];
        riderVehicleRegistration = snapshot.value['vehicleRegistration'];

        notifyListeners();
      }
      else{
        showRiderCard = false;
        notifyListeners();
      }
    }).then((value) => checkOrderStatus());
  }

  void checkOrderStatus(){
    print("Order ID: ${selectedOrder.orderId}");
     final orderStatusReference = FirebaseDatabase.instance.reference().child("Flutter").child("Order Tracking")
         .child(selectedOrder.orderId);
     orderStatusReference.onValue.listen((event) {
       orderStatusList2.clear();
       Map data2 = event.snapshot.value;
       if(data2!=null){
         List item = [];
         data2.forEach((index, data) => item.add({"key": index, ...data}));
         print("ResultListen:${event.snapshot.value}");
         for(int j=0;j<item.length;j++){
           print("Time: ${item[j]['time']}");
           orderStatusList2.add(new OrderStatus(date: item[j]['time'], action: item[j]['status']));
         }
         notifyListeners();
       }
     });

  }
}