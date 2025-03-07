import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/constants/color_app.dart';

Widget svgImage(
  String urlAsset, {
  double padingValue = 10,
  Color color = ColorApp.primaryColor,
  double hi = 25,
  double wi = 25,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: padingValue),
    child: SvgPicture.asset(
      urlAsset,
      height: hi,
      width: wi,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    ),
  );
}
