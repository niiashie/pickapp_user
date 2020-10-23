
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pickappuser/constants/images.dart';
import 'package:pickappuser/services/dialog.service.dart';


class MyCustomAlertDialog extends StatelessWidget{
  final AlertDialogType type;
  final String message;
  final String okayText;
  final String cancelText;
  final bool showCancelBtn;
  final bool showOkayBtn;
  final VoidCallback onOkayBtnTap;
  final VoidCallback onCancelBtnTap;

  const MyCustomAlertDialog({Key key,
    this.type,
    this.message,
    this.okayText,
    this.cancelText,
    this.showCancelBtn = false,
    this.showOkayBtn,
    this.onOkayBtnTap,
    this.onCancelBtnTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 300,
      height: 300,
      child: Center(
        child: Stack(
          children: [
            Container(
              width: 300,
              margin: EdgeInsets.only(top:40),
              padding: EdgeInsets.only(left:10,right: 10,top:15,bottom: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top:60),
                    child: Text(
                      _chooseTitle(),
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  Text(
                    this.message,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 15,),
                  this.showCancelBtn == false?
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: ButtonTheme(
                          height: 40,
                          child: RaisedButton(
                            color: Colors.amber[900],
                            onPressed: this.onOkayBtnTap,
                            child: Text(
                              this.okayText,
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      )
                    ],
                  ):
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: ButtonTheme(
                          height: 40,
                          child: RaisedButton(
                            color: Colors.amber[900],
                            onPressed: this.onOkayBtnTap,
                            child: Text(
                              this.okayText,
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: ButtonTheme(
                          height: 40,
                          child: RaisedButton(
                            color: Colors.amber[900],
                            onPressed: this.onCancelBtnTap,
                            child: Text(
                              this.cancelText,
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset(chooseImageCategory(),width: 80,height: 80,),
            ),

          ],
        ) ,
      ),
      /* */
    );
  }

  String _chooseTitle() {
      if (type == AlertDialogType.success) {
        return "Success!!!";
      } else if (type == AlertDialogType.error) {
        return "Error!!!";
      } else {
        return "Warning!!!";
      }

  }

  String chooseImageCategory() {
      if (type == AlertDialogType.success) {
        return "assets/images/success.png";
      } else if (type == AlertDialogType.error) {
        return "assets/images/failed2.png";
      }
      else {
        return "assets/images/warning.png";
      }

  }

}