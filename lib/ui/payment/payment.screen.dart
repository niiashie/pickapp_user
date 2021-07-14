
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pickappuser/config/locator.dart';
import 'package:pickappuser/constants/images.dart';
import 'package:pickappuser/providers/createOrderProvider.dart';
import 'package:pickappuser/services/local.notification.service.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatefulWidget{
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen>{
  var localNotification = locator<LocalNotificationService>();

  CreateOrderProvider vm1;

  @override
  initState(){
    super.initState();
    vm1 = context.read<CreateOrderProvider>();
    localNotification.initializing();
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Payment",
          style: TextStyle(
              color: Colors.white
          ),),
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: Colors.purple[900],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left:20,right:20,top:20,bottom: 30),
          child: Card(
            elevation: 3,
            child: Column(
              children: <Widget>[
                Container(
                  height: 60,
                  margin: EdgeInsets.only(top: 20),
                  child: Center(
                    child: Text(
                      "Amount Due",
                      style: TextStyle(
                        color: Colors.purple[900],
                        fontWeight: FontWeight.w700,
                        fontSize: 18
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top:15),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 40,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Text("GHS",style: TextStyle(
                            color:Colors.grey
                          ),),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Container(
                        height: 40,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            vm1.serviceCharge,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w700
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left:20,right:20,bottom: 10),
                  child: Divider(color: Colors.grey,),
                ),
                Container(
                  margin: EdgeInsets.only(left:20,right: 20,top:10),
                  height: 100,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                          child: InkWell(
                            child: Center(
                              child: Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    image: DecorationImage(
                                      image: AssetImage(AppImages.mtn),
                                      fit: BoxFit.cover,
                                    ),
                                    border: Border.all(
                                        color: Colors.white,
                                        width: 2
                                    )
                                ),
                              ),
                            ),
                            onTap: (){
                              vm1.paymentDialog(context,"MTN");
                            },
                          )
                      ),
                      SizedBox(width: 15,),
                      Expanded(
                        child: InkWell(
                          child: Center(
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  image: DecorationImage(
                                    image: AssetImage(AppImages.tigo),
                                    fit: BoxFit.cover,
                                  ),
                                  border: Border.all(
                                      color: Colors.white,
                                      width: 2
                                  )
                              ),
                            ),
                          ),
                          onTap: (){
                            vm1.paymentDialog(context,"TIGO");
                          },
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  margin: EdgeInsets.only(left:20,right: 20,top:10),
                  height: 100,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          child: Center(
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  image: DecorationImage(
                                    image: AssetImage(AppImages.voda),
                                    fit: BoxFit.cover,
                                  ),
                                  border: Border.all(
                                      color: Colors.white,
                                      width: 2
                                  )
                              ),
                            ),
                          ),
                          onTap: (){
                            vm1.paymentDialog(context,"VODAFONE");
                          },
                        ),
                      ),
                      SizedBox(width: 15,),
                      Expanded(
                        child: InkWell(
                          child: Center(
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  image: DecorationImage(
                                    image: AssetImage(AppImages.airtel),
                                    fit: BoxFit.cover,
                                  ),
                                  border: Border.all(
                                      color: Colors.white,
                                      width: 2
                                  )
                              ),
                            ),
                          ),
                          onTap: (){
                            vm1.paymentDialog(context,"AIRTEL");
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left:20,right: 20,top:10),
                  height: 100,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          child: Center(
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  image: DecorationImage(
                                    image: AssetImage(AppImages.masterCard),
                                    fit: BoxFit.cover,
                                  ),
                                  border: Border.all(
                                      color: Colors.white,
                                      width: 2
                                  )
                              ),
                            ),
                          ),
                          onTap: (){
                            vm1.paymentDialog(context,"Master Card");
                          },
                        ),
                      ),
                      SizedBox(width: 15,),
                      Expanded(
                        child: InkWell(
                          child: Center(
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  image: DecorationImage(
                                    image: AssetImage(AppImages.visa),
                                    fit: BoxFit.cover,
                                  ),
                                  border: Border.all(
                                      color: Colors.white,
                                      width: 2
                                  )
                              ),
                            ),
                          ),
                          onTap: (){
                            vm1.paymentDialog(context,"VISA");
                          },
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      )
    );
  }

}