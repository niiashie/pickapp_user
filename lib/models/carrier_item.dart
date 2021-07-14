
import 'package:flutter/material.dart';

class CarrierType{
  String carrierId;
  String carrierName;
  String carrierImageUrl;

  CarrierType({
    @required this.carrierId,
    @required this.carrierName,
    @required this.carrierImageUrl
  }){
    this.carrierId = carrierId;
    this.carrierName = carrierName;
    this.carrierImageUrl = carrierImageUrl;
  }
}