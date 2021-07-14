
import 'dart:io';
import 'package:pickappuser/models/carrier_item.dart';
import 'package:pickappuser/models/package_item.dart';

class CarrierInformationModel{
  CarrierType selectedCarrierType;
  PackageSizes selectedPackageSize;
  String itemQuantity;
  String itemDescription;
  bool packageFragile;
  File selectedItemCaptureImage;

  CarrierInformationModel(
  {
    this.selectedCarrierType,
     this.selectedPackageSize,
     this.itemQuantity,
     this.itemDescription,
     this.packageFragile,
     this.selectedItemCaptureImage
  }
  ){
      this.selectedCarrierType = selectedCarrierType;
      this.selectedPackageSize = selectedPackageSize;
      this.itemQuantity = itemQuantity;
      this.itemDescription = itemDescription;
      this.packageFragile = packageFragile;
      this.selectedItemCaptureImage = selectedItemCaptureImage;
   }
}