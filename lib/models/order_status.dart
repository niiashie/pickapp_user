
import 'package:flutter/cupertino.dart';

class OrderStatus{
  String date;
  String action;

  OrderStatus({
    @required date,
    @required action
  }){
    this.date = date;
    this.action = action;
  }
}