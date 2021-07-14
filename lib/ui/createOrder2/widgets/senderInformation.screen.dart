
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pickappuser/constants/app_constants.dart';
import 'package:pickappuser/providers/createOrderProvider.dart';
import 'package:pickappuser/providers/senderInformationProvider.dart';
import 'package:pickappuser/services/dialog.service.dart';
import 'package:pickappuser/ui/shared/customButton.dart';
import 'package:pickappuser/ui/shared/date_n_time_picker.dart';
import 'package:pickappuser/ui/shared/myPageIndicator.dart';
import 'package:pickappuser/ui/shared/myTextInput.dart';
import 'package:provider/provider.dart';

class SenderInformationScreen extends StatefulWidget{

  @override
  SenderInformationScreenState createState() => SenderInformationScreenState();
}

class SenderInformationScreenState extends State<SenderInformationScreen>{

  SenderInformationProvider vm;
  CreateOrderProvider vm2;
  var iAmSenderCheck = false;

  @override
  void initState() {
    vm = context.read< SenderInformationProvider>();
    vm2 = context.read<CreateOrderProvider>();

    vm.senderBuildContext = context;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final secondPageIndicator = PageIndicator(firstIndicator:true);

    final startPeriod = DateNTimePicker(
      labelText: "Pick Up At",
      onChanged: vm.setStartPeriod,
      validator: (DateTime value) {
        if (value == null) return "Start period is required.";
        return null;
      },
    );

    final senderCard = Card(
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
                      setState(() {
                        iAmSenderCheck = !iAmSenderCheck;
                        vm.iAmTheSenderOnClick();
                      });

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
            child: startPeriod,
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
                    child: CustomButton(
                      height: 50,
                      title:  "Previous",
                      onPressed: (){
                        vm2.tabController.animateTo(0);
                      },
                    )
                    

                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: CustomButton(
                      height: 50,
                      title:  "Next",
                      onPressed: (){
                         setState(() {
                            vm.checkSenderName();
                            vm.checkSenderPhone();
                            vm.checkPickUpLocation();
                          });
                          if(vm.senderFullNameError == false && vm.senderPhoneNumberError == false && vm.pickUpLocationError == false){
                             if(vm.pickUpAtDateError){
                               DialogService().showAlertDialog(context: context,
                                   message: "Pick up date must be today and beyond",
                                   type: AlertDialogType.error,
                                   showCancelBtn: false,
                                   onOkayBtnTap: (){
                                     Navigator.pop(context);
                                   }
                               );
                             }
                             else if(vm.pickUpTimeText.length==0){
                               DialogService().showAlertDialog(context: context,
                                   message: "Please select pick up time to proceed",
                                   type: AlertDialogType.error,
                                   showCancelBtn: false,
                                   onOkayBtnTap: (){
                                     Navigator.pop(context);
                                   }
                               );
                             }
                             else{
                               print("pick up time: ${vm.pickUpTimeText}");
                               setState(() {
                                 vm2.senderDetails.senderName = vm.senderFullNameCtrl.text;
                                 vm2.senderDetails.senderPhone = vm.senderPhoneCtrl.text;
                                 vm2.senderDetails.pickUpInstruction = vm.pickUpInstructionCtrl.text;
                                 vm2.senderDetails.pickUpLongitude = vm.pickUpLocationLongitude;
                                 vm2.senderDetails.pickUpLatitude = vm.pickUpLocationLatitude;
                                 vm2.senderDetails.pickUpDescription = vm.pickUpLocationDesCtrl.text;
                                 vm2.senderDetails.iAmSender = vm.iAmTheSender;
                                 vm2.senderDetails.pickUpTime = vm.pickUpTimeText;
                               });
                               vm2.tabController.animateTo(2);
                             }
                            /* print("Second Page conmplete");
                             setState(() {
                               vm2.senderDetails.senderName = vm.senderFullNameCtrl.text;
                               vm2.senderDetails.senderPhone = vm.senderPhoneCtrl.text;
                               vm2.senderDetails.pickUpInstruction = vm.pickUpInstructionCtrl.text;
                               vm2.senderDetails.pickUpLongitude = vm.pickUpLocationLongitude;
                               vm2.senderDetails.pickUpLatitude = vm.pickUpLocationLatitude;
                               vm2.senderDetails.pickUpDescription = vm.pickUpLocationDesCtrl.text;
                               vm2.senderDetails.iAmSender = vm.iAmTheSender;
                             });
                            vm2.tabController.animateTo(2); */
                          }
                      },
                    )
                    
                    
                )
              ],
            ),
          ),
          SizedBox(height: 20,)
        ],
      ),
    );

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(height: 20,),
          secondPageIndicator,
          SizedBox(
            height: 15,
          ),
          senderCard,
          SizedBox(height: 20,)
        ],
      ),
    );
  }

}