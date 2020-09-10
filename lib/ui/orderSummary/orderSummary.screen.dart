
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pickappuser/config/locator.dart';
import 'package:pickappuser/models/recipient_item.dart';
import 'package:pickappuser/providers/newOrder.provider.dart';
import 'package:pickappuser/services/router.service.dart';
import 'package:provider/provider.dart';
import 'package:pickappuser/constants/routes.dart';

class OrderSummaryScreen extends StatefulWidget{
  @override
  _OrderSummaryScreenState createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen>{
  @override
  Widget build(BuildContext context) {
    var router = locator<RouterService>();
    final vm = Provider.of<NewOrderProvider>(context);
    double device_width = MediaQuery.of(context).size.width;
    double device_height = MediaQuery.of(context).size.height;

    String senderName = vm.senderFullNameCtrl.text;
    String senderPhone = vm.senderPhoneCtrl.text;
    String userDetail = "$senderName($senderPhone)";

    final senderDetails =  Container(
      margin: EdgeInsets.only(top:15,left:20,right: 20),
      child: Card(
        elevation: 3,
        child: Column(
          children: <Widget>[
            Container(
              height: 70,
              child: Stack(
                children: <Widget>[
                  Visibility(
                    visible: vm.senderDetailsExpanded?true:false,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Divider(color: Colors.grey,),
                    ),
                  ),

                  Align(
                      alignment: Alignment.centerLeft,
                      child: Stack(
                        children: <Widget>[
                          Visibility(
                            visible: vm.senderDetailsExpanded?true:false,
                            child: IconButton(
                              icon: Icon(Icons.arrow_drop_down),
                              onPressed: (){
                                vm.orderSummarySenderDetailsExpandableClicked();
                              },
                            ),
                          ),
                          Visibility(
                            visible: vm.senderDetailsMinimized?true:false,
                            child: IconButton(
                              icon: Icon(Icons.arrow_drop_up),
                              onPressed: (){
                                vm.orderSummarySenderDetailsExpandableClicked();
                              },
                            ),
                          )
                        ],
                      )
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.only(left:40),
                        child: Text(
                          "Sender Details",style: TextStyle(color: Colors.purple[900],fontSize: 18,fontWeight: FontWeight.w700),
                        ),
                      )
                  )
                ],
              ),
            ),
            Visibility(
              visible: vm.senderDetailsExpanded,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 60,
                    margin: EdgeInsets.only(left:10,right:10,top: 15),
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Contact",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Divider(
                            color: Colors.grey,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 15),
                            child: Text(
                              userDetail,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 60,
                    margin: EdgeInsets.only(left:10,right:10,top: 15),
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Pick Up Location",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Divider(
                            color: Colors.grey,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 15),
                            child: Text(
                              vm.pickUpLocationDesCtrl.text,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: vm.pickUpInstructionCtrl.text.isNotEmpty,
                    child: Container(
                      height: 60,
                      margin: EdgeInsets.only(left:10,right:10,top: 15),
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Pick Up Instruction",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Divider(
                              color: Colors.grey,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              margin: EdgeInsets.only(bottom: 15),
                              child: Text(
                                vm.pickUpInstructionCtrl.text,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );

    final carrierDetails =  Container(
      margin: EdgeInsets.only(top:20,left:20,right: 20),
      child: Card(
        elevation: 3,
        child: Column(
          children: <Widget>[
            Container(
              height: 70,
              child: Stack(
                children: <Widget>[
                  Visibility(
                    visible: vm.carrierDetailsExpanded?true:false,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Divider(color: Colors.grey,),
                    ),
                  ),

                  Align(
                      alignment: Alignment.centerLeft,
                      child: Stack(
                        children: <Widget>[
                          Visibility(
                            visible: vm.carrierDetailsExpanded?true:false,
                            child: IconButton(
                              icon: Icon(Icons.arrow_drop_down,color: Colors.grey,),
                              onPressed: (){
                                vm.orderSummaryCarrierDetailsExpandableClicked();
                              },
                            ),
                          ),
                          Visibility(
                            visible: vm.carrierDetailsMinimized?true:false,
                            child: IconButton(
                              icon: Icon(Icons.arrow_drop_up,color: Colors.grey),
                              onPressed: (){
                                vm.orderSummaryCarrierDetailsExpandableClicked();
                              },
                            ),
                          )
                        ],
                      )
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.only(left:40),
                        child: Text(
                          "Carrier Details",style: TextStyle(color: Colors.purple[900],fontSize: 18,fontWeight: FontWeight.w700),
                        ),
                      )
                  )
                ],
              ),
            ),
            Visibility(
              visible: vm.carrierDetailsExpanded,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 60,
                    margin: EdgeInsets.only(left:10,right:10,top: 15),
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Carrier Type",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Divider(
                            color: Colors.grey,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 15),
                            child: Text(
                              vm.selectedCarrierType.carrierName,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                      height: 60,
                      margin: EdgeInsets.only(left:10,right:10,top: 15),
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Divider(
                              color: Colors.grey,
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Expanded(
                                child: Stack(
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text("Package Size",
                                        style: TextStyle(
                                            color: Colors.grey
                                        ),),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Container(
                                        margin: EdgeInsets.only(bottom: 15),
                                        child: Text(
                                          vm.selectedPackageSize.packageSize,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(width: 10,),
                              Expanded(
                                child: Stack(
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text("Package Weight",
                                        style: TextStyle(
                                            color: Colors.grey
                                        ),),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Container(
                                        margin: EdgeInsets.only(bottom: 15),
                                        child: Text(
                                          vm.selectedPackageSize.packageWeight,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      )
                  ),
                  Container(
                    height: 60,
                    margin: EdgeInsets.only(left:10,right:10,top: 15),
                    child: Stack(
                      children: <Widget>[
                        Align(
                            alignment: Alignment.topLeft,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  "Order Quantity:",
                                  style: TextStyle(
                                      color: Colors.grey
                                  ),
                                ),
                                SizedBox(width: 15,),
                                Text(
                                  vm.packageQuantityCtrl.text,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700
                                  ),
                                )
                              ],
                            )
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Divider(
                            color: Colors.grey,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 15),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  "Is Order Fragile?",
                                  style: TextStyle(
                                      color: Colors.grey
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Text(
                                  vm.packageFragileAnswer,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700
                                  ),
                                )
                              ],
                            ),
                          ),
                        )

                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left:10,right: 10,top:15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child:Text("Order Description",
                            style: TextStyle(
                                color: Colors.grey
                            ),) ,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin: EdgeInsets.only(top:10),
                            child: Text(
                              vm.itemDescriptionCtrl.text,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top:5),
                          child: Divider(
                            color: Colors.grey,
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
          ],
        ),
      ),
    );

    Widget recipientDataListItem(RecipientData content,index){
      String recipientName = content.fullnameController.text;
      String recipientPhone = content.phoneController.text;
      String recipientDetails = "$recipientName($recipientPhone)";
      int recipientNumber = index+1;
      return Container(
        margin:EdgeInsets.only(top:10,left:20,right: 20),
        child: Card(
          elevation: 3,
          child: Column(
            children: <Widget>[
              Container(
                height: 70,
                child: Stack(
                  children: <Widget>[
                    Visibility(
                      visible: content.cardExpanded?true:false,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Divider(color: Colors.grey,),
                      ),
                    ),

                    Align(
                        alignment: Alignment.centerLeft,
                        child: content.cardExpanded?
                            IconButton(
                              icon: Icon(Icons.arrow_drop_down,color: Colors.grey,),
                              onPressed: (){
                                vm.recipientCardIconClick(index);
                              },
                            )
                            :IconButton(
                             icon: Icon(Icons.arrow_drop_up,color: Colors.grey,),
                          onPressed: (){
                             vm.recipientCardIconClick(index);
                          },
                        )
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.only(left:40),
                          child: Text(
                            "Recipient $recipientNumber Details",
                            style: TextStyle(color: Colors.purple[900],fontSize: 18,fontWeight: FontWeight.w700),
                          ),
                        )
                    )
                  ],
                ),
              ),
              Visibility(
                visible: content.cardExpanded,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 60,
                      margin: EdgeInsets.only(left:10,right:10,top: 15),
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Contact",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Divider(
                              color: Colors.grey,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              margin: EdgeInsets.only(bottom: 15),
                              child: Text(
                                recipientDetails,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 60,
                      margin: EdgeInsets.only(left:10,right:10,top: 15),
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Delivery Location",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Divider(
                              color: Colors.grey,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              margin: EdgeInsets.only(bottom: 15),
                              child: Text(
                                content.deliveryLocationTextController.text,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible:content.deliveryInstructionController.text.isNotEmpty ,
                      child: Container(
                        height: 60,
                        margin: EdgeInsets.only(left:10,right:10,top: 15),
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Delivery Instruction",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Divider(
                                color: Colors.grey,
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                margin: EdgeInsets.only(bottom: 15),
                                child: Text(
                                  content.deliveryInstructionController.text,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20,)
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }

    final recipientList = SizedBox(
        height: vm.orderSummaryRecipientsSizedBoxHeight,
        child:  ListView.builder(
          itemCount: vm.recipientList.length,
          itemBuilder: (context,index){
            return recipientDataListItem(vm.recipientList[index],index);
          },
          physics: ClampingScrollPhysics(),
        )
    );

    final bottomNavigators = Container(
      height: 50,
      margin: EdgeInsets.only(left:20,right: 20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: ButtonTheme(
              height: 50,
              child: RaisedButton(
                color: Colors.amber[900],
                child: Text(
                  "Previous",
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
                onPressed: (){
                  Navigator.pop(context);
                },
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Colors.amber[900],
                        width: 1,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(5)),
              ),
            ),
          ),
          SizedBox(width: 10,),
          Expanded(
            child: ButtonTheme(
              height: 50,
              child: RaisedButton(
                color: Colors.amber[900],
                child: Text(
                  "Next",
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
                onPressed: (){
                  vm.totalDistanceTravelled(context);
                  //router.navigateTo(AppRoutes.paymentScreenRoute);
                },
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Colors.amber[900],
                        width: 1,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(5)),
              ),
            ),
          )
        ],
      ),
    );

    // TODO: implement build
     return Scaffold(
      appBar: AppBar(
        title: Text(
          "Order Summary",
          style: TextStyle(
              color: Colors.white
          ),),
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: Colors.purple[900],
      ),
      body:Container(
        width: device_width,
        height: device_height,
        color:Colors.white,
        child: ListView.builder(
          itemCount: 1,
          itemBuilder:(context,index){
            return Column(
              children: <Widget>[
                carrierDetails,
                senderDetails,
                recipientList,
                bottomNavigators,
                SizedBox(height: 20,)
              ],
            );
          },
        )
      )
    );
  }

}

