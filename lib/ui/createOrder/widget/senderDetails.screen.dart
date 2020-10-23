import 'package:pickappuser/constants/app_constants.dart';
import 'package:pickappuser/ui/shared/myPageIndicator.dart';
import 'package:flutter/material.dart';
import 'package:pickappuser/providers/newOrder.provider.dart';
import 'package:pickappuser/ui/shared/myTextInput.dart';
import 'package:provider/provider.dart';

class SenderDetailsScreen extends StatefulWidget{
  @override
  SenderDetailsScreenState createState() => SenderDetailsScreenState();
}

class SenderDetailsScreenState extends State<SenderDetailsScreen>{
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<NewOrderProvider>(context);
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    final secondPageIndicator = PageIndicator(firstIndicator:true);
    return SingleChildScrollView(
      child: Container(
        width: deviceWidth,
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
    );
  }

}