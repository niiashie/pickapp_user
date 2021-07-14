
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pickappuser/constants/app_constants.dart';
import 'package:pickappuser/constants/local_storage_name.dart';
import 'package:pickappuser/services/dialog.service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';

class SenderInformationProvider extends ChangeNotifier{
  //Boolean values
  bool iAmTheSender = false;

  final senderFullNameCtrl = TextEditingController();
  final senderPhoneCtrl = TextEditingController();
  final pickUpLocationDesCtrl = TextEditingController();
  final pickUpInstructionCtrl = TextEditingController();

  bool senderFullNameError = false;
  bool senderPhoneNumberError = false;
  bool pickUpLocationError = false;
  bool pickUpAtDateError = false;
  String pickUpTimeText = "";
  BuildContext senderBuildContext;

  //String values
  String pickUpLocationLatitude,pickUpLocationLongitude;

  initializeProvider(){
    senderFullNameCtrl.text = "";
    senderPhoneCtrl.text = "";
    pickUpLocationDesCtrl.text = "";
    pickUpInstructionCtrl.text = "";

    pickUpLocationLatitude = "";
    pickUpLocationLongitude = "";

    senderFullNameError = false;
    senderPhoneNumberError = false;
    pickUpLocationError = false;
    pickUpAtDateError = false;

    iAmTheSender = false;

    notifyListeners();
  }


  iAmTheSenderOnClick() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userName = preferences.getString(LocalStorageName.userName);
    String userPhone =preferences.getString(LocalStorageName.userPhone);

    //Check if iAmRecipeient is selected
    /*for(int i=0;i<recipientList.length;i++){
      if(recipientList[i].iAmTheRecipient == true){
        iAmRecipientClicked (false,i);
      }
    }*/

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

  setStartPeriod(DateTime value) {
    String sPeriod = value.toString();
    var now = new DateTime.now();

    if(value.compareTo(now)<0){
      DialogService().showAlertDialog(context: senderBuildContext,
          message: "Pick up time must be now and beyond",
          type: AlertDialogType.error,
          showCancelBtn: false,
          onOkayBtnTap: (){
            Navigator.pop(senderBuildContext);
          }
      );
      pickUpAtDateError = true;
      notifyListeners();
    }
    else{
      pickUpAtDateError = false;
      pickUpTimeText = value.toString();
      pickUpTimeText = sPeriod.substring(0, sPeriod.length - 4);
      print(pickUpTimeText);
      notifyListeners();
    }

    // startPeriod = value.toString();
    //sPeriod = sPeriod.substring(0, sPeriod.length - 4);
  }
}