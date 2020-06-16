


import 'package:flutter/cupertino.dart';

class RecipientData {
  TextEditingController fullnameController;
  TextEditingController phoneController;
  TextEditingController deliveryLocationTextController;
  TextEditingController deliveryInstructionController;
  String locationLatitude,locationLongitude;
  String title;
  bool cardExpanded;
  bool iAmTheRecipient,fullNameError,phoneError,deliveryLocationError;

  RecipientData({
    @required this.title,
    @required this.fullnameController,
    @required this.phoneController,
    @required this.deliveryInstructionController,
    @required this.deliveryLocationTextController,
    @required this.cardExpanded,
    @required this.iAmTheRecipient,
    @required this.locationLatitude,
    @required this.locationLongitude,
    @required this.fullNameError,
    @required this.phoneError,
    @required this.deliveryLocationError
  });
}