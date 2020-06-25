
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pickappuser/config/locator.dart';
import 'package:pickappuser/constants/app_constants.dart';
import 'package:pickappuser/models/recipient_item.dart';
import 'package:pickappuser/providers/newOrder.provider.dart';
import 'package:pickappuser/services/router.service.dart';
import 'package:pickappuser/ui/createOrder/widget/recipient.card.dart';
import 'package:pickappuser/ui/shared/myPageIndicator.dart';
import 'package:pickappuser/ui/shared/myTextInput.dart';
import 'package:provider/provider.dart';

class NewOrderScreen extends StatefulWidget{
  final router = locator<RouterService>();
  @override
  _NewOrderScreenState createState() => _NewOrderScreenState();
}
class _NewOrderScreenState  extends State<NewOrderScreen>{
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<NewOrderProvider>(context);
     double device_width = MediaQuery.of(context).size.width;
     double device_height = MediaQuery.of(context).size.height;


    final firstPageIndicator = PageIndicator();
    final secondPageIndicator = PageIndicator(firstIndicator:true);
    final thirdPageIndicator = PageIndicator(firstIndicator:true,secondIndicator: true,);

    final firstScreen = SingleChildScrollView(
      child: Visibility(
        visible: vm.firstPageVisible,
        child:  Container(
            width: device_width,
            margin: EdgeInsets.only(left:20,right:20),
            child: Column(
              children: <Widget>[
                SizedBox(height: 20,),
                firstPageIndicator,
                SizedBox(
                  height: 15,
                ),
                Card(
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
                              child: Divider(color: Colors.grey,),
                            ),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  margin: EdgeInsets.only(left:20),
                                  child: Text(
                                    "Carrier Details",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w700),
                                  ),
                                )
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 60,
                        margin: EdgeInsets.only(left:10,right: 10,top: 15),
                        child: MyTextInputField(
                          label: "Carrier Type",
                           readOnly: true,
                          controller: vm.carrierTypeCtrl,
                          error: vm.carrierTypeError,
                          errorText: AppConstants.carrierTypeError,
                          onTap: (){
                            vm.getCarrierTypes(context);
                          },
                        ),
                      ),
                      Container(
                        height: 60,
                        margin: EdgeInsets.only(left:10,right: 10,top: 10),
                        child: MyTextInputField(
                          label: "Package Size",
                          readOnly: true,
                          error:vm.packageSizeError,
                          errorText: AppConstants.packageSizeError,
                          controller: vm.packageSizeCtrl,
                          onTap: (){
                            vm.getPackageSizes(context);
                          },
                        ),
                      ),
                      Container(
                        height: 60,
                        margin: EdgeInsets.only(left:10,right: 10,top: 10),
                        child: MyTextInputField(
                          label: "Package Quantity",
                          textEntryType: TextInputType.number,
                          error:vm.packQuantityError,
                          errorText: AppConstants.packageQuantityError,
                          controller: vm.packageQuantityCtrl,
                        ),
                      ),
                      Container(
                        height: 40,
                        margin: EdgeInsets.only(left:10,right: 10),
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text("The product is fragile",style: TextStyle(color: Colors.grey,fontSize: 15),),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child:Checkbox(
                                value: vm.packageFragile,
                                activeColor: Colors.amber[900],
                                onChanged: (bool newValue){
                                  vm.packageFragileOnClick();
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(

                        margin: EdgeInsets.only(left:10,right: 10,top: 10),
                        child: MyTextInputField(
                          label: "Item Description",
                          maxlines: 3,
                          errorText: AppConstants.itemDescriptionError,
                          error: vm.itemDescriptionError,
                          controller: vm.itemDescriptionCtrl,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left:10,right: 10,top: 10),
                        child: ButtonTheme(
                          height: 50,
                          minWidth: 300,
                          child:  RaisedButton(
                            color: Colors.amber[900],
                            child: Text(
                              "Next",
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.amber[900],
                                    width: 1,
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(5)),
                            onPressed: (){
                              vm.navigateToSecondPage();
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 20,)
                    ],
                  ),
                ),
                SizedBox(height: 20,)
              ],
            )
        ),
      ),
    );

