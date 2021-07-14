
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget{

  final String title;
  final double width;
  final double height;
  final VoidCallback onPressed;
  final bool setWidth;
  final bool setColor;
  final Color backgroundColor;

  const CustomButton({
    Key key,
    this.title,
    this.width,
    this.height,
    this.onPressed,
    this.setWidth = false, this.setColor = false, this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: this.setWidth?BoxConstraints.tightFor(width: this.width,height: this.height):BoxConstraints.tightFor(height: this.height),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
             primary:this.setColor?this.backgroundColor:Colors.amber[900],
          ),
          child: Text(
            this.title,
            style: TextStyle(
              color: Colors.white
            ),
          ),
          onPressed: this.onPressed,
        ),
    );
  }

}