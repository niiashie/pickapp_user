
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pickappuser/constants/app_constants.dart';
import 'package:pickappuser/providers/carrierInformationProvider.dart';
import 'package:pickappuser/providers/createOrderProvider.dart';
import 'package:pickappuser/ui/shared/customButton.dart';
import 'package:pickappuser/ui/shared/myPageIndicator.dart';
import 'package:pickappuser/ui/shared/myTextInput.dart';
import 'package:provider/provider.dart';

class CarrierInformationScreen extends StatefulWidget{
  @override
  CarrierInformationScreenState createState() => CarrierInformationScreenState();
}
class CarrierInformationScreenState extends State<CarrierInformationScreen>{

  CarrierInformationProvider vm;
  CreateOrderProvider vm2;
  File itemImage;
  bool imageSelected = false;
  final picker = ImagePicker();
  @override
  void initState() {
    super.initState();
    vm = context.read<CarrierInformationProvider>();
    vm2 = context.read<CreateOrderProvider>();
    vm.carrierPageContext = context;

    //vm.initProvider();
  }

  @override
  Widget build(BuildContext context) {
    if(vm.selectedItemImage==null){
      print("selected Image null");
    }else{
      print("selected Image not null");
    }
    final firstPageIndicator = PageIndicator();

    final carrierCard = Card(
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
                vm.getCarrierTypes();
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
                      setState(() {
                        vm.packageFragile = newValue;
                        print("New Value: ${vm.packageFragile}");
                      });
                      //vm.packageFragileOnClick();
                    },
                  ),
                )
              ],
            ),
          ),
          Visibility(
            visible:imageSelected,
              child: Container(
                height: 120,
                width: 150,
                margin: EdgeInsets.only(left:10,right: 10,top: 10),
                child:itemImage!=null?Image.file(itemImage,width: 120,height: 120,fit: BoxFit.cover,):Container(),
              )
          ),
          Container(
            margin: EdgeInsets.only(left:10,right: 10,top: 10),
            child: Row(
              children: [
                Expanded(
                    child: CustomButton(
                      height: 50,
                      title:  "Capture Snapshot of Item",
                      setColor: true,
                      backgroundColor: Colors.white,
                      onPressed: ()async{
                        final pickedFile = await picker.getImage(source: ImageSource.camera);
                          setState(() {
                            if (pickedFile != null) {
                              imageSelected = true;
                              itemImage = File(pickedFile.path);
                            } else {
                              print('No image selected.');
                            }
                          });
                      },
                    )
                  
                ),
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
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: CustomButton(
                      onPressed:(){
                        setState(() {
                          vm.checkCarrierType();
                          vm.checkPackageSize();
                          vm.checkItemQuantity();
                          vm.checkItemDescription();
                        });

                        if(vm.packQuantityError== false && vm.carrierTypeError == false && vm.packageSizeError == false &&
                            vm.itemDescriptionError == false){
                           setState(() {
                             vm2.carrierDetails.selectedCarrierType = vm.selectedCarrierType;
                             vm2.carrierDetails.selectedPackageSize = vm.selectedPackageSize;
                             vm2.carrierDetails.packageFragile = vm.packageFragile;
                             vm2.carrierDetails.itemDescription = vm.itemDescriptionCtrl.text;
                             vm2.carrierDetails.itemQuantity = vm.packageQuantityCtrl.text;
                             vm2.carrierDetails.packageFragile = vm.packageFragile;
                             vm2.carrierDetails.selectedItemCaptureImage = itemImage;
                           });

                          vm2.tabController.animateTo(1);

                        }
                      },
                      title:"Next",
                      height: 50,
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
        children: [
          SizedBox(height: 20,),
          firstPageIndicator,
          SizedBox(height: 15,),
          carrierCard
        ],
      ),
    );
  }

}