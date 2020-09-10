

import 'package:flutter/cupertino.dart';

class Recipient{
  String name;
  String phone;
  String deliveryLocation;
  String confirmationCode;
  bool cardExpanded;

  Recipient({
    @required name,
    @required phone,
    @required deliveryLocation,
    @required confirmationCode,
    @required cardExpanded
  }){
    this.name = name;
    this.phone = phone;
    this.deliveryLocation = deliveryLocation;
    this.confirmationCode = confirmationCode;
    this.cardExpanded = cardExpanded;
  }

}