    final secondScreen = SingleChildScrollView(
      child: Visibility(
        visible: vm.secondPageVisible,
        child: Container(
          width: device_width,
          margin: EdgeInsets.only(left:20,right:20),
          child: Column(
            children: <Widget>[
              SizedBox(height: 20,),
              secondPageIndicator,
              SizedBox(
                height: 15,
              ),
              Card(
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
                            child: Divider(color: Colors.grey,),
                          ),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                margin: EdgeInsets.only(left:20),
                                child: Text(
                                  "Sender Details",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w700),
                                ),
                              )
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left:20,top: 15),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Contact Information"),
                      ),
                    ),
                    Container(
                      height: 40,
                      margin: EdgeInsets.only(left:20,right: 10,top:10),
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("I am the sender",
                              style: TextStyle(
                                  color: Colors.grey
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Checkbox(
                              value: vm.iAmTheSender,
                              activeColor: Colors.amber[900],
                              onChanged: (bool newValue){
                                vm.iAmTheSenderOnClick();
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(

                      margin: EdgeInsets.only(left:10,right: 10,top: 10),
                      child: MyTextInputField(
                        label: "Full Name",
                        controller: vm.senderFullNameCtrl,
                        error: vm.senderFullNameError,
                        errorText: AppConstants.fullNameError,
                      ),
                    ),
                    Container(

                      margin: EdgeInsets.only(left:10,right: 10,top: 10),
                      child: MyTextInputField(
                        label: "Phone",
                        textEntryType: TextInputType.phone,
                        controller: vm.senderPhoneCtrl,
                        errorText: AppConstants.phoneError,
                        error: vm.senderPhoneNumberError,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left:20,top: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("PickUp Information"),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left:10,right: 10,top: 10),
                      child: MyTextInputField(
                        label: "Pickup Location",
                        textEntryType: TextInputType.text,
                        readOnly: true,
                        controller: vm.pickUpLocationDesCtrl,
                        error: vm.pickUpLocationError,
                        errorText: AppConstants.pickUpLocationError,
                        trailingIcon: true,
                        onTap: (){
                          vm.searchPlaces(context);
                        },
                        trailIcon: Icons.location_on,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left:10,right: 10,top: 10),
                      child: MyTextInputField(
                        label: "Instruction",
                        controller: vm.pickUpInstructionCtrl,
                        maxlines: 5,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left:10,right: 10,top: 10),
                      height: 50,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                              child: ButtonTheme(
                                height:50,
                                child:  RaisedButton(
                                  color: Colors.amber[900],
                                  child: Text(
                                    "Previous",
                                    style: TextStyle(
                                        color: Colors.white
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.amber[900],
                                          width: 1,
                                          style: BorderStyle.solid),
                                      borderRadius: BorderRadius.circular(5)),
                                  onPressed: (){
                                    vm.navigateToFirstPage();
                                  },
                                ),
                              )

                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: ButtonTheme(
                                height: 50,
                                child:  RaisedButton(
                                  color: Colors.amber[900],
                                  child: Text(
                                    "Next",
                                    style: TextStyle(
                                        color: Colors.white
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.amber[900],
                                          width: 1,
                                          style: BorderStyle.solid),
                                      borderRadius: BorderRadius.circular(5)),
                                  onPressed: (){
                                    vm.navigateToThirdPage();
                                  },
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
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );




    Widget recipientListItem(RecipientData content,index){
      return Container(
        child: Card(
          elevation: 3,
          child: Column(
            children: <Widget>[
              Container(
                height: 60,
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: content.cardExpanded ?
                      IconButton(
                        icon: Icon(Icons.arrow_drop_down,size: 20,color: Colors.grey,),
                        onPressed: (){
                          print(index);
                          vm.recipientCardIconClick(index);
                        },
                      )
                          :IconButton(
                        icon: Icon(Icons.arrow_drop_up,color:Colors.grey),
                        onPressed: (){
                          print(index);
                          vm.recipientCardIconClick(index);
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.only(left:40),
                        child: Text(
                          content.title,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: Icon(Icons.delete,color: Colors.grey,size: 20,),
                        onPressed: (){
                          vm.removeRecipientCard(index);
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: content.cardExpanded ? Divider(color: Colors.grey,):null,
                    )
                  ],
                ),
              ),
              Visibility(
                visible:content.cardExpanded ,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left:20,top: 15),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Contact Information"),
                      ),
                    ),
                    Container(
                      height: 40,
                      margin: EdgeInsets.only(left:20,right: 10,top:10),
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("I am the recipient",
                              style: TextStyle(
                                  color: Colors.grey
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Checkbox(
                              value: content.iAmTheRecipient,
                              activeColor: Colors.amber[900],
                              onChanged: (bool newValue){
                                vm.iAmRecipientClicked(newValue,index);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left:10,right: 10,top: 10),
                      child: MyTextInputField(
                        label: "Full Name",
                        controller: content.fullnameController,
                        errorText: AppConstants.fullNameError,
                        error: content.fullNameError,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left:10,right: 10,top: 10),
                      child: MyTextInputField(
                        label: "Phone",
                        textEntryType: TextInputType.phone,
                        controller: content.phoneController,
                        error: content.phoneError,
                        errorText: AppConstants.phoneError,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left:20,top: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Delivery Information"),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left:10,right: 10,top: 10),
                      child: MyTextInputField(
                        label: "Delivery Location",
                        textEntryType: TextInputType.text,
                        trailingIcon: true,
                        readOnly: true,
                        errorText: AppConstants.deliveryLocationError,
                        error: content.deliveryLocationError,
                        onTap:(){
                          vm.recipientDeliveryLocation(content, context);
                        },
                        trailIcon: Icons.location_on,
                        controller: content.deliveryLocationTextController,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left:10,right: 10,top: 10),
                      child: MyTextInputField(
                        label: "Instruction",
                        maxlines: 5,
                        controller: content.deliveryInstructionController,
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

    final thirdScreen = Visibility(
      visible: vm.thirdPageVisible,
      child: ListView.builder(itemBuilder:(context,index){
        return   Container(
          width: device_width,
          margin: EdgeInsets.only(left:20,right:20),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top:20),
                child:  thirdPageIndicator,
              ),
              Container(
                  margin: EdgeInsets.only(top:10),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: vm.recipientSizedBoxHeight,
                        child: AnimatedList(
                          key: vm.listKey,
                          initialItemCount: vm.recipientList.length,
                          itemBuilder: (context, index, animation) {
                            // Breaking the row widget out as a method so that we can
                            // share it with the _removeSingleItem() method.
                            return recipientListItem(vm.recipientList[index],index);
                          },
                          physics: ClampingScrollPhysics(),
                        ),
                      )

                    ],
                  )
              ),
              Container(
                margin: EdgeInsets.only(top:10),
                height: 120,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                          child: ButtonTheme(
                            height: 50,
                            child:RaisedButton(
                              color: Colors.amber[900],
                              child: Text(
                                "ADD NEW RECIPIENT",
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.amber[900],
                                      width: 1,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(5)),
                              onPressed: (){
                                vm.addToRecipientCard();
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top:10),
                      child:Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                              child: ButtonTheme(
                                height:50,
                                child:  RaisedButton(
                                  color: Colors.amber[900],
                                  child: Text(
                                    "Previous",
                                    style: TextStyle(
                                        color: Colors.white
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.amber[900],
                                          width: 1,
                                          style: BorderStyle.solid),
                                      borderRadius: BorderRadius.circular(5)),
                                  onPressed: (){
                                    vm.navigateToSecondPage();
                                  },
                                ),
                              )

                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: ButtonTheme(
                                height: 50,
                                child:  RaisedButton(
                                  color: Colors.amber[900],
                                  child: Text(
                                    "Proceed",
                                    style: TextStyle(
                                        color: Colors.white
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.amber[900],
                                          width: 1,
                                          style: BorderStyle.solid),
                                      borderRadius: BorderRadius.circular(5)),
                                  onPressed: (){
                                    vm.checkRecipientData();
                                  },
                                ),
                              )
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20,)
            ],
          ),
        );
      },
        itemCount: 1,
      ),
    );





    // TODO: implement build
    return WillPopScope(
      onWillPop:(){vm.reset(context);},
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "New Order",
            style: TextStyle(
                color: Colors.white
            ),),
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          backgroundColor: Colors.purple[900],
        ),
        body: Container(
          height: device_height,
          width: device_width,
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              firstScreen,
              secondScreen,
              thirdScreen
            ],
          ),
        ),


      ),
    );


  }
  
}