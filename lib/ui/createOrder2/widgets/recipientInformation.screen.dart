
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:pickappuser/config/locator.dart';
import 'package:pickappuser/constants/app_constants.dart';
import 'package:pickappuser/constants/local_storage_name.dart';
import 'package:pickappuser/constants/routes.dart';
import 'package:pickappuser/models/recipient_information_model.dart';
import 'package:pickappuser/models/recipient_item.dart';
import 'package:pickappuser/providers/createOrderProvider.dart';
import 'package:pickappuser/providers/recipientInformationProvider.dart';
import 'package:pickappuser/providers/senderInformationProvider.dart';
import 'package:pickappuser/services/router.service.dart';
import 'package:pickappuser/ui/shared/customButton.dart';
import 'package:pickappuser/ui/shared/myPageIndicator.dart';
import 'package:pickappuser/ui/shared/myTextInput.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecipientInformationScreen extends StatefulWidget{
  @override
  RecipientInformationScreenState createState() => RecipientInformationScreenState();
}

class RecipientInformationScreenState extends State<RecipientInformationScreen>{

  RecipientInformationProvider vm;
  CreateOrderProvider vm2;
  SenderInformationProvider vm3;
  final router = locator<RouterService>();

  @override
  void initState() {
    super.initState();
    vm = context.read<RecipientInformationProvider>();
    vm2 = context.read<CreateOrderProvider>();
    vm3 = context.read<SenderInformationProvider>();
    print(vm2.senderDetails.senderName);
  }
  List<String>names = ["Nii","Kofi"];
  List<RecipientData>recipientList = [
    new RecipientData(title: "Recepient 1 Detail",
        fullnameController: new TextEditingController(),
        phoneController: new TextEditingController(),
        deliveryInstructionController: new TextEditingController(),
        deliveryLocationTextController: new TextEditingController(),
        cardExpanded: true, iAmTheRecipient: false,
        locationLatitude: "", locationLongitude:"", fullNameError: false,
        phoneError: false, deliveryLocationError: false)
  ];
  var recipientSizedBoxHeight = 450.00;
  @override
  Widget build(BuildContext context) {
    final thirdPageIndicator = PageIndicator(firstIndicator:true,secondIndicator: true,);

    void setOrderRecipientList(){
      setState(() {
        vm2.recipientsDetails.clear();
      });
      for(var i=0;i<recipientList.length;i++){
        setState(() {
          RecipientInformationModel recipient = new RecipientInformationModel();
          recipient.recipientName = recipientList[i].fullnameController.text;
          recipient.recipientPhone = recipientList[i].phoneController.text;
          recipient.recipientDeliveryInstruction = recipientList[i].deliveryInstructionController.text;
          recipient.recipientDeliveryLocation = recipientList[i].deliveryLocationTextController.text;
          recipient.recipientDeliveryLongitude = recipientList[i].locationLongitude;
          recipient.recipientDeliveryLatitude = recipientList[i].locationLatitude;
          recipient.recipientCardExpanded = false;
          vm2.recipientsDetails.add(recipient);
          print(vm2.recipientsDetails.length);
        });
      }
      vm2.recipientsDetailsHeight = recipientSizedBoxHeight;
      router.navigateTo(AppRoutes.orderSummaryScreenRoute);
    }

    void checkRecipientData(){
      int errorCounter = 0;
      setState(() {
        for(int i=0;i<recipientList.length;i++){
          //Check Full name for errors
          if(recipientList[i].fullnameController.text.isEmpty){
            recipientList[i].fullNameError = true;
            errorCounter = errorCounter + 1;
          }
          else{
            recipientList[i].fullNameError = false;
          }

          //Check Phone number for errors
          if(recipientList[i].phoneController.text.length!=10){
            recipientList[i].phoneError = true;
            errorCounter = errorCounter + 1;
          }
          else{
            recipientList[i].phoneError = false;
          }

          //Check Delivery Locations
          if(recipientList[i].deliveryLocationTextController.text.isEmpty){
            recipientList[i].deliveryLocationError = true;
            errorCounter = errorCounter + 1;
          }
          else{
            recipientList[i].deliveryLocationError = false;
          }


        }
      });
      if(errorCounter == 0){
         setOrderRecipientList();
        //collapseRecipientCards();
        //router.navigateTo(AppRoutes.orderSummaryScreenRoute);
      }
    }

    void changeRecipientSizedBoxHeight(){
      double closedHeight = 70.00;
      double expandedHeight = 450.00;
      double totalHeight = 0;
      for(int y=0;y<recipientList.length;y++){
        if(recipientList[y].cardExpanded == true){
          totalHeight = totalHeight + expandedHeight;
        }else{
          totalHeight = totalHeight + closedHeight;
        }
      }
      setState(() {
        recipientSizedBoxHeight = totalHeight;
      });
    }

    Future<Null> populateRecipientDelivery(Prediction p,RecipientData recipient) async {
      GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: AppConstants.googlePlacesAPIKey);
      if (p != null) {
        // get detail (lat/lng)
        PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);
        final lat = detail.result.geometry.location.lat;
        final lng = detail.result.geometry.location.lng;

        setState(() {
          recipient.deliveryLocationTextController.text = detail.result.name;
          recipient.locationLatitude = lat.toString();
          recipient.locationLongitude = lng.toString();
        });
        // print("The selected place has longitude: $lng and latitude: $lat");

      }
    }

    void onError(PlacesAutocompleteResponse response) {
      print(response.errorMessage);
    }

    Future<void> recipientDeliveryLocation(RecipientData recipient) async {
      Prediction p = await PlacesAutocomplete.show(
        context: context,
        apiKey: AppConstants.googlePlacesAPIKey,
        onError: onError,
        mode: Mode.fullscreen,
        language: "en",
        components: [Component(Component.country, "gh")],
      );
      populateRecipientDelivery(p,recipient);
    }

    void removeRecipientCard(int index){
      setState(() {
        recipientList.removeAt(index);
      });
      changeRecipientSizedBoxHeight();
    }

    void iAmRecipientClicked (bool newValue,int index) async{

      SharedPreferences preferences = await SharedPreferences.getInstance();
      String userName =preferences.getString(LocalStorageName.userName);
      String userPhone =preferences.getString(LocalStorageName.userPhone);
      setState(() {
      recipientList[index].iAmTheRecipient = newValue;
      if(newValue == true){
        //Clear other I am the recipient checked
        for(int i=0;i<recipientList.length;i++){
          if(i!=index){
            iAmRecipientClicked(false, i);
          }
        }

          recipientList[index].fullnameController.text = userName;
          recipientList[index].phoneController.text = userPhone;


          if(vm3.iAmTheSender == true){
            vm3.iAmTheSender = false;
            vm3.senderFullNameCtrl.text = "";
            vm3.senderPhoneCtrl.text = "";
            vm2.tabController.animateTo(1);
            //navigateToSecondPage();
          }

      }
      else{
        setState(() {
          recipientList[index].fullnameController.text = "";
          recipientList[index].phoneController.text = "";
        });
      }

      });


    }

    return ListView.builder(itemBuilder:(context,index){
      return   Column(
        children: [
          SizedBox(height: 20,),
          thirdPageIndicator,
          SizedBox(
            height: recipientSizedBoxHeight,
            child:ListView.builder(itemBuilder: (context,index){
              //return recipientListItem(recipientList[index], index);
              return Container(
                  child: Card(
                    elevation: 3,
                    child: Column(
                      children: [
                        Container(
                          height: 60,
                          child: Stack(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: recipientList[index].cardExpanded ?
                                IconButton(
                                  icon: Icon(Icons.arrow_drop_down,size: 20,color: Colors.grey,),
                                  onPressed: (){
                                    setState(() {
                                      recipientList[index].cardExpanded = !recipientList[index].cardExpanded;
                                    });
                                    changeRecipientSizedBoxHeight();
                                    //vm.recipientCardIconClick(index);
                                  },
                                )
                                    :IconButton(
                                  icon: Icon(Icons.arrow_drop_up,color:Colors.grey),
                                  onPressed: (){
                                    setState(() {
                                      recipientList[index].cardExpanded = !recipientList[index].cardExpanded;
                                    });
                                    changeRecipientSizedBoxHeight();
                                    //vm.recipientCardIconClick(index);
                                  },
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  margin: EdgeInsets.only(left:40),
                                  child: Text(
                                    recipientList[index].title,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Visibility(
                                  visible: index==0?false:true,
                                  child:  IconButton(
                                    icon: Icon(Icons.delete,color: Colors.grey,size: 20,),
                                    onPressed: (){
                                      removeRecipientCard(index);
                                    },
                                  ),
                                )

                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: recipientList[index].cardExpanded ? Divider(color: Colors.grey,):null,
                              )
                            ],
                          ),
                        ),
                        Visibility(
                          visible:recipientList[index].cardExpanded ,
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
                                        value: recipientList[index].iAmTheRecipient,
                                        activeColor: Colors.amber[900],
                                        onChanged: (bool newValue){
                                          iAmRecipientClicked(newValue,index);

                                          //vm.iAmRecipientClicked(newValue,index);
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
                                  controller: recipientList[index].fullnameController,
                                  errorText: AppConstants.fullNameError,
                                  error: recipientList[index].fullNameError,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left:10,right: 10,top: 10),
                                child: MyTextInputField(
                                  label: "Phone",
                                  textEntryType: TextInputType.phone,
                                  controller: recipientList[index].phoneController,
                                  error: recipientList[index].phoneError,
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
                                  error: recipientList[index].deliveryLocationError,
                                  onTap:(){
                                    recipientDeliveryLocation(recipientList[index]);
                                  },
                                  trailIcon: Icons.location_on,
                                  controller: recipientList[index].deliveryLocationTextController,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left:10,right: 10,top: 10),
                                child: MyTextInputField(
                                  label: "Instruction",
                                  maxlines: 5,
                                  controller: recipientList[index].deliveryInstructionController,
                                ),
                              ),
                              SizedBox(height: 20,)
                            ],
                          ),
                        )
                      ],
                    ),
                  )
              );
            },
              itemCount: recipientList.length,
              physics: ClampingScrollPhysics(),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            margin: EdgeInsets.only(left:10,right: 10,top: 10),
            child: Row(
              children: [
                Expanded(
                    child: CustomButton(
                      onPressed: (){
                        setState(() {
                            recipientList.add(
                                new RecipientData(
                                    title: "Recipient ${recipientList.length + 1} Details",
                                    fullnameController: new TextEditingController(),
                                    phoneController: new TextEditingController(),
                                    deliveryInstructionController: new TextEditingController(),
                                    deliveryLocationTextController: new TextEditingController(),
                                    cardExpanded: false,
                                    iAmTheRecipient: false,
                                    locationLatitude: "",
                                    locationLongitude: "",
                                    fullNameError: false,
                                    phoneError: false,
                                    deliveryLocationError: false
                                )
                            );
                          });
                          changeRecipientSizedBoxHeight();
                      },
                      title:  "Add Recipient",
                      height: 50,
                    )
                )
              ],
            ),
          ),
          Container(
            height: 50,
            margin: EdgeInsets.only(left:10,right: 10,top: 10),
            child: Row(
              children: [
                Expanded(
                    child: CustomButton(
                      height: 50,
                      title:"Previous",
                      onPressed: (){
                        vm2.tabController.animateTo(1);
                      },
                      )
                    
                  
                ),
                SizedBox(width: 10,),
                Expanded(
                    child: CustomButton(
                      height: 50,
                      title: 'Next',
                      onPressed: (){
                        checkRecipientData();
                      },
                    )
                    
                  

                ),
              ],
            ),
          ),

        ],
      );
    },
      itemCount: 1,
    );

  }

}