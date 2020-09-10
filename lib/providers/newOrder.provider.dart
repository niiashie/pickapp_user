
import 'dart:convert';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:lottie/lottie.dart';
import 'package:pickappuser/config/locator.dart';
import 'package:pickappuser/constants/animations.dart';
import 'package:pickappuser/constants/app_constants.dart';
import 'package:pickappuser/constants/local_storage_name.dart';
import 'package:pickappuser/constants/routes.dart';
import 'package:pickappuser/constants/utils.dart';
import 'package:pickappuser/models/carrier_item.dart';
import 'package:pickappuser/models/order_item.dart';
import 'package:pickappuser/models/order_recipient.dart';
import 'package:pickappuser/models/package_item.dart';
import 'package:pickappuser/models/recipient_item.dart';
import 'package:pickappuser/services/data.service.dart';
import 'package:pickappuser/services/dialog.service.dart';
import 'package:pickappuser/services/http.service.dart';
import 'package:pickappuser/services/local.notification.service.dart';
import 'package:pickappuser/services/router.service.dart';
import 'package:pickappuser/ui/shared/myTextInput.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewOrderProvider extends ChangeNotifier{
  final GlobalKey<AnimatedListState> listKey = GlobalKey();
  final requests = locator<HttpService>();
  final router = locator<RouterService>();

  List<Recipient>certifiedRecipient = [];
  //final localStorage = locator<StorageService>();


  List<RecipientData>recipientList = [
    new RecipientData(title: "Recepient 1 Detail",
        fullnameController: new TextEditingController(),
        phoneController: new TextEditingController(),
        deliveryInstructionController: new TextEditingController(),
        deliveryLocationTextController: new TextEditingController(),
        cardExpanded: true, iAmTheRecipient: false,
        locationLatitude: "", locationLongitude:"", fullNameError: false,
        phoneError: false, deliveryLocationError: false)
  ];

  var recipientSizedBoxHeight = 450.00;
  var orderSummaryRecipientsSizedBoxHeight =0.00;
  String serviceCharge=null;
  String orderCode="";

   bool packageFragile = false;
   bool iAmTheSender = false;


   //Page navigator booleans
   bool firstPageVisible = true;
   bool secondPageVisible = false;
   bool thirdPageVisible = false;

   //Text editing controllers
   final carrierTypeCtrl = TextEditingController();
   final packageSizeCtrl = TextEditingController();
   final packageQuantityCtrl = TextEditingController();
   final itemDescriptionCtrl = TextEditingController();
   final senderFullNameCtrl = TextEditingController();
   final senderPhoneCtrl = TextEditingController();
   final pickUpLocationDesCtrl = TextEditingController();
   final pickUpInstructionCtrl = TextEditingController();



   //Selected Values
  CarrierType selectedCarrierType;
  PackageSizes selectedPackageSize;
  Order selectedOrder;

  //Lists
  List<CarrierType>carrierTypes = [];
  List<PackageSizes>packageSizes = [];

  //Error checkers
  bool carrierTypeError = false;
  bool packageSizeError = false;
  bool packQuantityError = false;
  bool itemDescriptionError = false;
  bool senderFullNameError = false;
  bool senderPhoneNumberError = false;
  bool pickUpLocationError = false;


  //String values
  String pickUpLocationLatitude,pickUpLocationLongitude,packageFragileAnswer="No";

  //Order Summary values
  bool carrierDetailsExpanded = true,carrierDetailsMinimized = false;
  bool senderDetailsExpanded = true,senderDetailsMinimized = false;


  void reset(BuildContext context){
    
     DialogService().showAlertDialog(context: context, message:"You will loose all your entries",
         type: AlertDialogType.warning,okayText: "Yes",cancelText: "No",
       onOkayBtnTap: (){
         initializeVariables();
         router.navigateTo(AppRoutes.dashboardRoute);
       },
       onCancelBtnTap: (){
         Navigator.pop(context);
       }
     );

  }

  void initializeVariables(){
    //Resetting order summary values
    carrierDetailsExpanded = true;
    carrierDetailsMinimized = false;
    senderDetailsExpanded = true;
    senderDetailsMinimized = false;

    //Resetting coordintes values
    pickUpLocationLatitude="";
    pickUpLocationLongitude="";
    packageFragileAnswer="No";

    //Resetting List
    carrierTypes = [];
    packageSizes = [];
    recipientList = [new RecipientData(title: "Recepient 1 Detail",
        fullnameController: new TextEditingController(),
        phoneController: new TextEditingController(),
        deliveryInstructionController: new TextEditingController(),
        deliveryLocationTextController: new TextEditingController(),
        cardExpanded: true, iAmTheRecipient: false,
        locationLatitude: "", locationLongitude:"", fullNameError: false,
        phoneError: false, deliveryLocationError: false)
    ];

    //Resetting textControllers
    carrierTypeCtrl.text = "";
    packageSizeCtrl.text = "";
    packageQuantityCtrl.text = "";
    itemDescriptionCtrl.text = "";
    senderFullNameCtrl.text = "";
    senderPhoneCtrl.text = "";
    pickUpLocationDesCtrl.text = "";
    pickUpInstructionCtrl.text = "";
  }

  void orderSummaryCarrierDetailsExpandableClicked(){
    carrierDetailsExpanded =!carrierDetailsExpanded;
    carrierDetailsMinimized = !carrierDetailsExpanded;
    notifyListeners();
  }

  void orderSummarySenderDetailsExpandableClicked(){
    senderDetailsExpanded =!senderDetailsExpanded;
    senderDetailsMinimized = !senderDetailsExpanded;
    notifyListeners();
  }

   void recipientCardIconClick(int index){
      recipientList[index].cardExpanded = !recipientList[index].cardExpanded;
      changeRecipientSizedBoxHeight();
      changeOrderSummaryRecipientsHeight();
      notifyListeners();
   }

   void iAmRecipientClicked (bool newValue,int index) async{
     SharedPreferences preferences = await SharedPreferences.getInstance();
     String userName =preferences.getString(LocalStorageName.userName);
     String userPhone =preferences.getString(LocalStorageName.userPhone);
     recipientList[index].iAmTheRecipient = newValue;
     if(newValue == true){
       //Clear other I am the recipient checked
       for(int i=0;i<recipientList.length;i++){
         if(i!=index){
           iAmRecipientClicked(false, i);
         }
       }

       recipientList[index].fullnameController.text = userName;
       recipientList[index].phoneController.text = userPhone;


       if(iAmTheSender == true){
         iAmTheSender = false;
         senderFullNameCtrl.text = "";
         senderPhoneCtrl.text = "";
         navigateToSecondPage();
       }
     }
     else{
       recipientList[index].fullnameController.text = "";
       recipientList[index].phoneController.text = "";
     }
     notifyListeners();

   }

   void checkSenderName(){
     if(senderFullNameCtrl.text.isEmpty){
       senderFullNameError = true;
     }
     else{
       senderFullNameError = false;
     }
   }

   void checkSenderPhone(){
     if(senderPhoneCtrl.text.length!=10){
       senderPhoneNumberError = true;
     }
     else{
       senderPhoneNumberError = false;
     }
   }

   void checkPickUpLocation(){
     if(pickUpLocationDesCtrl.text.isEmpty){
       pickUpLocationError = true;
     }else{
       pickUpLocationError = false;
     }
   }

  void checkCarrierType(){
     if(carrierTypeCtrl.text.isEmpty){
       carrierTypeError = true;
     }
     else{
       carrierTypeError = false;
     }
  }

  void checkPackageSize(){
     if(packageSizeCtrl.text.isEmpty){
       packageSizeError = true;
     }
     else{
       packageSizeError = false;
     }
  }

  void checkItemQuantity(){
     if(packageQuantityCtrl.text.isEmpty){
       packQuantityError = true;
     }
     else{
       packQuantityError = false;
     }
  }

  void checkItemDescription(){
     if(itemDescriptionCtrl.text.isEmpty){
       itemDescriptionError = true;
     }
     else{
       itemDescriptionError = false;
     }
  }

  void packageFragileOnClick(){
    packageFragile = !packageFragile;
    if(packageFragile == true){
      packageFragileAnswer = "Yes";
    }else{
      packageFragileAnswer = "No";
    }
    notifyListeners();
  }

  void navigateToSecondPage(){
    checkCarrierType();
    checkPackageSize();
    checkItemQuantity();
    checkItemDescription();
    print("packQuanitytError : $packQuantityError \n");
    print("carrierTypeError : $carrierTypeError \n");
    print("packageSizeErrpr : $packageSizeError \n");
    print("ItemDescriptionError");
    print(itemDescriptionError);

    notifyListeners();


    if(packQuantityError== false && carrierTypeError == false && packageSizeError == false && itemDescriptionError == false){
      firstPageVisible = false;
      secondPageVisible = true;
      thirdPageVisible = false;
      notifyListeners();
    }
  }

  void navigateToFirstPage(){
    firstPageVisible = true;
    secondPageVisible = false;
    thirdPageVisible = false;
    notifyListeners();
  }

  void navigateToThirdPage(){
     checkSenderName();
     checkSenderPhone();
     checkPickUpLocation();
     notifyListeners();

     if(senderFullNameError == false && senderPhoneNumberError == false && pickUpLocationError == false){
       firstPageVisible = false;
       secondPageVisible = false;
       thirdPageVisible = true;
       notifyListeners();
     }
  }

  void iAmTheSenderOnClick() async{
     SharedPreferences preferences = await SharedPreferences.getInstance();
     String userName = preferences.getString(LocalStorageName.userName);
     String userPhone =preferences.getString(LocalStorageName.userPhone);

     //Check if iAmRecipeient is selected
     for(int i=0;i<recipientList.length;i++){
       if(recipientList[i].iAmTheRecipient == true){
         iAmRecipientClicked (false,i);
       }
     }

    iAmTheSender = !iAmTheSender;
    if(iAmTheSender == true){
      senderFullNameCtrl.text = userName;
      senderPhoneCtrl.text = userPhone;
    }
    else{
      senderFullNameCtrl.text = "";
      senderPhoneCtrl.text = "";
    }
    notifyListeners();
  }

  void addToRecipientCard(){
     int recipientsSize = recipientList.length;
     int recipientNumber = recipientsSize + 1;
     String recipientNumberDetail = "Recipient $recipientNumber Detail";
     recipientList.add(new RecipientData(title:recipientNumberDetail,
         fullnameController: new TextEditingController(),
         phoneController:new TextEditingController(),
         deliveryInstructionController: new TextEditingController(),
         deliveryLocationTextController: new TextEditingController(),
         cardExpanded: false, iAmTheRecipient: false,
         locationLatitude: "", locationLongitude: "", fullNameError: false,
         phoneError: false, deliveryLocationError: false));

     listKey.currentState.insertItem(recipientsSize);
     changeRecipientSizedBoxHeight();
     changeOrderSummaryRecipientsHeight();
     notifyListeners();
  }

  void removeRecipientCard(int index){
    recipientList.removeAt(index);
    listKey.currentState.removeItem(index, (context, animation) => null);
    changeRecipientSizedBoxHeight();
    changeOrderSummaryRecipientsHeight();
    notifyListeners();
  }



  void getCarrierTypes(BuildContext context) async{
      Utils.getProgressBar(context, "Loading,please wait", "showProgress");
      var response;
      response = await requests.getCarrierTypes();
      print(response);
      List<dynamic> body = jsonDecode(response.body);
      print(body);
      for(int i=0;i<body.length;i++){
        carrierTypes.add(new CarrierType(carrierId: body[i]['id'], carrierName: body[i]['name'], carrierImageUrl: body[i]['photo']));
        print(body[i]['name']);
      }
      Utils.getProgressBar(context, "Loading,please wait..", "");

      //Showing Carrier Types Dialog
      DialogService().showCustomDialog(
        context: context,
        customDialog: Container(
          height: 400,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left:15,top:20,bottom: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Carrier Types",
                    style: TextStyle(color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 17
                    ),
                  ),
                )
              ),
              SizedBox(
                height: 300,
                child: GridView.count(
                    crossAxisCount: 2,
                    children: List.generate(carrierTypes.length, (index){
                      return Center(
                        child: CarrierTypeItem(carrierTypes[index],index,context),
                      );
                    })
                ),
              ),
              Container(
                margin: EdgeInsets.only(right:10),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    child:  Text("CANCEL",style: TextStyle(color: Colors.grey),),
                    onTap: (){
                      Navigator.pop(context);
                    },
                  )

                ),
              )

            ],
          )

        ),
        barrierDismissible: true
      );

      notifyListeners();

  }



  Widget CarrierTypeItem(CarrierType content,index,BuildContext context){
     return InkWell(
       child: Container(
         width: 100,
         height: 100,
         child: Column(
           children: <Widget>[
             Image.network(content.carrierImageUrl,height: 60,width: 100,),
             Container(
               height: 40,
               width: 100,
               child: Center(
                 child: Text(
                     content.carrierName
                 ),
               ),
             )
           ],
         ),
       ),
       onTap: (){
         carrierTypeCtrl.text = carrierTypes[index].carrierName;
         selectedCarrierType = carrierTypes[index];
         notifyListeners();
         Navigator.pop(context);
       },
     );
  }

  void getPackageSizes(BuildContext context) async{
    Utils.getProgressBar(context, "Loading,please wait..", "showProgress");
    var response;
    response = await requests.getPackageSizes();
    print(response);
    List<dynamic> body = jsonDecode(response.body);
    print(body);
    packageSizes.clear();
    for(int i=0;i<body.length;i++){
      packageSizes.add(new PackageSizes(packageName: body[i]['name'],
          packageSize: body[i]['dimension'],
          packageWeight: body[i]['weight'],
          packagePhoto: body[i]['photo'],
          packageId: body[i]['id']
      ));
      print(body[i]['name']);
    }
    Utils.getProgressBar(context, "Loading,please wait..", "");

    //Showing Carrier Types Dialog
    DialogService().showCustomDialog(
        context: context,
        customDialog: Container(
            height: 500,
            child: Column(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(left:15,top:20,bottom: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Package Sizes",
                        style: TextStyle(color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 17
                        ),
                      ),
                    )
                ),
                SizedBox(
                  height: 400,
                  child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 100/150,
                      children: List.generate(packageSizes.length, (index){
                        return Center(
                          child: PackageSizesItem(packageSizes[index],index,context),
                        );
                      })
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right:10),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        child:  Text("CANCEL",style: TextStyle(color: Colors.grey),),
                        onTap: (){
                          Navigator.pop(context);
                        },
                      )

                  ),
                )

              ],
            )

        ),
        barrierDismissible: true
    );

    notifyListeners();

  }

  Widget PackageSizesItem(PackageSizes content,index,BuildContext context){
    return InkWell(
      child: Container(
        width: 100,
        child: Column(
          children: <Widget>[
            Image.network(content.packagePhoto,height: 60,width: 100,),
            Container(
              height: 40,
              width: 100,
              child: Center(
                child: Text(
                    content.packageName
                ),
              ),
            ),

            Container(
              height: 40,
              width: 100,
              child: Center(
                child: Text(
                    content.packageSize
                ),
              ),
            ),

            Container(
              height: 40,
              width: 100,
              child: Center(
                child: Text(
                    content.packageWeight
                ),
              ),
            )
          ],
        ),
      ),
      onTap: (){
        packageSizeCtrl.text = packageSizes[index].packageName;
        selectedPackageSize = packageSizes[index];
        notifyListeners();
        Navigator.pop(context);
      },
    );
  }

  Future<void> searchPlaces(BuildContext context) async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
    Prediction p = await PlacesAutocomplete.show(
      context: context,
      apiKey: AppConstants.googlePlacesAPIKey,
      onError: onError,
      mode: Mode.fullscreen,
      language: "en",
      components: [Component(Component.country, "gh")],
    );

    displayPrediction(p);
  }

  void onError(PlacesAutocompleteResponse response) {
    /*omeScaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(response.errorMessage)),
    ); */
    print(response.errorMessage);
  }

  Future<Null> displayPrediction(Prediction p) async {
    GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: AppConstants.googlePlacesAPIKey);
    if (p != null) {
      // get detail (lat/lng)
      PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);
      final lat = detail.result.geometry.location.lat;
      final lng = detail.result.geometry.location.lng;

      pickUpLocationDesCtrl.text = detail.result.name;
      pickUpLocationLatitude = lat.toString();
      pickUpLocationLongitude = lng.toString();
     // print("The selected place has longitude: $lng and latitude: $lat");
      notifyListeners();
    }
  }

  Future<void> recipientDeliveryLocation(RecipientData recipient,BuildContext context) async {
    Prediction p = await PlacesAutocomplete.show(
      context: context,
      apiKey: AppConstants.googlePlacesAPIKey,
      onError: onError,
      mode: Mode.fullscreen,
      language: "en",
      components: [Component(Component.country, "gh")],
    );
    populateRecipientDelivery(p,recipient);
  }

  Future<Null> populateRecipientDelivery(Prediction p,RecipientData recipient) async {
    GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: AppConstants.googlePlacesAPIKey);
    if (p != null) {
      // get detail (lat/lng)
      PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);
      final lat = detail.result.geometry.location.lat;
      final lng = detail.result.geometry.location.lng;

      recipient.deliveryLocationTextController.text = detail.result.name;
      recipient.locationLatitude = lat.toString();
      recipient.locationLongitude = lng.toString();
      // print("The selected place has longitude: $lng and latitude: $lat");
      notifyListeners();
    }
  }

  void checkRecipientData(){
     int errorCounter = 0;
     for(int i=0;i<recipientList.length;i++){
       //Check Full name for errors
       if(recipientList[i].fullnameController.text.isEmpty){
         recipientList[i].fullNameError = true;
         errorCounter = errorCounter + 1;
       }else{
         recipientList[i].fullNameError = false;
       }

       //Check Phone number for errors
       if(recipientList[i].phoneController.text.length!=10){
         recipientList[i].phoneError = true;
         errorCounter = errorCounter + 1;
       }
       else{
         recipientList[i].phoneError = false;
       }

       //Check Delivery Locations
       if(recipientList[i].deliveryLocationTextController.text.isEmpty){
         recipientList[i].deliveryLocationError = true;
         errorCounter = errorCounter + 1;
       }
       else{
         recipientList[i].deliveryLocationError = false;
       }


     }
     if(errorCounter == 0){
       collapseRecipientCards();
       router.navigateTo(AppRoutes.orderSummaryScreenRoute);
     }
     notifyListeners();
  }

  void collapseRecipientCards(){
    for(int y=0;y<recipientList.length;y++){
      recipientList[y].cardExpanded = false;
    }
    changeRecipientSizedBoxHeight();
    changeOrderSummaryRecipientsHeight();
  }

  void changeRecipientSizedBoxHeight(){
     double closedHeight = 70.00;
     double expandedHeight = 450.00;
     double totalHeight = 0;
     for(int y=0;y<recipientList.length;y++){
       if(recipientList[y].cardExpanded == true){
         totalHeight = totalHeight + expandedHeight;
       }else{
         totalHeight = totalHeight + closedHeight;
       }
     }
     recipientSizedBoxHeight = totalHeight;
     notifyListeners();
  }

  void changeOrderSummaryRecipientsHeight(){
    double closedHeight = 100;
    double expandedHeight = 300;
    double totalHeight = 0;
    for(int y=0;y<recipientList.length;y++){
      if(recipientList[y].cardExpanded == true){
        totalHeight = totalHeight + expandedHeight;
      }else{
        totalHeight = totalHeight + closedHeight;
      }
    }
    orderSummaryRecipientsSizedBoxHeight = totalHeight;
    notifyListeners();
  }


  void totalDistanceTravelled(BuildContext context) async {
    if(serviceCharge==null){
      double totalDistance = 0;
      //Get distance between geo coordinates using google direction matrix api
      String url = "https://maps.googleapis.com/maps/api/distancematrix/json"
          "?units=imperial&origins=$pickUpLocationLatitude,$pickUpLocationLongitude&destinations=";

      for(int y=0;y<recipientList.length;y++){
        int finalIndex = recipientList.length - 1;
        if(y == finalIndex){
          url = url+recipientList[y].locationLatitude+"%2C"+recipientList[y].locationLongitude;
        }
        else{
          url = url+recipientList[y].locationLatitude+"%2C"+recipientList[y].locationLongitude+"%7C";
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

      var serviceChargeResponse = await requests.getServiceCharge(tDist, selectedCarrierType.carrierId);
      Map<String, dynamic> body2 = jsonDecode(serviceChargeResponse.body);
      double charge = body2['charge'];
      double rounded = charge.roundToDouble();
      serviceCharge = rounded.toString();


      Utils.getProgressBar(context, "Loading,please wait..", "");
      router.navigateTo(AppRoutes.paymentScreenRoute);

    }
    else{
      router.navigateTo(AppRoutes.paymentScreenRoute);
    }

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
                  child:  Lottie.network(
                      'https://assets9.lottiefiles.com/packages/lf20_7Ht9wn.json'),
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
                       child: ButtonTheme(
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
                             saveOrder(context);
                           },
                         ),
                       ),
                     )
                   ],
                 ),
               )

             ],
           ),
         ));
  }

  void saveOrder(BuildContext context)async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String apiToken = pref.getString(LocalStorageName.bearerToken);
    String firebaseToken = pref.getString(LocalStorageName.FCMToken);

    String amSender ="",amSenderBool;
    String packaFrag="",packageFragileBool;
    if(iAmTheSender == true){
      amSender = "1";
      amSenderBool = "true";
    }else{
      amSender = "0";
      amSenderBool = "false";
    }
    if(packageFragile == true){
      packaFrag = "1";
      packageFragileBool = "true";
    }
    else{
      packaFrag = "0";
      packageFragileBool = "false";
    }

    Utils.getProgressBar(context, "Loading,please wait..", "showProgress");

    var response = await requests.saveOrder(selectedCarrierType.carrierId, selectedPackageSize.packageId,
        packageQuantityCtrl.text.isNotEmpty ? packageQuantityCtrl.text:"", amSender,
        itemDescriptionCtrl.text.isNotEmpty ? itemDescriptionCtrl.text:"", packaFrag,
        serviceCharge,senderFullNameCtrl.text,senderPhoneCtrl.text, pickUpLocationDesCtrl.text,
        pickUpLocationLatitude,pickUpLocationLongitude,
      recipientList
    );

    //Get Storage Preferences
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String bearerToken = _prefs.getString(LocalStorageName.bearerToken);
    String senderImg = _prefs.getString(LocalStorageName.userAvatar);

    if(response.statusCode == 200){
      Map<String, dynamic> body = jsonDecode(response.body);

      String orderId = body['order_id'].toString() ?? null;
      orderCode = body['order_code'].toString() ?? null;

      print(body);
      pushOrderToFirebase(context,orderId,apiToken,firebaseToken,orderCode,packageFragileBool,senderImg);

    }else{
      print("Error");
    }




  }

  void pushOrderToFirebase(BuildContext context,String orderId,String senderToken,String FCMToken,
      String orderCode,String orderFragile,String senderImgURL)async{
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);

    final databaseReference = FirebaseDatabase.instance.reference().child("Flutter").child(selectedCarrierType.carrierId)
    .child("PendingOrders").child(orderId);

    final TransactionResult transactionResult =
        await databaseReference.runTransaction((MutableData mutableData) async {
      mutableData.value = (mutableData.value ?? 0) + 1;

      return mutableData;
    });

    if(transactionResult.committed){
      databaseReference.set({
        'firebaseToken':FCMToken,
        'locationAddress':pickUpLocationDesCtrl.text,
        'orderCode':orderCode,
        'orderDescription':itemDescriptionCtrl.text,
        'orderFragile': orderFragile,
        'orderID':orderId,
        'orderQuantity': packageQuantityCtrl.text,
        'packageID':selectedPackageSize.packageId,
        'pickUpDate':date.toString(),
        'pickUpInstruction': pickUpInstructionCtrl.text.isNotEmpty? pickUpInstructionCtrl.text:"",
        'pickUpLatitude':pickUpLocationLatitude,
        'pickUpLongitude':pickUpLocationLongitude,
        'senderAPIToken':senderToken,
        'senderName':senderFullNameCtrl.text,
        'senderPhone':senderPhoneCtrl.text,
        'senderPhoto':senderImgURL,
        'serviceCharge':serviceCharge
      }).then((value) => {
        pushRecipientsToFirebase(context,orderId),
        getCertifiedRecipients()
      });
    }
    else{
      Utils.getProgressBar(context, "Loading,please wait..", "");
      DialogService().showAlertDialog(context: context, message:"Please check Internet", type:AlertDialogType.error,
       showCancelBtn: false, okayText: "Okay",onOkayBtnTap: (){
            Navigator.pop(context);
          }
      );
    }

        /*.catchError((onError){
      Utils.getProgressBar(context, "Loading,please wait..", "");
      print("Something went wrong: ${onError.message}");
    });
    Utils.getProgressBar(context, "Loading,please wait..", ""); */

  }

  void pushRecipientsToFirebase(BuildContext context,String orderId)async{
    final recipients = FirebaseDatabase.instance.reference().child("Flutter").child("Recipients").child(orderId);

    final TransactionResult transactionResult = await recipients.runTransaction((MutableData mutableData) async {
      mutableData.value = (mutableData.value ?? 0) + 1;

      return mutableData;
    });
    for(int i=0;i<recipientList.length;i++){
      int lastIndex = recipientList.length -1;
      if(transactionResult.committed){
        recipients.push().set({
          'deliveryAddress': recipientList[i].deliveryLocationTextController.text,
          'deliveryInstruction':recipientList[i].deliveryInstructionController.text.isNotEmpty ? recipientList[i].deliveryInstructionController.text:"",
          'latitude':recipientList[i].locationLatitude,
          'longitude':recipientList[i].locationLongitude,
          'name':recipientList[i].fullnameController.text,
          'phone':recipientList[i].phoneController.text
        });
        if(i==lastIndex){
          //Get Notification date
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
          print("Present");
          router.navigateTo(AppRoutes.dashboardRoute);
         // Utils.getProgressBar(context, "Loading,please wait..", "");
        }
      }
    }
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

  void getCertifiedRecipients(){
    certifiedRecipient.clear();
    for(int i =0;i<recipientList.length;i++){
      certifiedRecipient.add(
        new Recipient(
            name:recipientList[i].fullnameController.text,
            phone: recipientList[i].phoneController.text,
            deliveryLocation: recipientList[i].deliveryLocationTextController.text,
            confirmationCode: "pending",
            cardExpanded: false)
      );
    }
  }

  bool senderCardExpanded = false;

  void senderCardArrowClicked(){
    senderCardExpanded = !senderCardExpanded;
    notifyListeners();
  }
  void recipientCardArrowClicked(index){
    getRecipientsHeight();
    certifiedRecipient[index].cardExpanded = !certifiedRecipient[index].cardExpanded;
    notifyListeners();
  }
  double getRecipientsHeight(){
    int closedHeight = 100;
    int openHeight = 350;
    int total = 0;
    for(int i=0;i<certifiedRecipient.length;i++){
      if(certifiedRecipient[i].cardExpanded == true){
        total = total + openHeight;
      }
      else{
        total = total + closedHeight;
      }
    }
    return total.toDouble();
  }


}