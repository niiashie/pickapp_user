
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pickappuser/config/locator.dart';
import 'package:pickappuser/constants/images.dart';
import 'package:pickappuser/constants/routes.dart';
import 'package:pickappuser/providers/registrationProvider.dart';
import 'package:pickappuser/services/dialog.service.dart';
import 'package:pickappuser/services/router.service.dart';
import 'package:pickappuser/ui/shared/myTextInput.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget{
  final bool fromLogin ;

  const RegisterScreen({Key key,
    this.fromLogin}) : super(key: key);


  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>{
  var router = locator<RouterService>();
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<RegistrationProvider>(context);
    double device_width = MediaQuery.of(context).size.width;
    double device_height = MediaQuery.of(context).size.height;
    // TODO: implement build
    return Scaffold(
       appBar: AppBar(
         title: Text("Registration",
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
        child: vm.isLoading? Container(
          width: device_width,
          height: device_height,
          color: Colors.white.withOpacity(0.5),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(height: 10),
                Text(
                  "Creating user please wait....",
                  style: TextStyle(
                    color:Colors.black
                  ),
                )
              ],
            ),
          ),
        ) :
        SingleChildScrollView(
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
                  label: "First Name",
                  controller: vm.firstNameCtrl,
                  leadingIcon: true,
                  leadIcon: Icons.perm_identity,
                  textEntryType: TextInputType.text,
                  error: vm.firstNameError,
                  errorText: vm.firstNameErrorMessage,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top:5),
                width: 300,
                height: 60,
                child: MyTextInputField(
                  label: "Last Name",
                  controller: vm.lastNameCtrl,
                  leadingIcon: true,
                  leadIcon: Icons.perm_identity,
                  error: vm.lastNameError,
                  errorText: vm.lastNameErrorMessage,
                  textEntryType: TextInputType.text,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top:5),
                width: 300,
                height: 60,
                child: MyTextInputField(
                  label: "Phone Number",
                  controller: vm.phoneNumberCtrl,
                  leadingIcon: true,
                  leadIcon: Icons.phone,
                  textEntryType: TextInputType.phone,
                  error: vm.phoneNumberError,
                  errorText: vm.phoneNumberErrorMessage,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top:5),
                width: 300,
                height: 60,
                child: MyTextInputField(
                  label: "EMail",
                  controller: vm.emailCtrl,
                  leadingIcon: true,
                  leadIcon: Icons.mail,
                  textEntryType: TextInputType.emailAddress,
                  error: vm.emailError,
                  errorText: vm.emailErrorMessage,
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
                  error: vm.passwordError,
                  errorText: vm.passwordErrorMessage,
                  textEntryType: TextInputType.text,
                  isPasswordField: true,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top:20),
                child: ButtonTheme(
                  minWidth: 300,
                  height: 50,
                  child: RaisedButton(
                    color: Colors.amber[900],
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Colors.amber[900],
                            width: 1,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      "Register",
                      style: TextStyle(
                          color:Colors.white
                      ),
                    ),
                    onPressed: (){
                      vm.registration(context);
                     /* vm.registration().then((res){
                         if(res!=null){
                           if(res.code!=200){
                             DialogService().showAlertDialog(
                               context: context,
                               type: AlertDialogType.error,
                               message: res.message,
                             );
                           }else{
                             DialogService().showAlertDialog(context: context, message:
                             "Registration success, verify registration in your email", type: AlertDialogType.success,
                                 okayText: "Login",onOkayBtnTap: (){
                                   router.navigateTo(AppRoutes.loginScreenRoute);
                              });
                           }
                         }
                      });*/
                    },
                  ),
                ),
              ),
              Container(
                width: 300,
                margin: EdgeInsets.only(top:10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                          color:Colors.grey
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.amber[900],
                            fontWeight: FontWeight.w700
                        ),
                      ),
                      onTap: (){
                        if(widget.fromLogin){
                          Navigator.pop(context);
                          print("From Login");
                        }else{
                          router.navigateTo(AppRoutes.loginScreenRoute);
                        }
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }

}