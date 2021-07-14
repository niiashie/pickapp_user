

import 'package:flutter/material.dart';
import 'package:pickappuser/models/carrier_item.dart';
import 'package:pickappuser/models/package_item.dart';

class Order{
  CarrierType carrierType;
  PackageSizes packageSizes;
  String senderName;
  String senderPhone;
  String pickUpLocation;
  String pickUpCode;
  String orderCode;
  String orderFragile;
  Order({
     @required carrierType,
    @required packageSizes,
    @required senderName,
    @required senderPhone,
    @required pickUpLocation,
    @required pickUpCode,
    @required orderCode,
    @required orderFragile,
  }){
    this.senderPhone = senderPhone;
    this.senderName = senderName;
    this.carrierType = carrierType;
    this.packageSizes = packageSizes;
    this.pickUpLocation = pickUpLocation;
    this.pickUpCode = pickUpCode;
    this.orderCode = orderCode;
    this.orderFragile = orderFragile;
  }


}