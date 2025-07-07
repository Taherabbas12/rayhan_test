import 'package:flutter/material.dart';

import 'color_app.dart';

class StringStyle {
  static const double fontSize = 1;

  static TextStyle headerStyle = TextStyle(
    fontSize: (18 * fontSize),
    fontWeight: FontWeight.bold,
    color: ColorApp.textPrimaryColor,
  );
  static TextStyle textTable = TextStyle(
    fontSize: (14 * fontSize),
    color: ColorApp.textPrimaryColor,
  );

  static TextStyle textLabil = TextStyle(
    fontSize: (16 * fontSize),
    fontWeight: FontWeight.bold,
    color: ColorApp.blackColor,
  );
  static TextStyle textTitle = TextStyle(
    fontSize: (18 * fontSize),
    color: ColorApp.blackColor,
  );

  static TextStyle textLabilBold = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: (14 * fontSize),
    color: ColorApp.textSecondryColor,
  );
  static TextStyle textButtom = TextStyle(
    fontSize: (20 * fontSize),
    fontWeight: FontWeight.bold,
    color: ColorApp.textThredColor,
  );
  static TextStyle headLineStyle = TextStyle(
    fontSize: (32 * fontSize),
    fontWeight: FontWeight.bold,
    color: ColorApp.backgroundColorContent,
  );
  static TextStyle headLineStyle2 = TextStyle(
    fontSize: (26 * fontSize),
    fontWeight: FontWeight.bold,
    color: ColorApp.primaryColor,
  );
  static TextStyle titleApp = TextStyle(
    fontSize: (24 * fontSize),
    fontWeight: FontWeight.bold,
    color: ColorApp.blackColor,
  );
  // static const titleStyle =
  //     TextStyle(fontSize: 20 * fontSize, color: Colors.white);
  // static const titleBoldStyle = TextStyle(
  //     fontSize: 18 * fontSize,
  //     fontWeight: FontWeight.bold,
  //     color: Colors.black);
  // static const subTitleStyle = TextStyle(
  //     fontSize: 18 * fontSize,
  //     fontWeight: FontWeight.bold,
  //     color: Color.fromARGB(255, 82, 82, 82));
  // static const buttonStyle = TextStyle(
  //     fontSize: 22 * fontSize,
  //     color: ColorApp.whiteColor,
  //     fontWeight: FontWeight.bold);
  // static const buttonStyle3 =
  //     TextStyle(fontSize: 17 * fontSize, color: ColorApp.whiteColor);
  // static const button2Style =
  //     TextStyle(fontSize: 20 * fontSize, color: ColorApp.whiteColor);
  // static const leadingStyle = TextStyle(
  //     fontSize: 14 * fontSize, color: Color.fromARGB(255, 192, 192, 192));
  // static const hintText =
  //     TextStyle(fontSize: 16 * fontSize, color: Color(0xff717171));
}
