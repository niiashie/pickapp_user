
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pickappuser/config/locator.dart';
import 'package:pickappuser/constants/images.dart';
import 'package:pickappuser/constants/routes.dart';
import 'package:pickappuser/models/recipient_information_model.dart';
import 'package:pickappuser/providers/createOrderProvider.dart';
import 'package:pickappuser/services/router.service.dart';
import 'package:provider/provider.dart';

class OrderDetailScreen extends StatefulWidget{
  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen>{

  CreateOrderProvider vm;
  bool senderCardExpanded = false;
  var recipientSizedBoxHeight = 0.00;
  @override
  void initState() {
    
    super.initState();
    vm = context.read<CreateOrderProvider>();
  }

  @override
  Widget build(BuildContext context) {

    // ignore: non_constant_identifier_names
    double device_width = MediaQuery.of(context).size.width;

    // ignore: non_constant_identifier_names
    double device_height = MediaQuery.of(context).size.height;

    var router = locator<RouterService>();

    String charge = vm.serviceCharge;
    String totalCharge = "GHS $charge";
    String orderFragile = "";

    if(vm.carrierDetails.packageFragile == true){
      orderFragile = "Yes";
    }
    else{
      orderFragile = "No";
    }

    changeRecipientSizedBoxHeight(){
      double closedHeight = 100.00;
      double expandedHeight = 300.00;
      double totalHeight = 0;
      for(int y=0;y<vm.recipientsDetails.length;y++){
        if(vm.recipientsDetails[y].recipientCardExpanded == true){
          totalHeight = totalHeight + expandedHeight;
        }else{
          totalHeight = totalHeight + closedHeight;
        }
      }
      setState(() {
        recipientSizedBoxHeight = totalHeight;
      });
    }

    final ordersCard = Container(
      margin: EdgeInsets.only(top:20,right: 20,left:20),
      child:Card(
        elevation: 3,
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              height: 70,
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.bottomCenter,
                    child:Divider(color: Colors.grey,),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 20,),
                        Text(
                          "Order Details",
                          style: TextStyle(
                              color: Colors.purple[900],
                              fontSize: 18,
                              fontWeight: FontWeight.w700
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 120,
              margin: EdgeInsets.only(top:15,left:5,right:5),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child:Container(
                      margin: EdgeInsets.all(5),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.network(vm.carrierDetails.selectedPackageSize.packagePhoto,height: 70,width: 70,),
                          SizedBox(height: 10,),
                          Text(vm.carrierDetails.selectedPackageSize.packageSize)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    child: Center(
                      child: Image.asset(AppImages.arrowRight,
                        width: 30,
                        height: 20,
                      ),
                    ),
                  ),
                  Expanded(
                    child:Container(
                      margin: EdgeInsets.all(5),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.network(
                            vm.carrierDetails.selectedCarrierType.carrierImageUrl,
                            height: 70,
                            width: 70,
                          ),
                          SizedBox(height: 10,
                          ),
                          Text(vm.carrierDetails.selectedCarrierType.carrierName)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 15,),
            Container(
              margin: EdgeInsets.only(left:10),
              height: 60,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    width: 80,
                    child: Center(
                      child: Image.asset(AppImages.orderDescription,
                        height: 20,width: 20,),
                    ),
                  ),
                  Expanded(
                    child:  Container(
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Divider(color: Colors.grey,),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(width: 15,),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Order Description",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    SizedBox(height: 10,),
                                    Text(
                                      vm.carrierDetails.itemDescription,
                                      style: TextStyle(color:Colors.black),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(
              margin: EdgeInsets.only(left:10),
              height: 60,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    width: 80,
                    child: Center(
                      child: Image.asset(AppImages.quantity,
                        height: 20,width: 20,),
                    ),
                  ),
                  Expanded(
                    child:  Container(
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Divider(color: Colors.grey,),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(width: 15,),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Order Quantity",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    SizedBox(height: 10,),
                                    Text(
                                      vm.carrierDetails.itemQuantity,
                                      style: TextStyle(color:Colors.black),
                                    ),

                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(
              margin: EdgeInsets.only(left:10),
              height: 60,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    width: 80,
                    child: Center(
                      child: Image.asset(AppImages.money,
                        height: 20,width: 20,),
                    ),
                  ),
                  Expanded(
                    child:  Container(
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Divider(color: Colors.grey,),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(width: 15,),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Service Charge",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    SizedBox(height: 10,),
                                    Text(
                                      totalCharge,
                                      style: TextStyle(color:Colors.black),
                                    ),

                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.only(left:10,right: 10),
              height: 60,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                      child:Container(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text("Order Code",
                                style: TextStyle(
                                    color: Colors.grey
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text(
                                vm.orderCode,
                                style: TextStyle(color: Colors.black),
                              )
                            ],
                          ),
                        ),
                      )
                  ),
                  SizedBox(width: 40,),
                  Expanded(
                      child:Container(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text("Order Fragile",
                                style: TextStyle(
                                    color: Colors.grey
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text(
                                orderFragile,
                                style: TextStyle(color: Colors.black),
                              )
                            ],
                          ),
                        ),
                      )
                  )
                ],
              ),
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );

    final senderCard = Container(
      margin: EdgeInsets.only(left:20,right:20,top:20),
      child: Card(
        elevation: 3,
        color:Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              height: 70,
              child: Stack(
                children: <Widget>[
                  Visibility(
                    visible:senderCardExpanded,
                    child:  Align(
                      alignment: Alignment.bottomCenter,
                      child:Divider(color: Colors.grey,),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 20,),
                        Text(
                          "Sender Details",
                          style: TextStyle(
                              color: Colors.purple[900],
                              fontSize: 18,
                              fontWeight: FontWeight.w700
                          ),
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          height: 25,
                          width: 25,
                          child: Center(
                            child: senderCardExpanded?
                            IconButton(
                              icon: Icon(Icons.arrow_drop_down,color: Colors.purple[900],size: 20,),
                              onPressed: (){
                                setState(() {
                                  senderCardExpanded = !senderCardExpanded;
                                });
                                // ignore: unnecessary_statements
                               // vm.senderCardArrowClicked();
                              },
                            ):IconButton(
                              icon:Icon(Icons.arrow_drop_up,color: Colors.purple[900],size: 20,),
                              onPressed: (){
                                //vm.senderCardArrowClicked();
                                setState(() {
                                  senderCardExpanded = !senderCardExpanded;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: 20,)
                      ],
                    ),
                  )
                ],
              ),
            ),
            Visibility(
              visible: senderCardExpanded,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 15,),
                  Container(
                    margin: EdgeInsets.only(left:10),
                    height: 80,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Container(
                          width: 80,
                          child: Center(
                            child: Image.asset(AppImages.user,
                              height: 20,width: 20,),
                          ),
                        ),
                        Expanded(
                          child:  Container(
                            child: Stack(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Divider(color: Colors.grey,),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      SizedBox(width: 15,),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            "Profile",
                                            style: TextStyle(color: Colors.grey),
                                          ),
                                          SizedBox(height: 10,),
                                          Text(
                                            vm.senderDetails.senderName,
                                            style: TextStyle(color:Colors.black),
                                          ),
                                          Text(
                                            vm.senderDetails.senderPhone,
                                            style: TextStyle(color:Colors.black),
                                          ),

                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    margin: EdgeInsets.only(left:10),
                    height: 60,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Container(
                          width: 80,
                          child: Center(
                            child: Image.asset(AppImages.location,
                              height: 20,width: 20,),
                          ),
                        ),
                        Expanded(
                          child:  Container(
                            child: Stack(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Divider(color: Colors.grey,),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      SizedBox(width: 15,),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            "Pick Up Location",
                                            style: TextStyle(color: Colors.grey),
                                          ),
                                          SizedBox(height: 10,),
                                          Text(
                                            vm.senderDetails.pickUpDescription,
                                            style: TextStyle(color:Colors.black),
                                          ),

                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    margin: EdgeInsets.only(left:10),
                    height: 60,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Container(
                          width: 80,
                          child: Center(
                            child: Image.asset(AppImages.code,
                              height: 20,width: 20,),
                          ),
                        ),
                        Expanded(
                          child:  Container(
                            child: Stack(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Divider(color: Colors.grey,),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      SizedBox(width: 15,),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            "Pick Up Code",
                                            style: TextStyle(color: Colors.grey),
                                          ),
                                          SizedBox(height: 10,),
                                          Text(
                                            "",
                                            style: TextStyle(color:Colors.black),
                                          ),

                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top:15,left:20,right: 20),
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.purple[900])
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left:5,right: 5),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(
                                    width: 30,
                                    height: 40,
                                    child: Center(
                                      child:  Image.asset(AppImages.calendar,width: 15,height: 15,),
                                    )

                                ),
                                SizedBox(width: 5,),
                                SizedBox(
                                  height: 40,
                                  child: Center(
                                    child: Text(
                                        "Date Text"
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 1,
                          child: Container(color: Colors.purple[900],),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left:5,right: 5),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(
                                  width: 30,
                                  height: 40,
                                  child: Center(
                                    child:  Image.asset(AppImages.clock,width: 15,height: 15,),
                                  ),
                                ),
                                SizedBox(width: 5,),
                                SizedBox(
                                  height: 40,
                                  child: Center(
                                    child: Text(
                                        "Time Text"
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,)
                ],
              ),
            ),
          ],
        ),
      ),
    );

    Widget recipientItem(RecipientInformationModel content,index){
      int index2 = index + 1;
      String title = "Recipient $index2";
      return Container(
        width: device_width,
        margin: EdgeInsets.only(left:20,right: 20,top:10),
        child: Card(
          elevation: 3,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
                height: 70,
                child: Stack(
                  children: <Widget>[
                    Visibility(
                      visible:content.recipientCardExpanded,
                      child:  Align(
                        alignment: Alignment.bottomCenter,
                        child:Divider(color: Colors.grey,),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: 20,),
                          Text(
                            title,
                            style: TextStyle(
                                color: Colors.purple[900],
                                fontSize: 18,
                                fontWeight: FontWeight.w700
                            ),
                          )
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(
                            height: 25,
                            width: 25,
                            child: Center(
                              child: content.recipientCardExpanded?
                              IconButton(
                                icon: Icon(Icons.arrow_drop_down,color: Colors.purple[900],size: 20,),
                                onPressed: (){
                                  setState(() {
                                    content.recipientCardExpanded = !content.recipientCardExpanded;
                                  });
                                  changeRecipientSizedBoxHeight();
                                  // ignore: unnecessary_statements
                                 // vm.recipientCardArrowClicked(index);
                                },
                              )
                               :IconButton(
                                icon: Icon(Icons.arrow_drop_up,color: Colors.purple[900],size: 20,),
                                onPressed: (){
                                  // ignore: unnecessary_statements
                                  setState(() {
                                    content.recipientCardExpanded = !content.recipientCardExpanded;
                                  });
                                  changeRecipientSizedBoxHeight();
                                },
                              )
                            ),
                          ),
                          SizedBox(width: 20,)
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Visibility(
                visible: content.recipientCardExpanded,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 15,),
                    Container(
                      margin: EdgeInsets.only(left:10),
                      height: 80,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Container(
                            width: 80,
                            child: Center(
                              child: Image.asset(AppImages.user,
                                height: 20,width: 20,),
                            ),
                          ),
                          Expanded(
                            child:  Container(
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Divider(color: Colors.grey,),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        SizedBox(width: 15,),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "Profile",
                                              style: TextStyle(color: Colors.grey),
                                            ),
                                            SizedBox(height: 10,),
                                            Text(
                                              content.recipientName??"",
                                              style: TextStyle(color:Colors.black),
                                            ),
                                            Text(
                                              content.recipientPhone??"",
                                              style: TextStyle(color:Colors.black),
                                            ),

                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      margin: EdgeInsets.only(left:10),
                      height: 60,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Container(
                            width: 80,
                            child: Center(
                              child: Image.asset(AppImages.location,
                                height: 20,width: 20,),
                            ),
                          ),
                          Expanded(
                            child:  Container(
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Divider(color: Colors.grey,),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        SizedBox(width: 15,),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "Delivery Location",
                                              style: TextStyle(color: Colors.grey),
                                            ),
                                            SizedBox(height: 10,),
                                            Text(
                                              content.recipientDeliveryLocation??"",
                                              style: TextStyle(color:Colors.black),
                                            ),

                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      margin: EdgeInsets.only(left:10),
                      height: 60,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Container(
                            width: 80,
                            child: Center(
                              child: Image.asset(AppImages.code,
                                height: 20,width: 20,),
                            ),
                          ),
                          Expanded(
                            child:  Container(
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Divider(color: Colors.grey,),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        SizedBox(width: 15,),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "Confirmation Code",
                                              style: TextStyle(color: Colors.grey),
                                            ),
                                            SizedBox(height: 10,),
                                            Text(
                                              "Pending",
                                              style: TextStyle(color:Colors.black),
                                            ),

                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                    SizedBox(height: 20,)
                  ],
                ),
              ),
            ],
          ),
        ),
      );

    }

    final recipientList = SizedBox(
        height: recipientSizedBoxHeight,
        child:  ListView.builder(
          itemCount: vm.recipientsDetails.length??0,
          itemBuilder: (context,index){
            return recipientItem(vm.recipientsDetails[index],index);
          },
          physics: ClampingScrollPhysics(),
        )
    );



   
    return WillPopScope(
      // ignore: missing_return
      onWillPop: (){
        router.navigateTo(AppRoutes.dashboardRoute);
      },
      child:Scaffold(
        appBar: AppBar(
          title: Text(
            "Order Detail",
            style: TextStyle(
                color: Colors.white
            ),),
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          backgroundColor: Colors.purple[900],
        ),
        body: Container(
            width: device_width,
            height: device_height,
            color:Colors.white,
            child: ListView.builder(
              itemCount: 1,
              physics: ClampingScrollPhysics(),
              itemBuilder:(context,index){
                return Column(
                  children: <Widget>[
                    ordersCard,
                    senderCard,
                    SizedBox(height:10),
                    recipientList
                  ],
                );
              },
            )
        ),
      ),
    );
  }

}