
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pickappuser/constants/images.dart';
import 'package:pickappuser/models/order_item2.dart';
import 'package:pickappuser/models/order_recipient.dart';
import 'package:pickappuser/providers/dashBoardProvider.dart';
import 'package:provider/provider.dart';

class OrderDetail2Screen extends StatefulWidget{
  final Order2 myOrder;

  const OrderDetail2Screen({Key key, this.myOrder}) : super(key: key);
  @override
  OrderDetail2ScreenState createState() => OrderDetail2ScreenState(myOrder);
}


class OrderDetail2ScreenState extends State<OrderDetail2Screen>{
  final Order2 orders;

  OrderDetail2ScreenState(this.orders);

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<DashBoardProvider>(context);
    double device_width = MediaQuery.of(context).size.width;
    double device_height = MediaQuery.of(context).size.height;

    String charge = orders.orderCharge;
    String totalCharge = "GHS $charge";


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
                          Image.network(orders.packageImageUrl,height: 70,width: 70,),
                          SizedBox(height: 10,),
                          Text(orders.packageSize)
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
                            orders.carrierImageUrl,
                            height: 70,
                            width: 70,
                          ),
                          SizedBox(height: 10,
                          ),
                          Text(orders.carrierName)
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
                                      orders.orderDescription,
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
                                      orders.orderQuantity,
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
                                orders.orderCode,
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
                                orders.orderFragile,
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
                    visible:vm.senderCardExpanded,
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
                            child: vm.senderCardExpanded?
                            IconButton(
                              icon: Icon(Icons.arrow_drop_down,color: Colors.purple[900],size: 20,),
                              onPressed: (){
                                // ignore: unnecessary_statements
                                vm.senderCardArrowClicked();
                              },
                            ):IconButton(
                              icon:Icon(Icons.arrow_drop_up,color: Colors.purple[900],size: 20,),
                              onPressed: (){
                                vm.senderCardArrowClicked();
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
              visible: vm.senderCardExpanded,
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
                                            orders.senderName,
                                            style: TextStyle(color:Colors.black),
                                          ),
                                          Text(
                                            orders.senderPhone,
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
                                            orders.pickUpLocation,
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
                                            orders.pickUpCode,
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
                                        restructureDate(orders.pickUpDateTime)
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
                                        restructureTime(orders.pickUpDateTime)
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

    Widget recipientItem(Recipient content,index){
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
                      visible:content.cardExpanded,
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
                                child: content.cardExpanded?
                                IconButton(
                                  icon: Icon(Icons.arrow_drop_down,color: Colors.purple[900],size: 20,),
                                  onPressed: (){
                                    // ignore: unnecessary_statements
                                    vm.recipientCardArrowClicked(orders.recipients,index);
                                  },
                                )
                                    :IconButton(
                                  icon: Icon(Icons.arrow_drop_up,color: Colors.purple[900],size: 20,),
                                  onPressed: (){
                                    // ignore: unnecessary_statements
                                    vm.recipientCardArrowClicked(orders.recipients,index);
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
                visible: content.cardExpanded,
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
                                              content.name??"",
                                              style: TextStyle(color:Colors.black),
                                            ),
                                            Text(
                                              content.phone??"",
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
                                              content.deliveryLocation??"",
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
                                              content.confirmationCode??"",
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
        height: vm.getRecipientsHeight(orders.recipients),
        child:  ListView.builder(
          itemCount: orders.recipients.length??0,
          itemBuilder: (context,index){
            return recipientItem(orders.recipients[index],index);
          },
          physics: ClampingScrollPhysics(),
        )
    );

    // TODO: implement build
    return Scaffold(
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
    );
  }

  String restructureDate(String date){
    String date_year  = date.substring(0,4);
    String date_month;
    if(date.substring(5,7).contains("01")){
      date_month = "Jan";
    }else if(date.substring(5,7).contains("02")){
      date_month = "Feb";
    }else if(date.substring(5,7).contains("03")){
      date_month = "Mar";
    }else if(date.substring(5,7).contains("04")){
      date_month = "Apr";
    }else if(date.substring(5,7).contains("05")){
      date_month = "May";
    }else if(date.substring(5,7).contains("06")){
      date_month = "Jun";
    }else if(date.substring(5,7).contains("07")){
      date_month = "Jul";
    }else if(date.substring(5,7).contains("08")){
      date_month = "Aug";
    }else if(date.substring(5,7).contains("09")){
      date_month = "Sep";
    }else if(date.substring(5,7).contains("10")){
      date_month = "Oct";
    }else if(date.substring(5,7).contains("11")){
      date_month = "Nov";
    }else{
      date_month = "Dec";
    }
    String date_day = date.substring(8,10);
    return date_day+" "+date_month+" "+date_year;
  }

  String restructureTime(String date){
    String category = "";
    String actualHour = "";
    String hour = date.substring(11,13);
    String minuites = date.substring(14,16);
    int d = int.parse(hour);
    if(d>12){
      category = "PM";
      d = d-12;
      actualHour = d.toString();
    }
    else{
      category = "AM";
      actualHour = d.toString();
    }
    return "$actualHour:$minuites $category";
  }

}