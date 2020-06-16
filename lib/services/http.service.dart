import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;


class HttpService {
  String host = "https://pickapp.disonstech.com/api/";
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
