
import 'package:flutter/material.dart';
import 'package:pickappuser/constants/app_constants.dart';
import 'package:pickappuser/providers/newOrder.provider.dart';
import 'package:pickappuser/ui/shared/myTextInput.dart';
import 'package:provider/provider.dart';
import 'package:pickappuser/ui/shared/myPageIndicator.dart';

class CarrierDetailsScreen extends StatefulWidget{
  @override
  CarrierDetailsScreenState createState() => CarrierDetailsScreenState();
}

class CarrierDetailsScreenState extends State<CarrierDetailsScreen>{
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<NewOrderProvider>(context);
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    final firstPageIndicator = PageIndicator();
    // TODO: implement build
    return SingleChildScrollView(
      child: Container(
          width:deviceWidth,
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
      )
    );
  }

}