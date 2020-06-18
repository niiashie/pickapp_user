
import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:pickappuser/config/locator.dart';
import 'package:pickappuser/constants/app_constants.dart';
import 'package:pickappuser/constants/local_storage_name.dart';
import 'package:pickappuser/constants/routes.dart';
import 'package:pickappuser/constants/utils.dart';
import 'package:pickappuser/models/carrier_item.dart';
import 'package:pickappuser/models/package_item.dart';
import 'package:pickappuser/models/recipient_item.dart';
import 'package:pickappuser/services/dialog.service.dart';
import 'package:pickappuser/services/http.service.dart';
import 'package:pickappuser/services/router.service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewOrderProvider extends ChangeNotifier{
  final GlobalKey<AnimatedListState> listKey = GlobalKey();
  final requests = locator<HttpService>();
  final router = locator<RouterService>();
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
      Utils.getProgressBar(context, "Loading,please wait..", "showProgress");
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

  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }


  double totalDistanceTravelled(){
    double totalDist = 0;
    double pickUpLatitude =double.parse(pickUpLocationLatitude);
    double pickUpLongitude = double.parse(pickUpLocationLongitude);

    //Add distance from pickUp Location to first Recipient
    totalDist = totalDist + calculateDistance(pickUpLatitude,pickUpLongitude,double.parse(recipientList[0].locationLatitude), double.parse(recipientList[0].locationLongitude));

    if(recipientList.length>1){
      for(int y=0;y<recipientList.length;y++){
        int checkId = y+1;
        if(y!=recipientList.length){
          int nextDestination = y+1;
          totalDist = totalDist + calculateDistance(double.parse(recipientList[y].locationLatitude),
              double.parse(recipientList[y].locationLongitude),
              double.parse(recipientList[nextDestination].locationLatitude),
              double.parse(recipientList[nextDestination].locationLongitude)
          );
        }
      }
    }

    return totalDist;
  }


}