
import 'package:flutter/cupertino.dart';
import 'package:pickappuser/models/carrier_information_model.dart';
import 'package:pickappuser/models/recipient_information_model.dart';
import 'package:pickappuser/models/sender_information_model.dart';

class OrderInformationModel{
  CarrierInformationModel carrierDetails;
  SenderInformationModel senderDetails;
  List<RecipientInformationModel>recipientsDetails;

  OrderInformationModel({
   @required this.carrierDetails,
   @required this.senderDetails,
   @required this.recipientsDetails
  });
}