
import 'package:flutter/material.dart';
import 'package:pickappuser/constants/images.dart';

class PageIndicator extends StatelessWidget{
  final bool firstIndicator;
  final bool secondIndicator;
  final bool thirdIndicator;

  const PageIndicator({Key key,
    this.firstIndicator = false,
    this.secondIndicator = false,
    this.thirdIndicator = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double device_width = MediaQuery.of(context).size.width;

    final middleLine = Container(
      width: 70,
      height: 40,
      child: Center(
        child: Divider(
          color: Colors.grey,
        ),
      ),
    );
    final horizontalSpace = SizedBox(width: 10);

    final checked = Image.asset(AppImages.checked, width: 20,height: 20);

    final unchecked = Image.asset(AppImages.unchecked,width: 20,height: 20);
    // TODO: implement build
    return Container(
       width: device_width,
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 40,
            width: 20,
            child: Center(
              child: this.firstIndicator?checked:unchecked,
            ),
          ),
          horizontalSpace,
          middleLine,
          horizontalSpace,
          Container(
            height: 40,
            width: 20,
            child: Center(
              child: this.secondIndicator?checked:unchecked,
            ),
          ),
          horizontalSpace,
          middleLine,
          horizontalSpace,
          Container(
            height: 40,
            width: 20,
            child: Center(
              child: this.thirdIndicator?checked:unchecked,
            ),
          ),
        ],
      ),
    );
  }

}