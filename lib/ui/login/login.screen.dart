
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pickappuser/config/locator.dart';
import 'package:pickappuser/constants/images.dart';
import 'package:pickappuser/constants/routes.dart';
import 'package:pickappuser/providers/loginProvider.dart';
import 'package:pickappuser/services/router.service.dart';
import 'package:pickappuser/ui/shared/myTextInput.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget{
  @override
  _LoginScreenstate createState() => _LoginScreenstate();
}
class _LoginScreenstate extends State<LoginScreen>{
  var router = locator<RouterService>();
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<LoginProvider>(context);
    // ignore: non_constant_identifier_names
    double device_width = MediaQuery.of(context).size.width;

    // ignore: non_constant_identifier_names
    double device_height = MediaQuery.of(context).size.height;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login",
          style: TextStyle(
              color: Colors.white
          ),),
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: Colors.purple[900],
      ),
      body: Container(
        width: device_width,
        height: device_height,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
             children: <Widget>[
               Container(
                 height: 120,
                 width: device_width,
                 margin: EdgeInsets.only(top:20),
                 child: Center(
                   child: Image.asset(
                     AppImages.appBanner,
                     width: 150,
                     height: 100,
                   ),
                 ),
               ),
               Container(
                 margin: EdgeInsets.only(top:10),
                 width: 300,
                 height: 60,
                 child: MyTextInputField(
                   label: "Email/Phone Number",
                   controller: vm.emailPhoneCtrl,
                   leadingIcon: true,
                   leadIcon: Icons.perm_identity,
                   textEntryType: TextInputType.text,
                   error: vm.emailPhoneError,
                   errorText: vm.emailPhoneErrorMessage,
                 ),
               ),
               Container(
                 margin: EdgeInsets.only(top:5),
                 width: 300,
                 height: 60,
                 child: MyTextInputField(
                   label: "Password",
                   controller: vm.passwordCtrl,
                   leadingIcon: true,
                   leadIcon: Icons.lock,
                   textEntryType: TextInputType.text,
                   isPasswordField: true,
                   error: vm.passwordError,
                   errorText: vm.passwordErrorMessage,
                 ),
               ),
               Container(
                 margin: EdgeInsets.only(top:10),
                 width: 300,
                 child: Align(
                     alignment: Alignment.centerRight,
                     child: InkWell(
                       child: Text(
                         "Forgot Password",
                         style: TextStyle(
                             color: Colors.grey
                         ),
                       ),
                       onTap: (){
                         print("Forgot Password clicked");
                       },
                     )
                 ),
               ),
               Container(
                 margin: EdgeInsets.only(top:20),
                 child: ConstrainedBox(
                   constraints: BoxConstraints.tightFor(height: 50,width: 300),
                   child: ElevatedButton(
                     style: ElevatedButton.styleFrom(
                       primary: Colors.amber[900],
                     ),
                     onPressed: (){
                       vm.login(context);
                     },
                     child: Text(
                       "Login",
                       style: TextStyle(
                           color: Colors.white
                       ),
                     ),

                   ),
                 )

               ),
               Container(
                 width: 300,
                 margin: EdgeInsets.only(top:10),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: <Widget>[
                     Text(
                       "Don't have an account?",
                       style: TextStyle(
                           color:Colors.grey
                       ),
                     ),
                     SizedBox(
                       width: 10,
                     ),
                     InkWell(
                       child: Text(
                         "Sign Up",
                         style: TextStyle(
                             color: Colors.amber[900],
                             fontWeight: FontWeight.w700
                         ),
                       ),
                       onTap: (){
                         router.navigateTo(AppRoutes.registrationFromLoginRoute);
                       },
                     )
                   ],
                 ),
               )

             ],
          ),
        ),
      ),
    );
  }

}