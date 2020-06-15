
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:pickappuser/config/locator.dart';
import 'package:pickappuser/constants/utils.dart';
import 'package:pickappuser/models/recipient_item.dart';
import 'package:pickappuser/services/http.service.dart';

class NewOrderProvider extends ChangeNotifier{
  final GlobalKey<AnimatedListState> listKey = GlobalKey();
  final requests = locator<HttpService>();

  List<RecipientData>recipientList = [
    new RecipientData(fullnameController: new TextEditingController(),
        phoneController: new TextEditingController(),
        deliveryInstructionController: TextEditingController(),
        deliveryLocationTextController: TextEditingController(),
        title: "Recipient 1 Detail",cardExpanded: true, iAmTheRecipient:false),
  ];

   bool packageFragile = false;
   bool iAmTheSender = false;


   bool recipientCardExpanded = true;

   bool firstPageVisible = true;
   bool secondPageVisible = false;
   bool thirdPageVisible = false;

   void recipientCardIconClick(int index){
      recipientList[index].cardExpanded = !recipientList[index].cardExpanded;
      notifyListeners();
   }
   void iAmRecipientClicked(bool newValue,int index){
      recipientList[index].iAmTheRecipient = newValue;
      notifyListeners();
   }

  void packageFragileOnClick(){
    packageFragile = !packageFragile;
    notifyListeners();
  }
  void navigateToSecondPage(){
    firstPageVisible = false;
    secondPageVisible = true;
    thirdPageVisible = false;
    notifyListeners();
  }
  void navigateToFirstPage(){
    firstPageVisible = true;
    secondPageVisible = false;
    thirdPageVisible = false;
    notifyListeners();
  }
  void navigateToThirdPage(){
    firstPageVisible = false;
    secondPageVisible = false;
    thirdPageVisible = true;
    notifyListeners();
  }
  void iAmTheSenderOnClick(){
    iAmTheSender = !iAmTheSender;
    notifyListeners();
  }

  void addToRecipientCard(){
     int recipientsSize = recipientList.length;
     int recipientNumber = recipientsSize + 1;
     String recipientNumberDetail = "Recipient $recipientNumber Detail";
     recipientList.add(new RecipientData(title: recipientNumberDetail,
         fullnameController: new TextEditingController(),
         phoneController: new TextEditingController(),
         deliveryInstructionController: new TextEditingController(),
         deliveryLocationTextController: new TextEditingController(),
         cardExpanded: false, iAmTheRecipient: false));

     listKey.currentState.insertItem(recipientsSize);

     notifyListeners();
  }

  void removeRecipientCard(int index){
    recipientList.removeAt(index);
    listKey.currentState.removeItem(index, (context, animation) => null);
    notifyListeners();
  }

  void getCarrierTypes(BuildContext context) async{
      Utils.getProgressBar(context, "Loading,please wait..", "showProgress");
      var response;
      response = await requests.getCarrierTypes();
      print(response);
      List<dynamic> body = jsonDecode(response.body);
      print(body);
      var name1 = body[0]['name'];
      print(name1);
     /* int code = response.statusCode;
      print("Status code:");
      print(code); */
      Utils.getProgressBar(context, "Loading,please wait..", "");

  }

  Widget carrierTypeItem(){

     return null;
  }


}