
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pickappuser/models/recipient_information_model.dart';
import 'package:pickappuser/providers/createOrderProvider.dart';
import 'package:pickappuser/ui/shared/customButton.dart';
import 'package:provider/provider.dart';

class OrderSummaryScreen extends StatefulWidget{
  @override
  _OrderSummaryScreenState createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen>{

  CreateOrderProvider vm2;
  bool senderDetailsExpanded = true,carrierDetailsExpanded = true;
  bool senderDetailsClosed = false, carrierDetailsClosed = false;
  var recipientSizedBoxHeight = 0.00;
  @override
  void initState() {
    super.initState();
    vm2 = context.read<CreateOrderProvider>();
    print("Pick up time:${vm2.senderDetails.pickUpTime}");
    changeRecipientSizedBoxHeight();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    double device_width = MediaQuery.of(context).size.width;

    // ignore: non_constant_identifier_names
    double device_height = MediaQuery.of(context).size.height;

    /*String senderName = vm.senderFullNameCtrl.text;
    String senderPhone = vm.senderPhoneCtrl.text;
    String userDetail = "$senderName($senderPhone)";*/

    final itemImage = Visibility(
      visible: vm2.carrierDetails.selectedItemCaptureImage==null?false:true,
      child: Container(
        margin: EdgeInsets.only(top:15,left:20,right: 20),
        height: 150,
        child: Row(
          children: [
            Expanded(child: Card(
              elevation: 3,
              child: Image.file(vm2.carrierDetails.selectedItemCaptureImage,fit: BoxFit.fill,),
            ),)
          ],
        )
      ),
    );

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
                    visible: senderDetailsExpanded?true:false,
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
                            visible: senderDetailsExpanded?true:false,
                            child: IconButton(
                              icon: Icon(Icons.arrow_drop_down),
                              onPressed: (){
                                setState(() {
                                  senderDetailsExpanded = !senderDetailsExpanded;
                                  senderDetailsClosed = !senderDetailsClosed;
                                });
                               // vm.orderSummarySenderDetailsExpandableClicked();
                              },
                            ),
                          ),
                          Visibility(
                            visible: senderDetailsClosed?true:false,
                            child: IconButton(
                              icon: Icon(Icons.arrow_drop_up),
                              onPressed: (){
                                setState(() {
                                  senderDetailsClosed = !senderDetailsClosed;
                                  senderDetailsExpanded = !senderDetailsExpanded;
                                });
                                //vm.orderSummarySenderDetailsExpandableClicked();
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
              visible: senderDetailsExpanded,
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
                              "${vm2.senderDetails.senderName} (${vm2.senderDetails.senderPhone})",
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
                              vm2.senderDetails.pickUpDescription,
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
                    visible: vm2.senderDetails.pickUpInstruction.isNotEmpty,
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
                                vm2.senderDetails.pickUpInstruction,
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
                    visible: carrierDetailsExpanded?true:false,
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
                            visible: carrierDetailsExpanded?true:false,
                            child: IconButton(
                              icon: Icon(Icons.arrow_drop_down,color: Colors.grey,),
                              onPressed: (){
                                //vm.orderSummaryCarrierDetailsExpandableClicked();
                                setState(() {
                                  carrierDetailsExpanded = !carrierDetailsExpanded;
                                  carrierDetailsClosed = !carrierDetailsClosed;
                                });
                              },
                            ),
                          ),
                          Visibility(
                            visible: carrierDetailsClosed?true:false,
                            child: IconButton(
                              icon: Icon(Icons.arrow_drop_up,color: Colors.grey),
                              onPressed: (){
                                setState(() {
                                  carrierDetailsExpanded = !carrierDetailsExpanded;
                                  carrierDetailsClosed = !carrierDetailsClosed;
                                });
                                //vm.orderSummaryCarrierDetailsExpandableClicked();
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
              visible: carrierDetailsExpanded,
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
                              vm2.carrierDetails.selectedCarrierType.carrierName,
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
                                          vm2.carrierDetails.selectedPackageSize.packageSize,
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
                                          vm2.carrierDetails.selectedPackageSize.packageWeight,
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
                                  vm2.carrierDetails.itemQuantity,
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
                                  (vm2.carrierDetails.packageFragile==true)?"Yes":"No",
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
                              //vm.itemDescriptionCtrl.text,
                              vm2.carrierDetails.itemDescription,
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

    Widget recipientDataListItem(RecipientInformationModel content,index){
      String recipientName = content.recipientName;
      String recipientPhone = content.recipientPhone;
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
                      visible: content.recipientCardExpanded?true:false,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Divider(color: Colors.grey,),
                      ),
                    ),

                    Align(
                        alignment: Alignment.centerLeft,
                        child: content.recipientCardExpanded?
                            IconButton(
                              icon: Icon(Icons.arrow_drop_down,color: Colors.grey,),
                              onPressed: (){
                                setState(() {
                                  content.recipientCardExpanded = !content.recipientCardExpanded;
                                });
                                changeRecipientSizedBoxHeight();
                                //vm.recipientCardIconClick(index);
                              },
                            )
                            :IconButton(
                             icon: Icon(Icons.arrow_drop_up,color: Colors.grey,),
                          onPressed: (){
                            setState(() {
                              content.recipientCardExpanded = !content.recipientCardExpanded;
                            });
                            changeRecipientSizedBoxHeight();
                             //vm.recipientCardIconClick(index);
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
                visible: content.recipientCardExpanded,
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
                                content.recipientDeliveryLocation,
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
                      visible:content.recipientDeliveryInstruction.isNotEmpty ,
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
                                  content.recipientDeliveryInstruction,
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
        height: recipientSizedBoxHeight,//vm.orderSummaryRecipientsSizedBoxHeight,
        child:  ListView.builder(
          itemCount: vm2.recipientsDetails.length,
          itemBuilder: (context,index){
            return recipientDataListItem(vm2.recipientsDetails[index],index);
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
            child: CustomButton(
              title: "Previous",
              onPressed: (){
                Navigator.pop(context);
              },
              height: 50,
            )
            
          ),
          SizedBox(width: 10,),
          Expanded(
            child: CustomButton(
              height: 50,
              title:"Next",
              onPressed: (){
                 vm2.totalDistanceTravelled(context);
              },

            )
            
          )
        ],
      ),
    );

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
                itemImage,
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

  void changeRecipientSizedBoxHeight(){
    double closedHeight = 100.00;
    double expandedHeight = 300.00;
    double totalHeight = 0;
    for(int y=0;y<vm2.recipientsDetails.length;y++){
      if(vm2.recipientsDetails[y].recipientCardExpanded == true){
        totalHeight = totalHeight + expandedHeight;
      }else{
        totalHeight = totalHeight + closedHeight;
      }
    }
    setState(() {
      recipientSizedBoxHeight = totalHeight;
    });
  }

}

