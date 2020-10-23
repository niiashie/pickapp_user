
import 'package:flutter/material.dart';
import 'package:pickappuser/models/order_recipient.dart';

class Order2{
  String packageSize;
  String packageImageUrl;
  String carrierName;
  String carrierImageUrl;
  String orderDescription;
  String orderQuantity;
  String orderCharge;
  String orderCode;
  String orderId;
  String orderFragile;
  String orderStatus;
  String senderName;
  String senderPhone;
  String pickUpLocation;
  String pickUpCode;
  String pickUpDateTime;
  List<Recipient>recipients;

  Order2({
    @required packageSize,
    @required packageImageUrl,
    @required carrierName,
    @required carrierImageUrl,
    @required orderDescription,
    @required orderQuantity,
    @required orderStatus,
    @required orderCharge,
    @required orderCode,
    @required orderFragile,
    @required senderName,
    @required senderPhone,
    @required pickUpLocation,
    @required pickUpCode,
    @required pickUpDateTime,
    @required recipients,
    @required orderId
  }){
    this.packageSize = packageSize;
    this.packageImageUrl = packageImageUrl;
    this.carrierName = carrierName;
    this.carrierImageUrl = carrierImageUrl;
    this.orderDescription = orderDescription;
    this.orderQuantity = orderQuantity;
    this.orderCharge = orderCharge;
    this.orderStatus = orderStatus;
    this.orderCode = orderCode;
    this.orderFragile = orderFragile;
    this.senderName = senderName;
    this.senderPhone = senderPhone;
    this.pickUpLocation = pickUpLocation;
    this.pickUpCode = pickUpCode;
    this.pickUpDateTime = pickUpDateTime;
    this.recipients = recipients;
    this.orderId = orderId;
  }
}