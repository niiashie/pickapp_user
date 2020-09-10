import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:pickappuser/config/locator.dart';
import 'package:pickappuser/constants/local_storage_name.dart';
import 'package:pickappuser/models/recipient_item.dart';
import 'package:shared_preferences/shared_preferences.dart';



class HttpService {
  String host = "https://pickapp.disonstech.com/api";
  //final localStorage = locator<StorageService>();
 // final localStorage = locator<LocalStorageService>();

  /*Future<http.Response> createPost2() async{
    return http.post(
      "https://api.staging.wa-communicate.com/api",
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept':'application/json',
      },
      body: <String, String>{
        'name': fullNameCtrl.text,
        'username': userNameCtrl.text,
        'phone_number': phonenumberCtrl.text,
        'email': emailAddressCtrl.text,
        'password':passwordCtrl.text,
        'password_confirmation':confirmPasswordCtrl.text,
        'postcode':"+233",
        'country':"GH",
      },

    );
  } */

 /* Future<String> getAuthBearerToken() async {
    return await localStorage.getPref(LocalStorageName.bearerToken);
  } */

  Future<Map<String, String>> getHeaders() async {
    return {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
     // HttpHeaders.authorizationHeader: "Bearer ${await getAuthBearerToken()}",
    };

    // I changed it because get requests didn't recorgnize the
    // authorizationHeader when it was written as string
  }

  Future<http.Response> getUserProfile(String url) async {
    String uri = "$host$url";
    return http.get(uri,
        headers:  await getHeaders());

  }

  /*Future<http.Response>sendForgotPasswordLink(String url,Map<String, String>body)async{
    String uri = "$host$url";
    final httpBody = jsonEncode(body);
    return http.get(
      uri,
      body:httpBody

    );
  }*/


  Future<http.Response> post(String url, Map<String, String> body) async {
    String uri = "$host$url";
    final httpBody = jsonEncode(body);
      return http.post(uri, body: body);


  }

  Future<http.Response>registerUser(String firstName,String lastName,String email,String phoneNumber,String password){
    final uri = 'https://pickapp.disonstech.com/api/register';
    var map = new Map<String, String>();
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['email'] = email;
    map['phone'] = phoneNumber;
    map['password'] = password;
    map['password_confirmation'] = password;

    return http.post(uri,body: map);
  }

  Future<http.Response>getServiceCharge(String distance,String carrierTypeId)async{
    final uri = '$host/charges';
    SharedPreferences preferences =await SharedPreferences.getInstance();

    String token = preferences.getString(LocalStorageName.bearerToken);
    //await localStorage.getPref(LocalStorageName.bearerToken);
    var map = new Map<String, String>();
    map['distance_travelled'] = distance;
    map['carrier_type_id'] = carrierTypeId;

    return http.post(uri,
        headers: {
          'Authorization': 'Bearer $token',
         },
         body: map
        );

  }

  Future<http.Response>getOrders()async{
    SharedPreferences preferences =await SharedPreferences.getInstance();
    String token = preferences.getString(LocalStorageName.bearerToken);

    String uri = "$host/orders";
    return http.get(uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept':'application/json',
        },

    );
  }

  Future<http.Response>saveOrder(String CarrierId,
      String packageId,String quantity,String isSender,String description,String isFragile,
      String cost,String senderName,String senderPhone,String locAddress,String pLat,String pLong,
      List<RecipientData>recipients
      )async{
    SharedPreferences preferences =await SharedPreferences.getInstance();
    String token = preferences.getString(LocalStorageName.bearerToken);
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);

    var map = new Map<String, String>();
    map['carrier_type_id'] = CarrierId;
    map['package_size_id'] = packageId;
    map['quantity'] = quantity;
    map['is_sender'] = isSender;
    map['description'] = description;
    map['is_fragile'] = isFragile;
    map['cost'] = cost;
    map['sender_name'] = senderName;
    map['sender_phone'] = senderPhone;
    map['pickup_location_address'] = locAddress;
    map['pickup_location_latitude'] = pLat;
    map['pickup_location_longitude'] = pLong;
   // map['pickup_at'] = date.toString();
    map['is_within_city'] = "1";

   for(int y=0;y<recipients.length;y++){
      var rng = new Random();
      String random = rng.nextInt(100).toString();
      map["recipients[$y][name]"] = recipients[y].fullnameController.text;
      map["recipients[$y][phone]"] = recipients[y].phoneController.text;
      map["recipients[$y][latitude]"] = recipients[y].locationLatitude;
      map["recipients[$y][longitude]"] = recipients[y].locationLongitude;
      map["recipients[$y][confirmation_code]"] = random;
      map["recipients[$y][delivery_instruction]"] = recipients[y].deliveryInstructionController.text.isNotEmpty? recipients[y].deliveryInstructionController.text : "" ;
      map["recipients[$y][address]"] = recipients[y].deliveryLocationTextController.text;
    }
    String uri = "$host/orders";
    return http.post(uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept':'application/json',
        'Content-Type':'application/x-www-form-urlencoded',
      },
      body: map
    );
  }


  Future<http.Response>getDistanceAndTime(String url){
    return http.get(url);
  }

  Future<http.Response>updateProfile(String firstName,String lastName,String mail,String phone)async{
    SharedPreferences preferences =await SharedPreferences.getInstance();

    String token = preferences.getString(LocalStorageName.bearerToken);
    String userId = preferences.getString(LocalStorageName.userId);

    var map = new Map<String, String>();
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['email'] = mail;
    map['phone'] = phone;

    String url = "$host/users/$userId";
    return http.put(url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept':'application/json',
        'Content-Type':'application/x-www-form-urlencoded',
      },
      body: map
    );
  }

  Future<http.Response>loginUser(String loginType,String userDetail,String password){
    final uri = 'https://pickapp.disonstech.com/api/login';
    var map = new Map<String, String>();
    if(loginType == "email"){
      map['email'] = userDetail;
    }else{
      map['phone'] = userDetail;
    }
    map['password'] = password;

    return http.post(uri,body:map);

  }
  
  Future<http.Response>getCarrierTypes(){
    return http.get("https://beac90b2-7c1a-445b-9835-3d222d804d8a.mock.pstmn.io/carrier-types");
  }

  Future<http.Response>getPackageSizes(){
    return http.get("https://beac90b2-7c1a-445b-9835-3d222d804d8a.mock.pstmn.io/package-sizes");
  }


}
