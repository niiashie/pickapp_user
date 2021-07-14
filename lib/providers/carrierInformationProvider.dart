
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pickappuser/config/locator.dart';
import 'package:pickappuser/constants/utils.dart';
import 'package:pickappuser/models/carrier_item.dart';
import 'package:pickappuser/models/package_item.dart';
import 'package:pickappuser/services/dialog.service.dart';
import 'package:pickappuser/services/http.service.dart';

class CarrierInformationProvider extends ChangeNotifier{
  final requests = locator<HttpService>();

  //Text editing controllers
  final carrierTypeCtrl = TextEditingController();
  final packageSizeCtrl = TextEditingController();
  final packageQuantityCtrl = TextEditingController();
  final itemDescriptionCtrl = TextEditingController();

  //Error checkers
  bool carrierTypeError = false;
  bool packageSizeError = false;
  bool packQuantityError = false;
  bool itemDescriptionError = false;

  //Package Fragile
  bool packageFragile = false;

  bool imageSelected = false;

  //Page Context
  BuildContext carrierPageContext;

  //Lists
  List<CarrierType>carrierTypes = [];
  List<PackageSizes>packageSizes = [];

  //Selected Values
  CarrierType selectedCarrierType;
  PackageSizes selectedPackageSize;

  //File
  File selectedItemImage;

  initProvider(){
    carrierTypeCtrl.text ="";
    packageSizeCtrl.text = "";
    packageQuantityCtrl.text = "";
    itemDescriptionCtrl.text = "";

    carrierTypeError = false;
    packageSizeError = false;
    packQuantityError = false;
    itemDescriptionError = false;
    packageFragile = false;
    selectedItemImage = null;
    imageSelected = false;
    selectedCarrierType = new CarrierType(carrierId: null, carrierName: null, carrierImageUrl: null);
    selectedPackageSize = new PackageSizes(packageName: null, packageSize: null, packageWeight: null, packagePhoto: null, packageId: null);

    notifyListeners();
  }

  imgFromCamera(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery,imageQuality: 100);
    if(pickedFile == null){
      DialogService().showAlertDialog(context: context, message:"No image selected",
          type: AlertDialogType.warning,showCancelBtn:false,onOkayBtnTap: (){
            Navigator.pop(context);
          }
      );
    }
    else{
      imageSelected = true;
      selectedItemImage = File(pickedFile.path);
      notifyListeners();
    }


  }

   getCarrierTypes() async{
    Utils.getProgressBar(carrierPageContext, "Loading,please wait", "showProgress");
    var response;
    response = await requests.getCarrierTypes();
    print(response);
    List<dynamic> body = jsonDecode(response.body);
    print(body);
    for(int i=0;i<body.length;i++){
      carrierTypes.add(new CarrierType(carrierId: body[i]['id'], carrierName: body[i]['name'], carrierImageUrl: body[i]['photo']));
      print(body[i]['name']);
    }
    Utils.getProgressBar(carrierPageContext, "Loading,please wait..", "");

    //Showing Carrier Types Dialog
    DialogService().showCustomDialog(
        context: carrierPageContext,
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
                          child: CarrierTypeItem(carrierTypes[index],index,carrierPageContext),
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
                          Navigator.pop(carrierPageContext);
                        },
                      )

                  ),
                )

              ],
            )

        ),
        barrierDismissible: true
    );

    notifyListeners();

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
        carrierTypeCtrl.text = carrierTypes[index].carrierName;
        selectedCarrierType = carrierTypes[index];
        notifyListeners();
        Navigator.pop(context);
      },
    );
  }

  void getPackageSizes(BuildContext context) async{
    Utils.getProgressBar(context, "Loading,please wait..", "showProgress");
    var response;
    response = await requests.getPackageSizes();
    print(response);
    List<dynamic> body = jsonDecode(response.body);
    print(body);
    packageSizes.clear();
    for(int i=0;i<body.length;i++){
      packageSizes.add(new PackageSizes(packageName: body[i]['name'],
          packageSize: body[i]['dimension'],
          packageWeight: body[i]['weight'],
          packagePhoto: body[i]['photo'],
          packageId: body[i]['id']
      ));
      print(body[i]['name']);
    }
    Utils.getProgressBar(context, "Loading,please wait..", "");

    //Showing Carrier Types Dialog
    DialogService().showCustomDialog(
        context: context,
        customDialog: Container(
            height: 500,
            child: Column(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(left:15,top:20,bottom: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Package Sizes",
                        style: TextStyle(color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 17
                        ),
                      ),
                    )
                ),
                SizedBox(
                  height: 400,
                  child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 100/150,
                      children: List.generate(packageSizes.length, (index){
                        return Center(
                          child: PackageSizesItem(packageSizes[index],index,context),
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

    notifyListeners();

  }

  // ignore: non_constant_identifier_names
  Widget PackageSizesItem(PackageSizes content,index,BuildContext context){
    return InkWell(
      child: Container(
        width: 100,
        child: Column(
          children: <Widget>[
            Image.network(content.packagePhoto,height: 60,width: 100,),
            Container(
              height: 40,
              width: 100,
              child: Center(
                child: Text(
                    content.packageName
                ),
              ),
            ),

            Container(
              height: 40,
              width: 100,
              child: Center(
                child: Text(
                    content.packageSize
                ),
              ),
            ),

            Container(
              height: 40,
              width: 100,
              child: Center(
                child: Text(
                    content.packageWeight
                ),
              ),
            )
          ],
        ),
      ),
      onTap: (){
        packageSizeCtrl.text = packageSizes[index].packageName;
        selectedPackageSize = packageSizes[index];
        notifyListeners();
        Navigator.pop(context);
      },
    );
  }

  void packageFragileOnClick(){
    packageFragile = !packageFragile;
    print("package Fragile $packageFragile");
    /*if(packageFragile == true){
      packageFragileAnswer = "Yes";
    }else{
      packageFragileAnswer = "No";
    }*/
    notifyListeners();
  }

  void checkCarrierType(){
    if(carrierTypeCtrl.text.isEmpty){
      carrierTypeError = true;
    }
    else{
      carrierTypeError = false;
    }
  }

  void checkPackageSize(){
    if(packageSizeCtrl.text.isEmpty){
      packageSizeError = true;
    }
    else{
      packageSizeError = false;
    }
  }

  void checkItemQuantity(){
    if(packageQuantityCtrl.text.isEmpty){
      packQuantityError = true;
    }
    else{
      packQuantityError = false;
    }
  }

  void checkItemDescription(){
    if(itemDescriptionCtrl.text.isEmpty){
      itemDescriptionError = true;
    }
    else{
      itemDescriptionError = false;
    }
  }



}