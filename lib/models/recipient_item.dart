


import 'package:flutter/cupertino.dart';

class RecipientData {
  TextEditingController fullnameController;
  TextEditingController phoneController;
  TextEditingController deliveryLocationTextController;
  TextEditingController deliveryInstructionController;
  String title;
  bool cardExpanded;
  bool iAmTheRecipient;

  RecipientData({
    @required this.title,
    @required this.fullnameController,
    @required this.phoneController,
    @required this.deliveryInstructionController,
    @required this.deliveryLocationTextController,
    @required this.cardExpanded,
    @required this.iAmTheRecipient
  });
}