
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pickappuser/config/locator.dart';
import 'package:pickappuser/constants/app_constants.dart';
import 'package:pickappuser/models/recipient_item.dart';
import 'package:pickappuser/providers/newOrder.provider.dart';
import 'package:pickappuser/services/router.service.dart';
import 'package:pickappuser/ui/createOrder/widget/carrierDetails.screen.dart';
import 'package:pickappuser/ui/createOrder/widget/recipientDetails.screen.dart';
import 'package:pickappuser/ui/createOrder/widget/senderDetails.screen.dart';
import 'package:pickappuser/ui/shared/customButton.dart';
import 'package:pickappuser/ui/shared/myPageIndicator.dart';
import 'package:pickappuser/ui/shared/myTextInput.dart';
import 'package:provider/provider.dart';

class NewOrderScreen extends StatefulWidget{
  final router = locator<RouterService>();
  @override
  _NewOrderScreenState createState() => _NewOrderScreenState();
}
class _NewOrderScreenState  extends State<NewOrderScreen> with TickerProviderStateMixin{

  NewOrderProvider vm1;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {

    vm1 = context.read<NewOrderProvider>();
    vm1.tabController = TabController(
      vsync: this,
      length: 3,
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<NewOrderProvider>(context);
     // ignore: non_constant_identifier_names
     double device_width = MediaQuery.of(context).size.width;
     // ignore: non_constant_identifier_names
     double device_height = MediaQuery.of(context).size.height;



    final thirdPageIndicator = PageIndicator(firstIndicator:true,secondIndicator: true,);

    



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

    // ignore: unused_local_variable
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
                          child: CustomButton(
                              height: 50,
                              title: "ADD NEW RECIPIENT",
                              onPressed: (){
                                vm.addToRecipientCard();
                              },
                            )
                          
                          
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
                              child: CustomButton(
                                title: "Previous",
                                height: 50,
                                onPressed: (){
                                   vm.navigateToSecondPage();
                                },
                              )
                              
                              

                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: CustomButton(
                                  onPressed:(){
                                    vm.checkRecipientData();
                                  },
                                  height: 50,
                                  title:  "Proceed",
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




   
    return WillPopScope(
      onWillPop:(){
        vm.reset(context);
        return Future.delayed(Duration(microseconds: 1), () => false);
        },
      child: Scaffold(
        key: scaffoldKey,
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
        body:
        Container(
          height: device_height,
          width: device_width,
          color: Colors.white,
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: vm1.tabController,
            children: [
              CarrierDetailsScreen(carrierTypeContext: scaffoldKey.currentContext,),
              SenderDetailsScreen(),
              RecipientsScreen()
            ],
          )
          /*Stack(
            children: <Widget>[
              firstScreen,
              secondScreen,
              thirdScreen
            ],
          ),*/
        ),


      ),
    );


  }
  
}