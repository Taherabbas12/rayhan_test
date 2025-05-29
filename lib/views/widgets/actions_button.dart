import 'package:flutter/material.dart';
import '../../utils/constants/color_app.dart';
import '../../utils/constants/style_app.dart';
import '../../utils/constants/values_constant.dart';
import 'common/svg_show.dart';

class BottonsC {
  //
  static Widget action1(
    String name,
    void Function()? onPressed, {
    Color color = ColorApp.primaryColor,
    Color colorText = ColorApp.whiteColor,
    double h = 50,
    IconData? icon,
    double? elevation,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Values.circle * 0.2),
      child: MaterialButton(
        color: color,
        height: h,
        elevation: elevation,
        onPressed: onPressed,
        padding: EdgeInsets.symmetric(horizontal: Values.circle * 4),
        hoverElevation: Values.circle,
        hoverColor: ColorApp.greenColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Values.spacerV * 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name,
              style: StringStyle.textButtom.copyWith(color: colorText),
            ),
            if (icon != null)
              Icon(icon, size: 35, color: ColorApp.backgroundColor),
          ],
        ),
      ),
    );
  }

  static Widget action2(
    String name,
    void Function()? onPressed, {
    Color color = ColorApp.primaryColor,
    double h = 50,
    IconData? icon,
    double iconSize = 35,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Values.circle * 0.2),
      child: MaterialButton(
        color: color,
        height: h,
        minWidth: 125,
        elevation: 0.5,
        onPressed: onPressed,
        hoverElevation: Values.circle,
        hoverColor: ColorApp.greenColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Values.circle),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Icon(icon, size: iconSize, color: ColorApp.backgroundColor),
            if (icon != null) SizedBox(width: Values.circle),
            Text(
              name,
              style: StringStyle.textButtom.copyWith(
                color: ColorApp.whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget action3(
    String name, {
    Color colorBorder = ColorApp.primaryColor,
    Color color = ColorApp.subColor,
    void Function()? onPressed,
    double h = 50,
    double iconSize = 35,
    double? circle,
    IconData? icon,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(circle ?? Values.circle),
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        width: 115,
        padding: EdgeInsets.symmetric(
          horizontal: Values.spacerV,
          vertical: Values.circle * 0.8,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(circle ?? Values.circle),
          border: Border.all(color: colorBorder),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) Icon(icon),
            if (icon != null) SizedBox(width: Values.circle),
            Text(name, style: StringStyle.textLabil.copyWith(color: color)),
          ],
        ),
      ),
    );
  }

  //
  static Widget actionPost(
    String name, {
    Color colorBorder = ColorApp.primaryColor,
    Color color = ColorApp.subColor,
    void Function()? onPressed,
    double h = 50,
    double iconSize = 35,
    double? circle,
    IconData? icon,
  }) {
    return MaterialButton(
      // shape: ,
      onPressed: onPressed,
      // splashColor: ColorApp.subColor,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: Values.circle),
        alignment: Alignment.center,
        width: 115,
        // padding: EdgeInsets.symmetric(
        //     horizontal: Values.spacerV, vertical: Values.circle * 0.8),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(circle ?? Values.circle),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) Icon(icon, size: iconSize, color: color),
            if (icon != null) SizedBox(width: Values.circle),
            Text(name, style: StringStyle.headerStyle.copyWith(color: color)),
          ],
        ),
      ),
    );
  }

  //
  static Widget actionIcon(
    IconData icon,
    String name,
    void Function()? onPressed, {
    Color color = ColorApp.primaryColor,
    double size = 30,
    double circle = 4,
    Key? key,
    EdgeInsets? padding,
  }) {
    return Container(
      key: key,
      width: size,
      height: size,
      margin: padding ?? EdgeInsets.symmetric(horizontal: Values.circle * 0.2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(circle),
      ),
      child: IconButton(
        padding: const EdgeInsets.all(0),
        onPressed: onPressed,
        icon: Icon(icon, size: (size * 0.8)),
        tooltip: name,
        color: ColorApp.whiteColor,
      ),
    );
  }

  static Widget actionSvgIcon(
    String urlImage,
    String name,
    void Function()? onPressed, {
    Color colorBackground = ColorApp.primaryColor,
    Color color = ColorApp.primaryColor,
    double size = 30,
    Key? key,
    EdgeInsets? padding,
  }) {
    return Container(
      key: key,
      width: size,
      height: size,
      margin: padding ?? EdgeInsets.symmetric(horizontal: Values.circle * 0.2),
      decoration: BoxDecoration(
        color: colorBackground,
        borderRadius: BorderRadius.circular(Values.circle * 0.4),
      ),
      child: IconButton(
        padding: const EdgeInsets.all(0),
        onPressed: onPressed,
        icon: svgImage(
          urlImage,
          padingValue: 0,
          color: color,
          hi: (size * 0.8),
          wi: (size * 0.8),
        ),
        tooltip: name,
        color: ColorApp.whiteColor,
      ),
    );
  }

  static Widget actionIconWithOutColor(
    IconData icon,
    String name,
    void Function()? onPressed, {
    Color color = ColorApp.backgroundColorContent,
    Color colorBackgraond = ColorApp.whiteColor,
    Color colorBorder = ColorApp.whiteColor,
    double circle = 4,
    double size = 35,
    Key? key,
  }) {
    return Container(
      key: key,
      width: (size + 20),
      height: (size + 20),
      // margin: EdgeInsets.symmetric(horizontal: Values.circle * 0.2),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colorBackgraond,
        border: Border.all(color: colorBorder),
        borderRadius: BorderRadius.circular(circle),
      ),
      child: IconButton(
        padding: const EdgeInsets.all(0),
        onPressed: onPressed,
        icon: Icon(icon, size: size, color: color),
        tooltip: name,
        color: ColorApp.whiteColor,
      ),
    );
  }
}
