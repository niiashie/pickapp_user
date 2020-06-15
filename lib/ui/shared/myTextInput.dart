
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pickappuser/config/locator.dart';
import 'package:pickappuser/services/router.service.dart';

class MyTextInputField extends StatefulWidget{
   final String label;
   final TextEditingController controller;
   final bool leadingIcon;
   final bool trailingIcon;
   final IconData leadIcon;
   final IconData trailIcon;
   final int maxlines;
   final bool error;
   final Function onTap;
   final String errorText;
   final isPasswordField;
   final TextInputType textEntryType;
   final String Function(String) validator;

   const MyTextInputField({
     Key key,
     this.label,
     this.controller,
     this.leadingIcon = false,
     this.trailingIcon = false,
     this.trailIcon,
     this.leadIcon,
     this.error = false,
     this.errorText,
     this.maxlines = 1,
     this.isPasswordField = false,
     this.textEntryType,
     this.validator, this.onTap
   }) : super(key: key);

   @override
   _myTextInputFieldState createState() => _myTextInputFieldState();


}

class _myTextInputFieldState extends State<MyTextInputField> {
  bool _obscureText = true;
  FocusNode myFocusNode = new FocusNode();
  @override
  Widget build(BuildContext context) {
    double device_width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return TextFormField(
        focusNode: myFocusNode,
        validator: widget.validator,
         decoration: InputDecoration(
             contentPadding: EdgeInsets.only(left:15,right: 15,top:10,bottom: 10),
         border: OutlineInputBorder(),
         labelText: widget.label,
         labelStyle: TextStyle(
             color: myFocusNode.hasFocus ? Colors.purple : Colors.grey
         ),
         prefixIcon: widget.leadingIcon?Icon(
           widget.leadIcon,
           color: myFocusNode.hasFocus ?Colors.purple:Colors.grey,
         ):null,
         suffixIcon: widget.trailingIcon?Icon(widget.trailIcon,
           color: myFocusNode.hasFocus ?Colors.purple:Colors.grey, )
             :(widget.isPasswordField ? _buildPasswordFieldVisibilityToggle() : null),
           focusedBorder:OutlineInputBorder(
             borderSide: const BorderSide(color: Colors.purple, width: 2.0),
             borderRadius: BorderRadius.circular(10.0),

           ),
           errorText: widget.error?widget.errorText:null,
       ),
       keyboardType: widget.textEntryType,
       obscureText: widget.isPasswordField?this._obscureText:false,
       controller: widget.controller,
       cursorColor: Colors.purple,
       minLines: 1,
       onTap: widget.onTap ?? null,
       maxLines: widget.maxlines,
       style: TextStyle(
        color: Colors.black
       ),

    );
  }
  Widget _buildPasswordFieldVisibilityToggle() {
    return IconButton(
      icon: Icon(
        _obscureText ? Icons.visibility_off : Icons.visibility,
        color: myFocusNode.hasFocus ? Colors.purple : Colors.grey,
      ),
      onPressed: () {
        setState(() {
          _obscureText = !_obscureText;
        });
      },
    );
  }
}