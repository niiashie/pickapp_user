
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pickappuser/ui/shared/myTextInput.dart';

class RecipientCard extends StatefulWidget{
  final String recipientTitle;
  final TextEditingController fullNameController;
  final TextEditingController phoneController;
  final TextEditingController deliveryLocationController;
  final TextEditingController deliveryInstructionController;
  final TextEditingController iAmTheRecipientController;
  final Function() deleteRecipient;

  const RecipientCard({Key key,
    this.recipientTitle,
    this.fullNameController,
    this.phoneController,
    this.deliveryLocationController,
    this.deliveryInstructionController, this.deleteRecipient, 
    this.iAmTheRecipientController,
    }) : super(key: key);



  @override
  _RecipientCardState createState() => _RecipientCardState();
}
class _RecipientCardState extends State<RecipientCard>{
  @override
  Widget build(BuildContext context) {
    double device_width = MediaQuery.of(context).size.width;
    bool cardExpanded = true;
    bool iAmTheRecipientValue = false;
    // TODO: implement build
    return Container(
       width: device_width,
      margin: EdgeInsets.only(left:20,right:20),
      child: Card(
        elevation: 3,
        child: Column(
          children: <Widget>[
            Container(
              height: 60,
              margin: EdgeInsets.only(left:10,right: 10),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: cardExpanded ?
                    IconButton(
                      icon: Icon(Icons.arrow_drop_down,size: 20,color: Colors.grey,),
                      onPressed: (){
                        setState(() {
                          cardExpanded = !cardExpanded;
                        });
                      },
                    )
                        :IconButton(
                         icon: Icon(Icons.arrow_drop_up,color:Colors.grey),
                      onPressed: (){
                           setState(() {
                             cardExpanded = !cardExpanded;
                           });
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.only(left:30),
                      child: Text(
                        widget.recipientTitle,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(Icons.delete,color: Colors.grey,size: 20,),
                      onPressed: widget.deleteRecipient(),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Divider(color: Colors.grey,),
                  )
                ],
              ),
            ),
            Visibility(
              visible: cardExpanded,
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
                            value: iAmTheRecipientValue,
                            activeColor: Colors.amber[900],
                            onChanged: (bool newValue){
                              setState(() {
                                iAmTheRecipientValue = newValue;
                                if(iAmTheRecipientValue == true){
                                  widget.iAmTheRecipientController.text = "true";
                                }
                                else{
                                  widget.iAmTheRecipientController.text = "false";
                                }
                              });
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
                      controller: widget.fullNameController,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left:10,right: 10,top: 10),
                    child: MyTextInputField(
                      label: "Phone",
                      textEntryType: TextInputType.phone,
                      controller: widget.phoneController,
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
                      trailIcon: Icons.location_on,
                      controller: widget.deliveryLocationController,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left:10,right: 10,top: 10),
                    child: MyTextInputField(
                      label: "Instruction",
                      maxlines: 5,
                      controller: widget.deliveryInstructionController,
                    ),
                  ),
                  SizedBox(height: 20,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}