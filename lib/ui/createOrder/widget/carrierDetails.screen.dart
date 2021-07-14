
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pickappuser/config/locator.dart';
import 'package:pickappuser/constants/app_constants.dart';
import 'package:pickappuser/constants/utils.dart';
import 'package:pickappuser/models/carrier_item.dart';
import 'package:pickappuser/providers/newOrder.provider.dart';
import 'package:pickappuser/services/dialog.service.dart';
import 'package:pickappuser/services/http.service.dart';
import 'package:pickappuser/services/router.service.dart';
import 'package:pickappuser/ui/shared/customButton.dart';
import 'package:pickappuser/ui/shared/myTextInput.dart';
import 'package:provider/provider.dart';
import 'package:pickappuser/ui/shared/myPageIndicator.dart';


class CarrierDetailsScreen extends StatefulWidget{
  final BuildContext carrierTypeContext;


  const CarrierDetailsScreen({Key key,
    this.carrierTypeContext
  }) : super(key: key);
  @override
  CarrierDetailsScreenState createState() => CarrierDetailsScreenState();
}

class CarrierDetailsScreenState extends State<CarrierDetailsScreen>{
  NewOrderProvider vm2;
  var router = locator<RouterService>();
  final requests = locator<HttpService>();
  List<CarrierType>carrierTypes = [];
  @override
  void initState() {
    vm2 = context.read<NewOrderProvider>();
    vm2.carrierTypeContext = widget.carrierTypeContext;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    final vm = Provider.of<NewOrderProvider>(context);
    double deviceWidth = MediaQuery.of(context).size.width;

    final firstPageIndicator = PageIndicator();
    
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
                          getCarrierTypes(context);
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
                      child:  CustomButton(
                        height: 50,
                        setWidth: true,
                        width: 300,
                        title:  "Next",
                        onPressed: (){
                          vm.navigateToSecondPage();
                        },
                      )
                      
                      
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

  // ignore: non_constant_identifier_names
  Widget CarrierTypeItem(CarrierType content,index,BuildContext context){
    return InkWell(
      child: Container(
        width: 100,
        height: 100,
        child: Column(
          children: <Widget>[
            Image.network(content.carrierImageUrl,height: 60,width: 100,),
            Container(
              height: 40,
              width: 100,
              child: Center(
                child: Text(
                    content.carrierName
                ),
              ),
            )
          ],
        ),
      ),
      onTap: (){
        setState(() {
          vm2.carrierTypeCtrl.text = carrierTypes[index].carrierName;
          vm2.selectedCarrierType = carrierTypes[index];
        });
        Navigator.pop(context);
      },
    );
  }

  void getCarrierTypes(BuildContext context) async{
    Utils.getProgressBar(context, "Loading,please wait", "showProgress");
    var response;
    response = await requests.getCarrierTypes();
    print(response);
    List<dynamic> body = jsonDecode(response.body);
    print(body);
    for(int i=0;i<body.length;i++){
      setState(() {
        carrierTypes.add(new CarrierType(carrierId: body[i]['id'], carrierName: body[i]['name'], carrierImageUrl: body[i]['photo']));
      });

      //print(body[i]['name']);
    }
    Utils.getProgressBar(context, "Loading,please wait..", "");

    //Showing Carrier Types Dialog
    DialogService().showCustomDialog(
        context: context,
        customDialog: Container(
            height: 400,
            child: Column(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(left:15,top:20,bottom: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Carrier Types",
                        style: TextStyle(color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 17
                        ),
                      ),
                    )
                ),
                SizedBox(
                  height: 300,
                  child: GridView.count(
                      crossAxisCount: 2,
                      children: List.generate(carrierTypes.length, (index){
                        return Center(
                          child: CarrierTypeItem(carrierTypes[index],index,context),
                        );
                      })
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right:10),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        child:  Text("CANCEL",style: TextStyle(color: Colors.grey),),
                        onTap: (){
                          Navigator.pop(context);
                        },
                      )

                  ),
                )

              ],
            )

        ),
        barrierDismissible: true
    );



  }
}