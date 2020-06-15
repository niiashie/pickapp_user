import 'package:flutter/material.dart';


ThemeData primaryTheme = ThemeData(
  primaryColor: Color(0xFFEF7F1A),
  accentColor: Color(0xFFA0AEC0),
  textTheme: TextTheme(),
  iconTheme: IconThemeData(
    color: Colors.black54,
  ),
 // fontFamily: AppConstants.primaryFont,
  appBarTheme: AppBarTheme(
    color: Colors.white,
    iconTheme: IconThemeData(color: Colors.black54, size: 20.0),
    textTheme: TextTheme(
      title: TextStyle(
        color: Colors.black,
        fontSize: 18.0,
        fontWeight: FontWeight.w600
      ),
    ),
  ),
);
