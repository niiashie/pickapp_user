
import 'package:flutter/cupertino.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:pickappuser/constants/app_constants.dart';
import 'package:pickappuser/models/recipient_item.dart';

class RecipientInformationProvider extends ChangeNotifier{
  var recipientSizedBoxHeight = 450.00;


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

  void recipientCardIconClick(int index){
    recipientList[index].cardExpanded = !recipientList[index].cardExpanded;
    print("Card Expansion: ${recipientList[index].cardExpanded}");
    changeRecipientSizedBoxHeight();
    notifyListeners();
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

  void removeRecipientCard(int index){
    recipientList.removeAt(index);
    //listKey.currentState.removeItem(index, (context, animation) => null);
    changeRecipientSizedBoxHeight();
    //changeOrderSummaryRecipientsHeight();
    notifyListeners();
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

  void onError(PlacesAutocompleteResponse response) {
    print(response.errorMessage);
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

   // listKey.currentState.insertItem(recipientsSize);
    changeRecipientSizedBoxHeight();
   // changeOrderSummaryRecipientsHeight();
    notifyListeners();
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
      print("Correct Data entry");
      //router.navigateTo(AppRoutes.orderSummaryScreenRoute);
    }
    notifyListeners();
  }

  void collapseRecipientCards(){
    for(int y=0;y<recipientList.length;y++){
      recipientList[y].cardExpanded = false;
    }
    changeRecipientSizedBoxHeight();
    //changeOrderSummaryRecipientsHeight();
  }
}